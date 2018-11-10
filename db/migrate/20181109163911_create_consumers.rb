class CreateConsumers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.remove :telephone
      t.string :phone
    end
  end
end
