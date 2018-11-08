class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :quantity
      t.integer :total_price
      t.references :user, index: true
      t.references :farmer, index: true

      t.timestamps
    end
  end
end
