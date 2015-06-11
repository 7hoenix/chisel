require_relative "../lib/link_maker"

class LinkMakerTest < Minitest::Test

  def test_it_assigns_the_url_correctly
    example = ["[This link](http://example.net/) has no title attribute."]
    actual = LinkMaker.find_link(example)

    expected = ["<a href=\"http://example.net/\">This link</a> has no title attribute."]
    assert_equal expected, actual
  end

  def test_it_assigns_the_correct_url_with_a_different_example
    example = ["This is [an example](http://example.com/ \"Domain_Title\")inline link. [This link](http://example.net/) has no title attribute."]
    actual = LinkMaker.find_link(example)

    expected = ["This is <a href=\"http://example.com/\" title=\"Domain_Title\">an example</a>inline link. " +
               "<a href=\"http://example.net/\">This link</a> has no title attribute."]
    assert_equal expected, actual
  end
end
