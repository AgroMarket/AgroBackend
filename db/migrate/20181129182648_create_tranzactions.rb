class CreateTranzactions < ActiveRecord::Migration[5.2]
  def change
    create_table :tranzactions do |t|
      t.references :user
      t.integer :sum
      t.integer :to
      t.references :order
      t.string :status

      t.timestamps
    end
  end
end
