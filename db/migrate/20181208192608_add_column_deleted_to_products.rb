class AddColumnDeletedToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :deleted, :boolean, :default => false
    #Ex:- :default =>''
  end
end
