require_relative "../lib/renderer"

class RendererTest < Minitest::Test
  def test_it_takes_in_a_text_block_and_returns_the_correct_html_signs_instead_as_an_array
    sample_text = ["#Hello, *world*", "Hello, **world**"]
    renderer = Renderer.render(sample_text)

    assert_equal ["<h1>Hello, *world*</h1>", "<p>Hello, **world**</p>"], renderer
  end
end
