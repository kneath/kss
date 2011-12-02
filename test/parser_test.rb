require 'test/helper'

class ParserTest < Kss::Test

  def setup
    @scss_parsed = Kss::Parser.new('test/fixtures/scss')
    @css_parsed = Kss::Parser.new('test/fixtures/css')

    @css_comment = <<comment
/*
A button suitable for giving stars to someone.

.star-given - A highlight indicating you've already given a star.
.disabled   - Dims the button to indicate it cannot be used.

Styleguide 2.2.1.
*/
comment

  @starred_css_comment = <<comment
/* A button suitable for giving stars to someone.
 *
 * .star-given - A highlight indicating you've already given a star.
 * .disabled   - Dims the button to indicate it cannot be used.
 *
 * Styleguide 2.2.1. */
comment

  @cleaned_css_comment = <<comment
A button suitable for giving stars to someone.

.star-given - A highlight indicating you've already given a star.
.disabled   - Dims the button to indicate it cannot be used.

Styleguide 2.2.1.
comment
  @cleaned_css_comment.rstrip!

  end

  test "parses KSS comments in SCSS" do
    assert_equal 'Your standard form button.',
      @scss_parsed.section('2.1.1').description
  end

  test "parses KSS comments in CSS" do
    assert_equal 'Your standard form button.',
      @css_parsed.section('2.1.1').description
  end

  test "cleans css comments" do
    assert_equal @cleaned_css_comment,
      Kss::Parser.clean_comments(@css_comment)
    assert_equal @cleaned_css_comment,
      Kss::Parser.clean_comments(@starred_css_comment)
  end

end