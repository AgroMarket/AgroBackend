class AddParentRankToCategories < ActiveRecord::Migration[5.2]
  def change
    add_reference :categories, :parent, index: true, null: false, default: 0
    add_column :categories, :rank, :integer, null: false, default: 0
  end
end
