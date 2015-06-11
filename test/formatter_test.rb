require_relative "../lib/formatter"

class FormatterTest < Minitest::Test
  def test_it_takes_in_an_array_and_returns_a_nice_string_with_new_line_chars
    sample = ["1", "2", "3"]
    actual = Formatter.format(sample)

    expected = "1\n2\n3"
    assert_equal expected, actual
  end
end
