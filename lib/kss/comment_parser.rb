module Kss
  # Takes a file path of a text file and extracts comments from it. Currently
  # accepts two formats:
  #
  # // Single line style.
  # /* Multi-line style. */
  class CommentParser

    attr_reader :blocks

    # Initializes a new comment parser object. Does not parse on
    # initialization.
    #
    # file_path - The location of the file to parse as a String.
    # options   - Optional options hash.
    #   :preserve_whitespace - Preserve the whitespace before/after comment
    #                          markers (default:true).
    #
    def initialize(file_path, options={})
      options[:preserve_whitespace] = true if options[:preserve_whitespace].nil?
      @blocks = []
    end

  end
end