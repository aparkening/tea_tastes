class CreateTeas < ActiveRecord::Migration[5.2]
  def change
    create_table :teas do |t|
      t.string :name
      t.string :category
      t.string :url
      t.string :region
      t.string :country
      t.string :description
      t.integer :shop_id
      t.timestamps
    end
  end
end