class AddImagesRankToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :image, :string
    add_column :products, :rank, :integer
  end
end
