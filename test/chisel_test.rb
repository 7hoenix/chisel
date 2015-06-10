require 'simplecov'
SimpleCov.start

require_relative "../lib/chisel"
require_relative "../lib/renderer"
require_relative "../lib/emphasizer"

class ChiselTest < Minitest::Test
  def test_acceptance_test
    skip
    # $ ruby chisel.rb my_input.markdown my_output.html
    # Markdown text is: "#Hello *world*\n\nHello, **world**"
    input_file = "./lib/sample_input.markdown"
    output_file = "./lib/sample_output.html"
    chisel = Chisel.new( input_file, output_file )
    output_text = chisel

    expected_html_text = ["<h1>Hello, <em>world</em></h1>", "<p>Hello, <strong>world</strong></p>"]

    assert_equal expected_html_text, output_text

  end

  def test_integration_test

    sample_text = "#Hello, *world*\n\nHello, **world**"

    chunks = ChunkMaker.make(sample_text)

    assert_equal ["#Hello, *world*", "Hello, **world**"], chunks

    rendered = Renderer.render(chunks)

    assert_equal ["<h1>Hello, *world*</h1>", "<p>Hello, **world**</p>"], rendered

    emphasized = Emphasizer.emphasize(rendered)

    assert_equal ["<h1>Hello, <em>world</em></h1>", "<p>Hello, <strong>world</strong></p>"], emphasized
  end

  def test_it_passes_text_to_chunk_maker
    input_file = "./lib/sample_input.markdown"
    chisel = Chisel.new(input_file)
    input_text = chisel.get_input_text

    chunked_text = chisel.call_chunk_maker(input_text)

    assert_equal ["#Hello, *world*", "Hello, **world**\n"], chunked_text
  end

  def test_it_passes_chunked_text_to_renderer
    input_file = "./lib/sample_input.markdown"
    chisel = Chisel.new(input_file)
    chunked_text = ["#Hello, *world*", "Hello, **world**\n"]

    rendered_text = chisel.call_renderer(chunked_text)

    expected = ["<h1>Hello, *world*</h1>", "<p>Hello, **world**\n</p>"]
    assert_equal expected, rendered_text
  end

  def test_it_passes_rendered_text_to_emphasizer
    input_file = "./lib/sample_input.markdown"
    chisel = Chisel.new(input_file)
    rendered_text = ["<h1>Hello, *world*</h1>", "<p>Hello, **world**\n</p>"]
    emphasized_text = chisel.call_emphasizer(rendered_text)

    expected = ["<h1>Hello, <em>world</em></h1>", "<p>Hello, <strong>world</strong>\n</p>"]
    assert_equal expected, emphasized_text
  end

end
