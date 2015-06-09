require_relative '../lib/parser'

class ParserTest < Minitest::Test
  def test_it_exists
    assert Parser.new
  end

  def test_it_parses_in_a_strikethrough_when_it_sees_the_double_squiggly
    #~~Mistaken text.~~
    input = "~~Mistaken text.~~"
    output = Parser.parse(input)
    expected = "<def>Mistaken text.</def>"
    assert_equal expected, output
  end

  def test_it_parses_in_a_strikethrough_when_it_sees_a_super_simple_string
    #~~a~~
    input = "~~a~~"
    output = Parser.parse(input)
    expected = "<def>a</def>"
    assert_equal expected, output
  end
end
