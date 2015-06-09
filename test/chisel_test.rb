require 'simplecov'
SimpleCov.start

require_relative "../lib/chisel"
require_relative "../lib/renderer"
require_relative "../lib/emphasizer"

class ChiselTest < Minitest::Test
  def test_acceptance_test
    # too low level.
    sample_text = "#Hello, *world*\n\nHello, **world**"

    chunks = ChunkMaker.make(sample_text)

    assert_equal ["#Hello, *world*", "Hello, **world**"], chunks

    rendered = Renderer.render(chunks)

    assert_equal ["<h1>Hello, *world*</h1>", "<p>Hello, **world**</p>"], rendered

    emphasized = Emphasizer.emphasize(rendered)

    assert_equal ["<h1>Hello, <em>world</em></h1>", "<p>Hello, <strong>world</strong></p>"], emphasized
  end

  def test_it_passes_text_to_chunk_maker
    sample_text = "#Hello, *world*\n\nHello, **world**"
    chisel = Chisel.new(sample_text)

    assert_equal ["#Hello, *world*", "Hello, **world**"], chisel.call_chunk_maker(sample_text)
  end

  def test_it_passes_chunked_text_to_renderer
    sample_text = ["#Hello, *world*", "Hello, **world**"]
    chisel = Chisel.new(sample_text)

    expected = ["<h1>Hello, *world*</h1>", "<p>Hello, **world**</p>"]
    assert_equal expected, chisel.call_renderer(sample_text)
  end

  def test_it_passes_rendered_text_to_emphasizer
    sample_text = ["<h1>Hello, *world*</h1>", "<p>Hello, **world**</p>"]
    chisel = Chisel.new(sample_text)

    expected = ["<h1>Hello, <em>world</em></h1>", "<p>Hello, <strong>world</strong></p>"]
    assert_equal expected, chisel.call_emphasizer(sample_text)
  end

end
