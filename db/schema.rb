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

ActiveRecord::Schema.define(version: 2023_02_28_123628) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budgets", id: :serial, force: :cascade do |t|
    t.float "amount"
    t.date "date"
    t.integer "category_id"
    t.integer "user_id", null: false
    t.index ["category_id"], name: "index_budgets_on_category_id"
    t.index ["user_id"], name: "index_budgets_on_user_id"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "category_name"
    t.integer "user_id"
    t.string "category_type", null: false
    t.boolean "available", default: true, null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "operations", id: :serial, force: :cascade do |t|
    t.string "type", null: false
    t.float "amount"
    t.text "description"
    t.date "date"
    t.integer "category_id"
    t.integer "user_id", null: false
    t.string "expense_type"
    t.datetime "created_at", default: "2023-02-28 11:38:32", null: false
    t.index ["category_id"], name: "index_operations_on_category_id"
    t.index ["user_id"], name: "index_operations_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categories", "users"
end
