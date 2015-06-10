require 'simplecov'
SimpleCov.start

require "minitest/autorun"
require "minitest/pride"

require_relative "../lib/chisel"


class ChiselTest < Minitest::Test
  attr_reader :chisel
  def setup
    input_file = "./lib/sample_input.markdown"
    @chisel = Chisel.new(input_file)
  end

  def test_it_gets_the_input_text_from_the_input_file
    actual = chisel.get_input_text
    expected = "#Hello, *world*\n\nHello, **world**\n"
    assert_equal expected, actual
  end

  def test_it_gets_the_chunked_text_from_the_chunk_maker
    actual = chisel.get_chunks
    expected = ["#Hello, *world*", "Hello, **world**\n"]
    assert_equal expected, actual
  end

  def test_it_gets_rendered_text_from_the_renderer
    actual = chisel.get_rendered
    expected = ["<h1>Hello, *world*</h1>", "<p>Hello, **world**\n</p>"]
    assert_equal expected, actual
  end

  def test_it_gets_emphasized_text_back_from_the_emphasizer
    actual = chisel.get_emphasis
    expected = ["<h1>Hello, <em>world</em></h1>", "<p>Hello, <strong>world</strong>\n</p>"]
    assert_equal expected, actual
  end

  def test_it_sends_the_html_to_the_output_file
    skip
    output_file = "./lib/sample_output.html"
    chisel = Chisel.new(input_file, output_file)

    actual = chisel.write_output_file
    expected = ["<h1>Hello, <em>world</em></h1>", "<p>Hello, <strong>world</strong></p>"]
    assert_equal expected, actual
  end
end
