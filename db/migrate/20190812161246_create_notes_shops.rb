class CreateNotesShops < ActiveRecord::Migration[5.2]
  def change
    create_table :notes_shops do |t|
      t.integer :note_id
      t.integer :shop_id
    end
  end
end
