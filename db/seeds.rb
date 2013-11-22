# -*- encoding : utf-8 -*-
#!/usr/bin/env ruby

def import_origin
  #count=1
  path = "#{Rails.root}/public/data/contents.txt"
  File.open(path) do |file|
    #RMMSeg::Dictionary.load_dictionaries
    file_index=1
    file.each_line do |line|
      parts = line.split(',')

      stock = Stock.new
      stock.file_index=file_index
      stock.stock_id = parts[0].gsub(/\"/, '')
      stock.name = parts[1].gsub(/\"/, '')
      stock.title = parts[2].gsub(/\"/, '')
      stock.author = parts[3].gsub(/\"/, '')
      stock.code = parts[4].gsub(/\"/, '')
      stock.resource = parts[5].gsub(/\"/, '')
      stock.date = parts[6].gsub(/\"/, '').gsub("\r\n", '')
      #stock.seg_words = seg stock.title
      # binding.pry
      stock.save
      file_index = file_index+1
      puts "#{file_index}: #{stock.title}"
      #count = count+1
    end
  end
end

def import_seg
  path = "#{Rails.root}/public/data/title_pos.txt"
  line_index=1
  File.open(path) do |file|
    file.each_line do |line|
      s = Stock.find_by_file_index(line_index)
      s.seg_words=line
      s.save
      line_index = line_index+1
    end
  end
end

#def seg text
#	results = ""
#	algor = RMMSeg::Algorithm.new(text)
#	loop do
#		tok = algor.next_token
#		break if tok.nil?
#		results +="#{tok.text}^"
#		# puts "#{tok.text} [#{tok.start}..#{tok.end}]"
#	end
#	return results.force_encoding("utf-8")
#end

# attr_accessible :stock_id, :name ,:title, :author, :code, :resource ,:time
def count
  binding.pry
  hash = Hash.new
  Stock.all.each do |s|
    s.seg_words.split(' ').each do |item|
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
  array = hash.sort_by { |key, val| val }
  file = File.new(path, "w")
  array.each do |item|
    file.puts "#{item[0]}:#{item[1]}\r\n"
  end
  file.close
  puts "done"
end

#
def filter
  path = "#{Rails.root}/public/data/title_pos.txt"
  results = []
  File.open(path) do |file|
    file.each_line do |line|
      line.split(':')[0]=~ /v/
    end
  end

end

def rand_index(count)
  max =658769
  index_list=[]
  # temp = -1
  while index_list.count<count
    temp = rand(1..max)
    if !index_list.include?(temp)
      index_list<<temp
    end 
  end
  return index_list
end

def rand_lines(count,part_count)
  index_list=rand_index(count)
  per_count = count/part_count
  (1..part_count).each do |index|
    path = "#{Rails.root}/public/data/rand_lines#{index}.txt"
    file = File.new(path, "w")
    index_list[0+per_count*(index-1)..per_count*index-1].each do |item|
      seg_words = Stock.find_by_file_index(item).seg_words
      file.puts seg_words
      puts seg_words 
    end
    file.close
  end
  puts "done"
end


#import_origin
#import_seg
# count
rand_lines(5000,5)