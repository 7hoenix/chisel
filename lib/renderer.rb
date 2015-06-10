require 'pry'

class Renderer
  attr_reader :chunked_text

  def initialize( chunked_text )
    @chunked_text = chunked_text
  end

  def render
    rendered = chunked_text.map do |chunk|
      list?(chunk) ? render_list(chunk) : heading(chunk)
    end
  end

  def list?(chunk)
    true if chunk.include?("\n*") || chunk.include?("\n1.")
  end

  def render_list(chunk)
    list = chunk.strip.split("\n")

    result = list.map { |item| "<li>" + item.gsub("* ", "") + "</li>" }

    "<#{list_type(chunk)}>#{result.join}</#{list_type(chunk)}>"
  end

  def list_type(chunk)
    chunk.include?("\n*") ? "ul" : "ol"
  end

  def heading(chunk)
    count = chunk.chars.count { |char| char == "#" }
    chunk_without_hashtags = chunk.chars.reject { |char| char == "#" }
    "<#{header(count)}>#{chunk_without_hashtags.join}</#{header(count)}>"
  end

  def header(count)
    count == 0 ? "p" : "h#{count}"
  end
end
