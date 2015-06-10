require_relative "chunk_maker"
require_relative "renderer"
require_relative "emphasizer"

class Chisel
  attr_reader :output_file, :input_file

  def initialize( input_file, output_file = "my_output.html" )
    @input_file = input_file
    @output_file = output_file
  end

  def get_input_text
    reader = File.open("#{input_file}", "r")
    input_text = reader.read
    reader.close
    call_chunk_maker(input_text)
    input_text
  end

  def call_chunk_maker(input_text)
    chunked_text = ChunkMaker.make(input_text)
    call_renderer(chunked_text)
    chunked_text
  end

  def call_renderer(chunked_text)
    rendered_text = Renderer.render(chunked_text)
    call_emphasizer(rendered_text)
    rendered_text
  end

  def call_emphasizer(rendered_text)
    emphasized_text = Emphasizer.emphasize(rendered_text)
    write_output_text(emphasized_text)
    emphasized_text
  end

  def write_output_text(emphasized_text)
    writer = File.open("#{output_file}", "w")
    writer.write(emphasized_text)
    writer.close
  end
end


if __FILE__ == $0
  chisel = Chisel.new(ARGV[0], ARGV[1])
  chisel.get_input_text
end

