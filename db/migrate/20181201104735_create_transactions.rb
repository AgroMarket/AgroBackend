class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :type,      null: false, default: 0
      t.integer :from,      null: false, default: 0
      t.integer :to,        null: false, default: 0
      t.integer :amount,    null: false, default: 0
      t.integer :status,    null: false, default: 0
      t.references :ask,    null: false, default: 0
      t.references :order,  null: false, default: 0
      t.references :task,   null: false, default: 0

      t.timestamps
    end
  end
end
