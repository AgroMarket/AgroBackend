class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :fio, :string
    add_column :users, :inn, :string
    add_column :users, :kpp, :string
    add_column :users, :telephone, :string
    add_column :users, :region, :string
    add_column :users, :another_information, :text
  end
end
