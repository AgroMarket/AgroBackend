class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :cart, index: true
      t.references :user, index: true
      t.references :product, unique: true, index: true
      t.integer :quantity

      t.timestamps
    end
  end
end
