require 'simplecov'
SimpleCov.start

require_relative "../lib/chisel"

class ChiselTest < Minitest::Test
  def test_acceptance_test
    sample_text = "*Hello, world/n/nHello, world"
    chisel = Chisel.new(sample_text)

    assert chisel

    rendered = Renderer.new(sample_text)
    text_blocks = []
    rendered.each { |text| text_blocks << text }

    assert_equal "<h1>Hello, world</h1>", text_blocks[0]
    assert_equal "<p>Hello, world</p>", text_blocks[1]
  end

  def test_it_exits
    assert Chisel.new("")
  end
end
