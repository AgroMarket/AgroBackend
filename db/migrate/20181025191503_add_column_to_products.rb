class AddColumnToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :farmer
    add_reference :cart, :cart
  end
end
