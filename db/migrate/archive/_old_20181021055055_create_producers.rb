class CreateProducers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string :producer_logo
      t.string :producer_brand
      t.string :producer_address
      t.string :producer_phone
      t.text :producer_description
      t.string :producer_inn
    end
  end
end
