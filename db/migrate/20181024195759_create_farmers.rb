class CreateFarmers < ActiveRecord::Migration[5.2]
  def change
    create_table :farmers do |t|
      t.string :inn
      t.text :description
      t.string :address
      t.references :user, index: true, default: nil

      t.timestamps
    end
  end
end
