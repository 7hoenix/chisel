class ChunkMaker
  def self.make(text_block)
    #sample_text == "#Hello, world/n/nHello, world"
    split_text_blocks = text_block.split("\n\n")
    #["#Hello, *world*", "Hello, **world**"]
  end
end
