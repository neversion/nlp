class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :file_index
      t.string :stock_id
      t.string :name
      t.string :title
      t.string :author
      t.string :code
      t.string :resource
      t.string :date
      t.string :seg_words

      t.timestamps
    end
  end
end
