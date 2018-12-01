class AddColumnDeliveryCostToCarts < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :delivery_cost, :integer, default: 500
  end
end
