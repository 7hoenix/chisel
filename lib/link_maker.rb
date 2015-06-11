require 'pry'

class LinkMaker
  def self.find_link(text)
    link_text = text.map do |chunk|
      self.transformer(chunk)
    end
  end

  def self.transformer(text)
    counter = count_links(text)
    counter.times do
      left_parens = text.index("(")
      right_parens = text.index(")")
      link = text[(left_parens + 1)..(right_parens - 1)]
      domain_title = split_domain_title(link)
      link_with_parens = text[left_parens..right_parens]
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

  def self.split_domain_title(link)
    if link.include?("'")
      link.split("'")
    elsif link.include?("\"")
      link.split("\"")
    end
  end

  def self.count_links(text)
    valid_links = text.gsub("](", "~")
    valid_links.count("~")
  end
end
