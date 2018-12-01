class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :from, index: true
      t.references :to
      t.integer :amount
      t.references :ask, default: nil
      t.references :order, default: nil
      t.string :status

      t.timestamps
    end
  end
end
