class CreateProducers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string :logo
      t.string :brand
      t.text :producer_description
      t.string :producer_address
      t.string :producer_phone
      t.string :inn
    end
  end
end
