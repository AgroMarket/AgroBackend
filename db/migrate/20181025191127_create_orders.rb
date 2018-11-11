class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :consumer, index: true
      t.references :producer, index: true
      t.integer :total
      t.integer :status

      t.timestamps
    end
  end
end
