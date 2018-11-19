class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.references :cart, index: true
      t.references :product, index: true
      t.references :producer, index: true
      t.integer :quantity
      t.integer :sum

      t.timestamps
    end
  end
end
