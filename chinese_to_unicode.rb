# -*- coding: utf-8 -*-
require 'hpricot'

def zh_to_unicode chr
  # if we are sure we are in ruby 1.9
  # then codepoints method is better
  #  p "国".codepoints.first #=> 22269
  #  p 22269.chr('UTF-8') #=> "国"
  chr.unpack("U*").first
end

def add_prefix_suffix chr
  chr = "&##{chr};"
end

#p zh_to_unicode '中'
#p '中'.ascii_only?
#'abc中国'.each_char { |i| p i}
def mixed_str_to_unicode! str
  newstr = ''
  str.each_char do |char|
    if char.ascii_only?
      newstr << char
    else
      newstr << add_prefix_suffix(zh_to_unicode(char))
    end
  end
  newstr
end

def translate_files inputfile
  parser = Hpricot(File.read inputfile)
  tags = %w(title p li div span)
  tags.each do |tag|
    (parser/tag.to_sym).each do |tag|
      newhtml = ''
      newhtml = mixed_str_to_unicode!(tag.inner_html)
      tag.inner_html = newhtml
    end
  end
  puts parser
end

input = File.expand_path ARGV[0]

p translate_files input

# READEME
=begin
Ruby 1.9 :
p "国".codepoints.first #=> 22269
p 22269.chr('UTF-8') #=> "国"

All ruby
>> "白".unpack("U*")
=> [30333]
>> "白".unpack("U*").first
=> 30333
=end

# ascii_only? is a built-in ruby method!
# oh yeah

# read in a file
# doc = open("index.html") { |f| Hpricot(f) }
# doc.methods # see all available methods

#parser.traverse_all_element do |e|
# p e.inner_html 
#= mixed_str_to_unicode! e.inner_html
#end
