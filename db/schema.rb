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

ActiveRecord::Schema.define(version: 20200818114640) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budgets", force: :cascade do |t|
    t.float   "amount"
    t.date    "date"
    t.integer "category_id"
    t.integer "user_id",     null: false
    t.index ["category_id"], name: "index_budgets_on_category_id", using: :btree
    t.index ["user_id"], name: "index_budgets_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string  "category_name"
    t.integer "user_id"
    t.string  "category_type",                null: false
    t.boolean "available",     default: true, null: false
    t.index ["user_id"], name: "index_categories_on_user_id", using: :btree
  end

  create_table "operations", force: :cascade do |t|
    t.string   "type",                                         null: false
    t.float    "amount"
    t.text     "description"
    t.date     "date"
    t.integer  "category_id"
    t.integer  "user_id",                                      null: false
    t.string   "expense_type"
    t.datetime "created_at",   default: '2020-01-25 12:03:25', null: false
    t.index ["category_id"], name: "index_operations_on_category_id", using: :btree
    t.index ["user_id"], name: "index_operations_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "categories", "users"
end
