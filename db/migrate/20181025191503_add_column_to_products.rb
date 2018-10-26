class AddColumnToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :farmer
    add_reference :products, :cart
  end
end
