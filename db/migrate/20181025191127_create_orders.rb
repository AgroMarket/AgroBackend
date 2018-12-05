class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :ask, index: true
      t.integer :consumer_id, index: true
      t.integer :producer_id, index: true
      t.integer :total, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
