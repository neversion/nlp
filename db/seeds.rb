# -*- encoding : utf-8 -*-
#!/usr/bin/env ruby
require 'rmmseg'


def process
	count = 4
	RMMSeg::Dictionary.load_dictionaries
	path = "#{Rails.root}/public/data/contents.txt"
	File.open("contents.txt") do |file|
		file.each_line do |line|
			puts seg line
		end
		# file.each_line do |line|
		# 	break unless count>0
		# 	# puts seg text
		# 	count--
		# end
	end
end	  

def seg text
	results = ""
	algor = RMMSeg::Algorithm.new(text)
	loop do
		tok = algor.next_token
		break if tok.nil?
		results +="#{tok.text} " 
		# puts "#{tok.text} [#{tok.start}..#{tok.end}]"
	end
	return results
end



process