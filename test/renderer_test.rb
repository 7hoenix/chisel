require_relative "../lib/renderer"

class RendererTest < Minitest::Test
  def test_it_exists
    assert Renderer.new("")
  end
end
