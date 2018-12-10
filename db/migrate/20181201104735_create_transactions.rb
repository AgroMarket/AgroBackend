class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :account
      t.string     :t_type
      t.string     :direction
      t.integer    :amount, null: false, default: 0
      t.references :from
      t.references :to
      t.integer    :before, null: true
      t.integer    :after,  null: true
      t.references :ask,    null: true
      t.references :order,  null: true
      t.references :task,   null: true

      t.timestamps
    end
  end
end
