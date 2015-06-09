require_relative "../lib/chunk_maker"

class ChunkMakerTest < Minitest::Test
  def test_it_takes_in_a_block_of_text_and_returns_an_array_of_chunks
    sample_text = "#Hello, *world*\n\nHello, **world**"
    chunks = ChunkMaker.make(sample_text)

    assert_equal ["#Hello, *world*", "Hello, **world**"], chunks
  end
end
