class AddFileIndexToStocks < ActiveRecord::Migration
  def change
    add_index :stocks, :file_index
  end
end
