class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :carrier, index: true
      t.references :ask, index: true
      t.integer    :delivery_cost, null: false, default: 0
      t.references :member, index: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
