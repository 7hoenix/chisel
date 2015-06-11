require 'pry'
require_relative "../lib/chunk_maker"
require_relative "../lib/emphasizer"
require_relative "../lib/renderer"
require_relative "../lib/link_maker"
require_relative "../lib/formatter"

class Chisel
  attr_reader :input_file, :output_file

  def initialize( input_file, output_file = "your_mom.html" )
    @input_file = input_file
    @output_file = output_file
  end

  def get_input_text(file)
    handler = File.open("#{file}", "r")
    handler.read
  end

  def get_chunks
    ChunkMaker.make(get_input_text(input_file))
  end

  def get_rendered
    renderer = Renderer.new(get_chunks)
    renderer.render
  end

  def get_emphasis
    Emphasizer.emphasize(get_rendered)
  end

  def get_links
    LinkMaker.find_link(get_emphasis)
  end

  def get_formatted
    Formatter.format(get_links)
  end

  def write_output_file
    handler = File.open("#{output_file}", "w")
    handler.write(get_formatted)
    handler.close
  end
end

if __FILE__ == $0
  chisel = Chisel.new(ARGV[0], ARGV[1])
  chisel.write_output_file
  puts "Converted my_#{ARGV[0]} (#{chisel.get_input_text(ARGV[0]).count("\n")} lines) to #{ARGV[1]} (#{chisel.get_input_text(ARGV[1]).count("\n")} lines)"
end

