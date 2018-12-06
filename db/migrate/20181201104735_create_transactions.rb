class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string  :t_type,    null: false, default: ''
      t.integer :from_id,   null: false, default: 0
      t.integer :to_id,     null: false, default: 0
      t.integer :before,    null: true
      t.integer :amount,    null: false, default: 0
      t.integer :after,     null: true
      t.references :ask,    null: true
      t.references :order,  null: true
      t.references :task,   null: true

      t.timestamps
    end
  end
end
