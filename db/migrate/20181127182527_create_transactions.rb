class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :consumer, foreign_key: true
      t.references :producer, foreign_key: true
      t.integer :sum
      t.string :direction
      t.integer :status

      t.timestamps
    end
  end
end
