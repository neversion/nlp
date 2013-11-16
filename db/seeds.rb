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
def count
	hash = Hash.new
	Stock.all.each do |s|
		s.seg_words.split('^').each do |item|
			if !item.nil? && item.length!=0
				if !hash[item].nil?	
					hash[item]=hash[item]+1
				else
					hash[item]=1
				end
				puts "#{item}: #{hash[item]}"
			end
		end
	end
	puts "#{hash.count}done"
	path = "#{Rails.root}/public/data/freq_sorted.txt"
	binding.pry
	array =  hash.sort_by{|key,val| val}
	file = File.new(path,"w")
		array.each do |item|
			file.puts "#{item[0]}:#{item[1]}\r\n"
		end
		file.close
	puts "done"
end


# import_origin
count