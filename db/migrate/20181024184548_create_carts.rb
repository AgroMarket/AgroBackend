class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.integer :quantity, default: 1
      t.references :user, index: true
      t.references :product, index: true

      t.timestamps
    end
  end
end
