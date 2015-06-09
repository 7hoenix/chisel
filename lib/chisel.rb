class Chisel
  attr_reader :text

  def initialize(input_text)
    @text = input_text
  end

  def call_chunk_maker(text)
    ChunkMaker.make(text)
  end

  def call_renderer(chunked_text)
    Renderer.render(chunked_text)
  end

end
