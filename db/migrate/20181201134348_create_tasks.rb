class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :ask, index: true
      t.references :user, index: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
