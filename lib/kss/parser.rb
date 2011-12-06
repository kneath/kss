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
        root_node = Sass::SCSS::Parser.new(File.read(filename), filename).parse
        root_node.children.each do |node|
          next unless node.is_a? Sass::Tree::CommentNode
          comment_text = self.class.clean_comments node.value[0]

          if self.class.kss_block? comment_text
            base_name = File.basename(filename)
            section = Section.new(comment_text, base_name)
            @sections[section.section] = section
          end
        end
      end
    end

    # Public: Takes a cleaned (no comment syntax like // or /* */) comment
    # block and determines whether it is a KSS documentation block.
    #
    # Returns a boolean indicating whether the block conforms to KSS.
    def self.kss_block?(cleaned_comment)
      return false unless cleaned_comment.is_a? String

      possible_reference = cleaned_comment.split("\n\n").last
      possible_reference =~ /Styleguide \d/i
    end

    # Takes the raw comment text including comment syntax and strips all
    # comment syntax and normalizes the indention and whitespace to generate
    # a clean comment block.
    #
    # Returns a claned comment String.
    def self.clean_comments(text)
      text.strip!

      # SASS generated comment syntax
      text.gsub!(/(\/\* )?( \*\/)?/, '') # [/* + space] or [space + */]
      text.gsub!(/\n\s\* ?/, "\n") # * in front of every line

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
