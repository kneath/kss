require 'test/helper'

class CommentParser < Kss::Test

  def setup
    loc = 'test/fixtures/comments.txt'
    @parsed_comments = Kss::CommentParser.new(loc).blocks
  end

  test "detects single-line comment syntax" do
    assert Kss::CommentParser.single_line_comment?("// yuuuuup")
    assert !Kss::CommentParser.single_line_comment?("nooooope")
  end

  test "detects start of multi--line comment syntax" do
    assert Kss::CommentParser.start_multi_line_comment?("/* yuuuuup")
    assert !Kss::CommentParser.start_multi_line_comment?("nooooope")
  end

  test "detects end of multi-line comment syntax" do
    assert Kss::CommentParser.end_multi_line_comment?(" yuuuuup */")
    assert !Kss::CommentParser.end_multi_line_comment?("nooooope")
  end

  test "parses the single-line comment syntax" do
    assert_equal " yuuuuup", Kss::CommentParser.parse_single_line("// yuuuuup")
  end

  test "parses the multi-line comment syntax" do
    assert_equal " yuuuup ", Kss::CommentParser.parse_multi_line("/* yuuuup */")
  end

  test "finds single-line comment styles" do
    expected  = <<comment
This comment block has comment identifiers on every line.

Fun fact: this is Kyle's favorite comment syntax!
comment
    assert @parsed_comments.include? expected.rstrip
  end

  test "finds block-style comment styles" do
        expected  = <<comment
This comment block is a block-style comment syntax.

There's only two identifier across multiple lines.
comment
    assert @parsed_comments.include? expected.rstrip


      expected  = <<comment
This is another common multi-line comment style.

It has stars at the begining of every line.
comment
  assert @parsed_comments.include? expected.rstrip

  end

  test "handles mixed styles" do
    expected = "This comment has a /* comment */ identifier inside of it!"
    assert @parsed_comments.include? expected

    expected = "Look at my //cool// comment art!"
    assert @parsed_comments.include? expected
  end

  test "handles indented comments" do
    assert @parsed_comments.include? "Indented single-line comment."
    assert @parsed_comments.include? "Indented block comment."
  end

end