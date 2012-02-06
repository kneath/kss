require 'test/helper'

class CommentParser < Kss::Test

  def setup
    loc = 'test/fixtures/comments.txt'
    @parsed_comments = Kss::CommentParser.new(loc).blocks
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