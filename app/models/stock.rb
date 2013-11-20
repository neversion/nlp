class Stock < ActiveRecord::Base
		attr_accessible :file_index, :stock_id, :name ,:title, :author, :code, :resource ,:time, :seg_words
end
