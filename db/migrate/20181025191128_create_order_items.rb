class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :order, index: true
      t.references :product, index: true
      t.integer :producer_id, index: true
      t.integer :price
      t.integer :quantity
      t.integer :sum

      t.timestamps
    end
  end
end
