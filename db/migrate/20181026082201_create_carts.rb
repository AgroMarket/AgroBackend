class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.decimal :price
      t.references :user, foreign_key: true
      t.references :product, index: true

      t.timestamps
    end
  end
end
