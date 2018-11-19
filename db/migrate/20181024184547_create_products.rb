class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :measures
      t.integer :price
      t.string :image
      t.integer :rank
      t.references :producer, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
