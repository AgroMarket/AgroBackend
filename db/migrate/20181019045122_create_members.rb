class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.integer :amount
      t.string :type
      t.string :image
      t.string :name
      t.string :address
      t.string :phone
      t.text :description
      t.string :producer_logo
      t.string :producer_brand
      t.string :producer_address
      t.string :producer_phone
      t.text :producer_description
      t.string :producer_inn
    end
  end
end
