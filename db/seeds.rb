# -*- encoding : utf-8 -*-
#!/usr/bin/env ruby
require 'rmmseg'


def import_origin
	count=1
	path = "#{Rails.root}/public/data/contents.txt"
	File.open(path) do |file|
			RMMSeg::Dictionary.load_dictionaries

		file.each_line do |line|
			parts = line.split(',')

			stock = Stock.new
			stock.stock_id = parts[0].gsub(/\"/,'')
			stock.name = parts[1].gsub(/\"/,'')
			stock.title = parts[2].gsub(/\"/,'')
			stock.author = parts[3].gsub(/\"/,'')
			stock.code = parts[4].gsub(/\"/,'')
			stock.resource = parts[5].gsub(/\"/,'')
			stock.date = parts[6].gsub(/\"/,'').gsub("\r\n",'')
			stock.seg_words = seg stock.title
			# binding.pry
			stock.save
			puts "#{count}: #{stock.title}" 
			count = count+1
		end
	end
end	  

def seg text
	results = ""
	algor = RMMSeg::Algorithm.new(text)
	loop do
		tok = algor.next_token
		break if tok.nil?
		results +="#{tok.text}^" 
		# puts "#{tok.text} [#{tok.start}..#{tok.end}]"
	end
	return results.force_encoding("utf-8")
end

		# attr_accessible :stock_id, :name ,:title, :author, :code, :resource ,:time


import_origin