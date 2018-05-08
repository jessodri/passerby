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

ActiveRecord::Schema.define(version: 20180508072457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.bigint "pickup_request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pickup_request_id"], name: "index_conversations_on_pickup_request_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "pickup_requests", force: :cascade do |t|
    t.string "pickup_address"
    t.text "description"
    t.text "image_data"
    t.string "delivery_address"
    t.decimal "payment_amount"
    t.decimal "stripe_charge_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "item_name"
    t.index ["user_id"], name: "index_pickup_requests_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.text "bio"
    t.text "image_data"
    t.string "address_line_one"
    t.string "address_line_two"
    t.string "city"
    t.string "state"
    t.string "postcode"
    t.string "country_code"
    t.string "latitude"
    t.string "longitude"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "user_to_pickups", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "pickup_request_id"
    t.datetime "response_at"
    t.boolean "accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pickup_request_id"], name: "index_user_to_pickups_on_pickup_request_id"
    t.index ["user_id"], name: "index_user_to_pickups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "conversations", "pickup_requests"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "pickup_requests", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "user_to_pickups", "pickup_requests"
  add_foreign_key "user_to_pickups", "users"
end
