class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.references :consumer, index: true
      t.integer :sum, default: 0
      t.integer :delivery_cost, default: 0
      t.integer :total, default: 0

      t.timestamps
    end
  end
end
