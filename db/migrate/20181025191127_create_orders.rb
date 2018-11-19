class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :consumer, index: true
      t.references :producer, index: true
      t.integer :total, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
