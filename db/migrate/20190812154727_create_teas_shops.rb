class CreateTeasShops < ActiveRecord::Migration[5.2]
  def change
    create_table :teas_shops do |t|
      t.integer :tea_id
      t.integer :shop_id
    end
  end
end
