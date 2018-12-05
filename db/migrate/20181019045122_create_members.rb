class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string :type,               null: false, default: 'Member'
      t.string :user_type,          null: false, default: 'consumer'
      t.integer :amount,            null: false, default: 0
      t.string :image,              null: false, default: ''
      t.string :name,               null: false, default: ''
      t.string :address,            null: false, default: ''
      t.string :phone,              null: false, default: ''
      t.text :description,          null: false, default: ''
      t.string :producer_logo,      null: false, default: ''
      t.string :producer_brand,     null: false, default: ''
      t.string :producer_address,   null: false, default: ''
      t.string :producer_phone,     null: false, default: ''
      t.text :producer_description, null: false, default: ''
      t.string :producer_inn,       null: false, default: ''
    end
  end
end
