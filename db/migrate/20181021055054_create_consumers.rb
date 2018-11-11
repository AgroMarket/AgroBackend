class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :description
    end
    add_column :users, :name, :string
    add_column :users, :, :string
    add_column :users, :telephone, :string
    add_column :users, :description, :text
  end
end
