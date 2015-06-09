class Parser
  def self.parse(input)
    input_minus_special = input.gsub("~~", "")
    "<def>#{input_minus_special}</def>"
  end
end
