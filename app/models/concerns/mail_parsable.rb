module MailParsable
  extend ActiveSupport::Concern
  
  included do
  end

  def parse(replacements, text)
    ret = text

    replacements.each do |key, item|
      reg = Regexp.new('<#\s*' + key + '\s*#>')
      ret = ret.gsub(reg, item.to_s)
    end

    ret
  end

  def parse_body(replacements)
    parse(replacements, self.body)
  end

  def parse_subject(replacements)
    parse(replacements, self.subject)
  end
end