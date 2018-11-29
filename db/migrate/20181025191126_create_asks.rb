class CreateAsks < ActiveRecord::Migration[5.2]
  def change
    create_table :asks do |t|
      t.references :consumer, index: true
      t.integer :amount, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
