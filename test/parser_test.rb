require 'test/helper'

class ParserTest < Kss::Test

  def setup
    @scss_parsed = Kss::Parser.new('test/fixtures/scss')
    @sass_parsed = Kss::Parser.new('test/fixtures/sass')
    @css_parsed = Kss::Parser.new('test/fixtures/css')
    @less_parsed = Kss::Parser.new('test/fixtures/less')
    @multiple_parsed = Kss::Parser.new('test/fixtures/scss', 'test/fixtures/less')
  end

  test "parses KSS comments in SCSS" do
    assert_equal 'Your standard form button.',
      @scss_parsed.section('2.1.1').description
  end

  test "parses KSS keys that are words in SCSS" do
    assert_equal 'A big button',
      @scss_parsed.section('Buttons.Big').description
  end

  test "parsers KSS comments in LESS" do
    assert_equal 'Your standard form button.',
      @less_parsed.section('2.1.1').description
  end

  test "parses KSS keys that are words in LESS" do
    assert_equal 'A big button',
      @less_parsed.section('Buttons.Big').description
  end

  test "parses KSS multi-line comments in SASS (/* ... */)" do
    assert_equal 'Your standard form button.',
      @sass_parsed.section('2.1.1').description
  end

  test "parses KSS single-line comments in SASS (// ... )" do
    assert_equal 'A button suitable for giving stars to someone.',
      @sass_parsed.section('2.2.1').description
  end

  test "parses KSS keys that are words in in SASS" do
    assert_equal 'A big button',
      @sass_parsed.section('Buttons.Big').description
  end

  test "parses KSS comments in CSS" do
    assert_equal 'Your standard form button.',
      @css_parsed.section('2.1.1').description
  end

  test "parses KSS keys that are words in CSS" do
    assert_equal 'A big button',
      @css_parsed.section('Buttons.Big').description
  end

  test "parses KSS keys that word phases in CSS" do
    assert_equal 'A button truly lime in color',
      @css_parsed.section('Buttons - Truly Lime').description
  end

  test "parses nested SCSS documents" do
    assert_equal "Your standard form element.", @scss_parsed.section('3.0.0').description
    assert_equal "Your standard text input box.", @scss_parsed.section('3.0.1').description
  end

  test "parses nested LESS documents" do
    assert_equal "Your standard form element.", @less_parsed.section('3.0.0').description
    assert_equal "Your standard text input box.", @less_parsed.section('3.0.1').description
  end

  test "parses nested SASS documents" do
    assert_equal "Your standard form element.", @sass_parsed.section('3.0.0').description
    assert_equal "Your standard text input box.", @sass_parsed.section('3.0.1').description
  end

  test "public sections returns hash of sections" do
    assert_equal 4, @css_parsed.sections.count
  end

  test "parse multiple paths" do
    assert_equal 7, @multiple_parsed.sections.count
  end

  test "parse from string" do
    scss_input =<<-'EOS'
    // Your standard form element.
    //
    // Styleguide 3.0.0
    form {

      // Your standard text input box.
      //
      // Styleguide 3.0.1
      input[type="text"] {
        border: 1px solid #ccc;
      }
    }
    EOS
    assert_equal "Your standard form element.", Kss::Parser.new(scss_input).section('3.0.0').description
    assert_equal "Your standard text input box.", @sass_parsed.section('3.0.1').description
  end

  test "parse with no styleguide reference comment" do
    scss_input =<<-'EOS'
      // Nothing here
      //
      // No styleguide reference.
      input[type="text"] {
        border: 1px solid #ccc;
      }
    EOS

    assert Kss::Parser.new(scss_input)
  end
end
