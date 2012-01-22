module Kss
  # Public: The main KSS parser. Takes a directory full of SASS / SCSS / CSS
  # files and parses the KSS within them.
  class Parser

    # Public: Initializes a new parser based on a directory of files. Scans
    # within the directory recursively for any comment blocks that look like
    # KSS.
    #
    # base_path - The path String where style files are located.
    def initialize(base_path)
      @sections = {}

      Dir["#{base_path}/**/*.*"].each do |filename|
        if File.extname(filename) == ".less"
          tree = Less::Parser.new(:paths => [base_path], :filename => filename).
            # HACK: get the internal JS tree object
            parse(File.read(filename)).instance_variable_get "@tree"

          # inject less.js into a new V8 context
          less = Less.instance_variable_get "@less"
          cxt = V8::Context.new
          cxt['less'] = less

          # parse node tree for comments
          parse_v8_node(cxt, tree, filename)
        else
          if filename.match(/\.css$/)
            root_node = Sass::SCSS::Parser.new(File.read(filename), filename).parse
          else
            root_node = Sass::Engine.for_file(filename, {}).to_tree
          end
          parse_sass_node(root_node, filename)
        end
      end
    end

    # Given a Sass::Tree::Node, find all CommentNodes and populate @sections
    # with parsed Section objects.
    #
    # parent_node - A Sass::Tree::Node to start at.
    # filename    - The filename String this node is found at.
    #
    # Returns the Sass::Tree::Node given.
    def parse_sass_node parent_node, filename
      parent_node.children.each do |node|
        unless node.is_a? Sass::Tree::CommentNode
          parse_sass_node(node, filename) if node.has_children
          next
        end
        add_section node.to_scss, filename
      end
      parent_node
    end

    def parse_v8_node cxt, parent_node, filename
      parent_node.rules.each do |node|
        # inject the current to into JS context
        cxt['node'] = node

        unless cxt.eval "node instanceof less.tree.Comment"
          parse_v8_node(cxt, node, filename) if cxt.eval 'node.rules != null'

          next
        end

        add_section node.value, filename
      end

      parent_node
    end

    def add_section comment, filename
      comment_text = self.class.clean_comments comment

      if self.class.kss_block? comment_text
        base_name = File.basename(filename)
        section = Section.new(comment_text, base_name)
        @sections[section.section] = section
      end
    end

    # Public: Takes a cleaned (no comment syntax like // or /* */) comment
    # block and determines whether it is a KSS documentation block.
    #
    # Returns a boolean indicating whether the block conforms to KSS.
    def self.kss_block?(cleaned_comment)
      return false unless cleaned_comment.is_a? String

      possible_reference = cleaned_comment.split("\n\n").last
      possible_reference =~ /Styleguide \d/
    end

    # Takes the raw comment text including comment syntax and strips all
    # comment syntax and normalizes the indention and whitespace to generate
    # a clean comment block.
    #
    # Returns a claned comment String.
    def self.clean_comments(text)
      text.strip!

      # SASS generated multi-line comment syntax
      text.gsub!(/(\/\* )?( \*\/)?/, '') # [/* + space] or [space + */]
      text.gsub!(/\n\s\* ?/, "\n") # * in front of every line

      # SASS generated single-line comment syntax
      text.gsub!(/\/\/ /, '') # [// + space]
      text.gsub!(/\/\/\n/, "\n") # [// + carriage return]

      # Manual generated comment syntax
      text.gsub!(/^\/\*/, '') # starting block
      text.gsub!(/\*\/$/, '') # ending block

      text.gsub!(/^[ \t]+/, '') # remove leading whitespace

      text.strip!
      text
    end

    # Public: Finds the Section for a given styleguide reference.
    #
    # Returns a Section for a reference, or a blank Section if none found.
    def section(reference)
      @sections[reference] || Section.new
    end

  end
end
