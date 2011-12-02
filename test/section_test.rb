require 'test/helper'

class SectionTest < Kss::Test

  def setup
    @comment_text = <<comment
Your standard form button.

:hover    - Highlights when hovering.
:disabled - Dims the button when disabled.
.primary  - Indicates button is the primary action.
.smaller  - A smaller button

Styleguide 2.1.1.
comment

    @section = Kss::Section.new(@comment_text, 'example.css')
  end

  test "parses the description" do
    assert_equal "Your standard form button.", @section.description
  end

  test "parses the modifiers" do
    assert_equal 4, @section.modifiers.size
  end

  test "parses a modifier's names" do
    assert_equal ':hover', @section.modifiers.first.name
  end

  test "parses a modifier's description" do
    assert_equal 'Highlights when hovering.', @section.modifiers.first.description
  end

  test "parses the styleguide reference" do
    assert_equal '2.1.1', @section.section
  end

end