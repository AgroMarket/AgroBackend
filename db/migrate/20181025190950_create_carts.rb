class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.decimal :price
      t.references :product, foreign_key: true
      t.references :farmer, foreign_key: true

      t.timestamps
    end
  end
end
