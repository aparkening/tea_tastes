class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :name
      t.string :url
      t.string :description
      t.timestamps
    end
end
