class Renderer
  def self.render(chunked_text)
    rendered = chunked_text.map do |chunk|
      count = chunk.chars.count { |char| char == "#" }
      new_chunk = chunk.chars.reject { |char| char == "#" }
      "<#{self.header(count)}>#{new_chunk.join}</#{self.header(count)}>"
    end
  end

  def self.header(count)
    if count == 0
      "p"
    else
      "h#{count}"
    end
  end
end
