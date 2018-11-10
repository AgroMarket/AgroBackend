class AddOrderToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :order, index: true
  end
end
