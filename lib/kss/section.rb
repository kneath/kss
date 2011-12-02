module Kss
  # Public: Represents a styleguide section. Each section describes one UI
  # element. A Section can be thought of as the collection of the description,
  # modifiers, and styleguide reference.
  class Section

    # Returns the raw comment text for the section, not including comment
    # syntax (such as // or /* */).
    attr_reader :raw

    # Public: Returns the section reference as a String (ex: "2.1.8").
    attr_reader :section

    # Public: Returns the filename where this section is found.
    attr_reader :filename

    # Public: Initialize a new Section
    #
    # comment_text - The raw comment String, minus any comment syntax.
    # filename     - The filename as a String.
    def initialize(comment_text=nil, filename=nil)
      @raw = comment_text
      @filename = filename
    end

    # Splits up the raw comment text into comment sections that represent
    # description, modifiers, etc.
    #
    # Returns an Array of comment Strings.
    def comment_sections
      @comment_sections ||= raw ? raw.split("\n\n") : []
    end

    # Public: The description section of a styleguide comment block.
    #
    # Returns the description String.
    def description
      comment_sections.first
    end

    # Public: The modifiers section of a styleguide comment block.
    #
    # Returns an Array of Modifiers.
    def modifiers
      last_indent = nil
      modifiers = []
      return modifiers unless comment_sections[1]

      comment_sections[1].split("\n").each do |line|
        next if line.strip.empty?
        indent = line.scan(/^\s*/)[0].to_s.size

        if last_indent && indent > last_indent
          modifiers.last.description += line.squeeze(" ")
        else
          modifier, desc = line.split(" - ")
          modifiers << Modifier.new(modifier.strip, desc.strip) if modifier && desc
        end

        last_indent = indent
      end

      modifiers
    end

  end
end
