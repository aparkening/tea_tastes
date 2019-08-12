# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_12_161246) do

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.integer "rating"
    t.integer "user_id"
    t.integer "tea_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes_shops", force: :cascade do |t|
    t.integer "note_id"
    t.integer "shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teas", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "url"
    t.string "region"
    t.string "country"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teas_shops", force: :cascade do |t|
    t.integer "tea_id"
    t.integer "shop_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
