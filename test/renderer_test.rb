require "minitest/autorun"
require "minitest/pride"

require_relative "../lib/renderer"

class RendererTest < Minitest::Test

  def test_it_takes_in_a_block_with_multiple_numbers
    sample_text = ["\n1. cake\n2. cupcake\n3. **my cupcake**"]
    renderer = Renderer.new(sample_text)

    expected = ["<ol><li>cake</li><li>cupcake</li><li>**my cupcake**</li></ol>"]
    assert_equal expected, renderer.render
  end

  def test_it_takes_in_a_block_with_numbers_and_returns_an_ordered_list
    sample_text = ["\n1. cake"]
    renderer = Renderer.new(sample_text)

    expected = ["<ol><li>cake</li></ol>"]
    assert_equal expected, renderer.render
  end

  def test_it_takes_in_a_text_block_and_returns_the_correct_html_signs_instead_as_an_array
    sample_text = ["#Hello, *world*", "Hello, **world**"]
    renderer = Renderer.new(sample_text)

    assert_equal ["<h1>Hello, *world*</h1>", "<p>Hello, **world**</p>"], renderer.render
  end

  def test_it_handles_a_harder_list_case
    sample_text = ["\n* *cake*\n* **cupcakes**\n"]
    renderer = Renderer.new(sample_text)

    expected = ["<ul><li>*cake*</li><li>**cupcakes**</li></ul>"]
    assert_equal expected, renderer.render
  end

  def test_it_handles_a_simple_list_with_one_element
    sample_text = ["\n* cake"]
    renderer = Renderer.new(sample_text)

    expected = ["<ul><li>cake</li></ul>"]
    assert_equal expected, renderer.render
  end

  def test_it_takes_in_a_chunk_and_checks_if_it_is_a_list_or_not
    sample_text = ["\n* I'm an unordered list"]
    renderer = Renderer.new(sample_text)

    expected = ["<ul><li>I'm an unordered list</li></ul>"]
    assert_equal expected, renderer.render
  end
end
