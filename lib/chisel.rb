require 'pry'
require_relative "../lib/chunk_maker"

class Chisel
  attr_reader :input_file, :output_file

  def initialize( input_file, output_file = "your_mom.html" )
    @input_file = input_file
    @output_file = output_file
  end

  def get_input_text
    handler = File.open("#{input_file}", "r")
    handler.read
  end

  def get_chunks
    ChunkMaker.make(get_input_text)
  end

  def get_rendered
    renderer = Renderer.new(get_chunks)
    renderer.render
  end

  def get_emphasis
    Emphasizer.emphasize(get_rendered)
  end

  def write_output_file
    handler = File.open("#{output_file}", "w")
    handler.write(get_emphasis)
  end
end

if __FILE__ == $0
  chisel = ChiselTemp.new(ARGV[0], ARGV[1])
  chisel.get_input_text
end

