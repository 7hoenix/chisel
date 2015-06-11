require 'pry'

class LinkMaker
  def self.find_link(text)
    link_text = text.map do |chunk|
      self.transformer(chunk)
    end
  end

  #"<a href=\"http://example.net/\">This link</a> has no domain_titleattribut."
  def self.transformer(text)
    valid_links = text.gsub("](", "~")
    counter = valid_links.count("~")
    counter.times do
      k = text.index("(")
      l = text.index(")")
      link = text[(k+1)..(l-1)]
      if link.include?("'")
        domain_title= link.split("'")
      elsif link.include?("\"")
        domain_title= link.split("\"")
      end
      link_with_parens = text[k..l]
      text.sub!("#{link_with_parens}", "")
      if domain_title
        text.sub!("[", "<a href=\"#{domain_title[0].strip}\" title=\"#{domain_title[1]}\">")
      else
        text.sub!("[", "<a href=\"#{link}\">")
      end
      text.sub!("]", "</a>")
    end
    text
  end
end
