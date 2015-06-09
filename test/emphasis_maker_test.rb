class EmphasisMakerTest < Minitest::Test
  def test_it_takes_in_a_block_with_no_emphasis_and_gives_it_emphasis
    sample_text = ["<h1>Hello, *world*</h1>", "<p>Hello, **world**</p>"]
    emphasize = EmphasisMaker.emphasize(sample_text)

    assert_equal ["<h1>Hello, <em>world</em></h1>", "<p>Hello, <strong>world</strong></p>"], emphasize
  end
end
