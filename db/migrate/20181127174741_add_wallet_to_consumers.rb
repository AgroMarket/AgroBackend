class AddWalletToConsumers < ActiveRecord::Migration[5.2]
  def change
    add_column :consumers, :wallet, :integer, default: 0
  end
end
