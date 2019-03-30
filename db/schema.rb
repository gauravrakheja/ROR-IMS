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

ActiveRecord::Schema.define(version: 2019_03_30_092706) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string "code"
    t.integer "quantity", default: 1
    t.decimal "price"
    t.string "state", default: "out_of_stock"
    t.string "description"
    t.string "internal_reference"
    t.bigint "supplier_detail_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_detail_id"], name: "index_items_on_supplier_detail_id"
  end

  create_table "stock_check_reports", force: :cascade do |t|
    t.integer "number_of_items"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stock_checks", force: :cascade do |t|
    t.bigint "item_id"
    t.integer "quantity", default: 1
    t.bigint "stock_check_report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.index ["item_id"], name: "index_stock_checks_on_item_id"
    t.index ["stock_check_report_id"], name: "index_stock_checks_on_stock_check_report_id"
  end

  create_table "supplier_details", force: :cascade do |t|
    t.string "name"
    t.string "contact"
    t.string "location"
    t.integer "lead_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.json "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "stock_checks", "items"
  add_foreign_key "stock_checks", "stock_check_reports"
end
