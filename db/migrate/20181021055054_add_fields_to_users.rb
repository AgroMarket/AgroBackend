class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :telephone, :string
    add_column :users, :description, :text
    remove_column :users, :fio, :string
    remove_column :users, :inn, :string
    remove_column :users, :kpp, :string
    remove_column :users, :telephone, :string
    remove_column :users, :region, :string
    remove_column :users, :another_information, :text
  end
end
