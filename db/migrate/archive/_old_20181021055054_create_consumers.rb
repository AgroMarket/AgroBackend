class CreateConsumers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string :type
      t.string :avatar
      t.string :name
      t.string :address
      t.string :phone
      t.text :description
    end
  end
end
