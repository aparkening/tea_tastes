class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :title
      t.string :content
      t.integer :rating
      t.integer :user_id
      t.integer :tea_id
      t.timestamps
    end
  end
end
