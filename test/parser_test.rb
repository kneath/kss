require 'test/helper'

class ParserTest < Kss::Test

  def setup
    @scss_parsed = Kss::Parser.new('test/fixtures/scss')
    @sass_parsed = Kss::Parser.new('test/fixtures/sass')
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

  @slashed_css_comment = <<comment
// A button suitable for giving stars to someone.
//
// .star-given - A highlight indicating you've already given a star.
// .disabled   - Dims the button to indicate it cannot be used.
//
// Styleguide 2.2.1.
comment

  @indented_css_comment = <<comment
  /*
  A button suitable for giving stars to someone.

  .star-given - A highlight indicating you've already given a star.
  .disabled   - Dims the button to indicate it cannot be used.

  Styleguide 2.2.1.
  */
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

  test "parses KSS multi-line comments in SASS (/* ... */)" do
    assert_equal 'Your standard form button.',
      @sass_parsed.section('2.1.1').description
  end

  test "parses KSS single-line comments in SASS (// ... )" do
    assert_equal 'A button suitable for giving stars to someone.',
      @sass_parsed.section('2.2.1').description
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
    assert_equal @cleaned_css_comment,
      Kss::Parser.clean_comments(@slashed_css_comment)
    assert_equal @cleaned_css_comment,
      Kss::Parser.clean_comments(@indented_css_comment)
  end

  test "parses nested SCSS documents" do
    assert_equal "Your standard form element.", @scss_parsed.section('3.0.0').description
    assert_equal "Your standard text input box.", @scss_parsed.section('3.0.1').description
  end

  test "parses nested SASS documents" do
    assert_equal "Your standard form element.", @sass_parsed.section('3.0.0').description
    assert_equal "Your standard text input box.", @sass_parsed.section('3.0.1').description
  end

end
