class CreateAsks < ActiveRecord::Migration[5.2]
  def change
    create_table :asks do |t|
      t.integer :consumer_id, index: true
      t.integer :sum, default: 0
      t.integer :delivery_cost, default: 0
      t.integer :total, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
