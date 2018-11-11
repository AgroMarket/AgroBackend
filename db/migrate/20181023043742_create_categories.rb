class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, index: true, null: false
      t.string :icontype, default: ''
      t.integer :rank, null: false, default: 0
      t.references :parent, index: true, default: 0

      t.timestamps
    end
  end
end
