class AddWalletToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :wallet, :integer, default: 0
  end
end
