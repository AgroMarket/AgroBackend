class AddTypeColymnToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :icontype, :string, default: ''
  end
end
