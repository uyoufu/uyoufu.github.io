# https://apidock.com/ruby/String/gsub
module Jekyll
  module RegexFilter
    def replace_regex(input, reg_str, repl_str)
      re = Regexp.new reg_str  
      # This will be returned
      input.gsub re, repl_str
    end

    def match_regex(input, reg_str)
      re = Regexp.new reg_str  
      # This will be returned
      input.match re
    end

  end
end
  
Liquid::Template.register_filter(Jekyll::RegexFilter)