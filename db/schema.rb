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

ActiveRecord::Schema.define(version: 20200302211332) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bridges", force: :cascade do |t|
    t.string "internalip"
    t.string "identifier"
    t.string "username"
    t.integer "home_id"
  end

  create_table "bulbs", force: :cascade do |t|
    t.integer "bridge_id"
    t.string "name"
    t.boolean "on"
    t.integer "brightness"
    t.integer "hue"
    t.integer "saturation"
    t.integer "color_temperature"
    t.string "color_mode"
    t.string "effect"
    t.integer "identifier"
    t.integer "group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.text "lights", default: [], array: true
    t.string "name"
    t.string "group_type"
    t.integer "identifier"
    t.boolean "state"
    t.integer "bridge_id"
  end

  create_table "homes", force: :cascade do |t|
    t.string "name"
    t.integer "zip_code"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.string "timezone"
    t.boolean "weather_widget", default: false
    t.integer "weather_widget_id"
    t.boolean "pet_widget", default: false
    t.boolean "list_widget", default: false
    t.boolean "hue_widget", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "description"
    t.integer "status"
    t.integer "list_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.integer "home_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "status1_status", default: "The animals haven't been fed today, and they are sad."
    t.string "status1", default: "Feeding Status"
    t.string "status2", default: "Outside Status"
    t.string "status1_message", default: "The little fluff balls were fed at"
    t.string "status2_status", default: "The dogs haven't been let outside today, they seem antsy."
    t.string "status2_message", default: "The dogs were let out at"
    t.string "day"
    t.integer "home_id"
  end

  create_table "scenes", force: :cascade do |t|
    t.string "identifier"
    t.string "name"
    t.integer "group_id"
    t.integer "group_number"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "provider", limit: 50, default: "", null: false
    t.string "uid", limit: 500, default: "", null: false
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "weather_widgets", force: :cascade do |t|
    t.integer "weather_id"
    t.string "weather_main"
    t.string "weather_description"
    t.string "weather_icon"
    t.float "current_temp"
    t.float "feels_like"
    t.float "temp_min"
    t.float "temp_max"
    t.integer "sunrise"
    t.integer "sunset"
    t.integer "widget_id"
    t.integer "home_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
