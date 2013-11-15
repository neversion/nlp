class CreateOrigins < ActiveRecord::Migration
  def change
    create_table :origins do |t|
      t.string :id
      t.string :name
      t.string :title
      t.string :author
      t.string :code
      t.string :resource
      t.string :time

      t.timestamps
    end
  end
end
