# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_16_192154) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "credentials", force: :cascade do |t|
    t.string "login", null: false
    t.string "password", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["login"], name: "index_credentials_on_login", unique: true
  end

  create_table "establishments", force: :cascade do |t|
    t.string "number", null: false
    t.bigint "shop_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "credential_id"
    t.index ["credential_id"], name: "index_establishments_on_credential_id"
    t.index ["number"], name: "index_establishments_on_number", unique: true
    t.index ["shop_id"], name: "index_establishments_on_shop_id"
  end

  create_table "movements", force: :cascade do |t|
    t.string "type"
    t.date "payment_date"
    t.date "origin_date"
    t.integer "provider"
    t.decimal "amount"
    t.integer "currency"
    t.string "card_number"
    t.string "coupon_number"
    t.integer "installments_current"
    t.integer "installments_number"
    t.integer "installments_total"
    t.decimal "discount_amount"
    t.string "description_code"
    t.bigint "payment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["payment_id"], name: "index_movements_on_payment_id"
  end

  create_table "payments", force: :cascade do |t|
    t.date "payment_date"
    t.date "origin_date"
    t.integer "provider"
    t.integer "document_type"
    t.integer "clearing_number"
    t.decimal "total_amount"
    t.decimal "total_deduction"
    t.decimal "total_earn"
    t.decimal "opening_balance"
    t.decimal "closing_balance"
    t.integer "currency"
    t.boolean "is_balanced"
    t.bigint "establishment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["establishment_id"], name: "index_payments_on_establishment_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.bigint "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_shops_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.bigint "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
