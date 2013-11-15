class Stock < ActiveRecord::Base
		attr_accessible :stock_id, :name ,:title, :author, :code, :resource ,:time, :seg_words
end
