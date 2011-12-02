module Kss
  # Public: Represents a style modifier. Usually a class name or a
  # pseudo-class such as :hover. See the spec on The Modifiers Section for
  # more information.
  class Modifier

    # Public: Returns the modifier name String.
    attr_accessor :name

    # Public: Returns the description String for a Modifier.
    attr_accessor :description

    # Public: Initialize a new Modifier.
    #
    # name        - The name String of the modifier.
    # description - The description String of the modifier.
    def initialize(name, description=nil)
      @name = name.to_s
      @description = description
    end

    # Public: The modifier name as a CSS class. For pseudo-classes, a
    # generated class name is returned. Useful for generating styleguides.
    #
    # Examples
    #
    #   :hover => "pseudo-class-hover"
    #   sexy-button => "sexy-button"
    #
    # Returns a CSS class String.
    def class_name
      name.sub('.', ' ').sub(':', ' pseudo-class-').strip
    end

  end
end
