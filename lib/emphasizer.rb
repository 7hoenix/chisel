require 'pry'

class Emphasizer
  def self.emphasize(rendered_text)
    emphasized_text = rendered_text.map do |chunk|
      strong_text = self.strong_replacement(chunk)
      self.italic_replacement(strong_text)
    end
  end

  def self.strong_replacement(rendered_text)
    replace_with_tilda = rendered_text.gsub("**", "~")
    count = replace_with_tilda.chars.count { |char| char == "~" }
    count.times do |count|
      if count % 2 == 0
        replace_with_tilda.sub!("~", "<strong>")
      else
        replace_with_tilda.sub!("~", "</strong>")
      end
    end
    replace_with_tilda
  end

  def self.italic_replacement(strong_text)
    count = strong_text.chars.count { |char| char == "*" }
    emphasized_text = strong_text
    count.times do |count|
      if count % 2 == 0
        emphasized_text.sub!("*", "<em>")
      else
        emphasized_text.sub!("*", "</em>")
      end
    end
    emphasized_text
  end
end

