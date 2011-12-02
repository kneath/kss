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
      Dir["#{base_path}/**/*.*"].each do |filename|
        root_node = Sass::SCSS::Parser.new(File.read(filename), filename).parse
        root_node.children.each do |node|
          next unless node.is_a? Sass::Tree::CommentNode
          comment_text = node.value[0].gsub(/(\/\* )?( \*\/)?/, '').gsub(/(\n \*)/, "\n")
          reference = comment_text.split("\n").last

          # Does this comment block end with a Styleguide reference?
          if reference =~ /Styleguide \d/i
            reference.strip!
            reference.sub!(/\.$/, '') # Kill trailing period
            section = reference.match(/Styleguide (.+)/)[1]
            base_name = File.basename(filename)
            @sections[section] = StyleguideSection.new(section, comment_text, base_name)
          end
        end
      end
    end

  end
end
