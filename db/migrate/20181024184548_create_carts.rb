class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.references :consumer, index: true
      t.integer :total

      t.timestamps
    end
  end
end
