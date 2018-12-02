class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :from, index: true
      t.references :to
      t.integer :amount
      t.references :ask, null: true, default: 0
      t.references :order, null: true, default: 0
      t.string :status

      t.timestamps
    end
  end
end
