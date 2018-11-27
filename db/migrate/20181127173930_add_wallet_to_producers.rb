class AddWalletToProducers < ActiveRecord::Migration[5.2]
  def change
    add_column :producers, :wallet, :integer, default: 0
  end
end
