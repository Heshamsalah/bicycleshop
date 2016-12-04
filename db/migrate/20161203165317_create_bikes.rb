class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.string :name
      t.string :style
      t.integer :price
      t.string :picurl
      t.text :desc

      t.timestamps null: false
    end
  end
end
