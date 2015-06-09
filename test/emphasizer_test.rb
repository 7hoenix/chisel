class EmphasizerTest < Minitest::Test
  # ["<h1>Hello, *world*</h1>", "<p>Hello, **world**</p>"]
  # This could be easier with
  # "string **with** some *things*"
  # "string **with**"

  def test_it_works_when_the_ass_hole_user_puts_in_3_asterisks_next_to_each_other
    input = ["words ***bolded bolded and italic* bolded** words"]
    output = Emphasizer.emphasize(input)
    expected = ["words <strong><em>bolded bolded and italic</em> bolded</strong> words"]
    assert_equal expected, output
  end

  def test_it_takes_a_string_with_words_double_and_single_asterisks_mixed_up_between_each_other
    input = ["words **bolded *bolded and italic* bolded** words"]
    output = Emphasizer.emphasize(input)
    expected = ["words <strong>bolded <em>bolded and italic</em> bolded</strong> words"]
    assert_equal expected, output
  end

  def test_it_takes_a_string_with_words_double_and_single_asterisks_and_converts_them_appropriately
    input = ["words **bolded** words *italic* words"]
    output = Emphasizer.emphasize(input)
    expected = ["words <strong>bolded</strong> words <em>italic</em> words"]
    assert_equal expected, output
  end

  def test_it_takes_a_string_with_words_around_it_and_converts_it_to_emphasis_tags
    input = ["words *it* words"]
    output = Emphasizer.emphasize(input)
    expected = ["words <em>it</em> words"]
    assert_equal expected, output
  end

  def test_it_takes_a_string_with_single_asterisk_and_converts_it_to_emphasis_tags
    input = ["*it*"]
    output = Emphasizer.emphasize(input)
    expected = ["<em>it</em>"]
    assert_equal expected, output
  end

  def test_it_takes_a_string_with_words_around_it
    input = ["words **it** words"]
    output = Emphasizer.emphasize(input)
    expected = ["words <strong>it</strong> words"]
    assert_equal expected, output
  end

  def test_it_takes_a_string_with_double_asterisks_and_converts_it_to_strong_tags
    input = ["**with**"]
    output = Emphasizer.emphasize(input)
    expected = ["<strong>with</strong>"]
    assert_equal expected, output
  end

  def test_it_takes_in_a_block_with_no_emphasis_and_gives_it_emphasis
    sample_text = ["<h1>Hello, *world*</h1>", "<p>Hello, **world**</p>"]
    emphasize = Emphasizer.emphasize(sample_text)
    expected = ["<h1>Hello, <em>world</em></h1>", "<p>Hello, <strong>world</strong></p>"]
    assert_equal expected, emphasize
  end
end
