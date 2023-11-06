# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_11_06_133207) do
  create_table "cloth_types", force: :cascade do |t|
    t.string "type_name", null: false
    t.string "category", default: "0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type_name"], name: "index_cloth_types_on_type_name", unique: true
  end

  create_table "cloths", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "description"
    t.date "last_worn_on", null: false
    t.string "type_name", null: false
    t.integer "category", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cloths_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
