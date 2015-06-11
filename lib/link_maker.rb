require 'pry'

class LinkMaker
  def self.find_link(text)
    link_text = text.map do |chunk|
      self.something(chunk)
    end
  end

  #"<a href=\"http://example.net/\">This link</a> has no title attribut."
  def self.something(text)
    valid_links = text.gsub("](", "~")
    counter = valid_links.count("~")
    counter.times do
      k = text.index("(")
      l = text.index(")")
      link = text[(k+1)..(l-1)]
      if link.include?("'")
        title = link.split("'")
      elsif link.include?("\"")
        title = link.split("\"")
      end
      link_with_parens = text[k..l]
      text.sub!("#{link_with_parens}", "")
      if title
        text.sub!("[", "<a href=\"#{title[0].strip}\" title=\"#{title[1]}\">")
      else
        text.sub!("[", "<a href=\"#{link}\">")
      end
      text.sub!("]", "</a>")
    end
    text
  end
end
