class CreateCartProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_products do |t|
      t.references :cart, index: true
      t.references :product, index: true

      t.timestamps
    end
  end
end
