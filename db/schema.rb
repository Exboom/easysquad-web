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

ActiveRecord::Schema.define(version: 2019_04_23_114551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.integer "player"
    t.integer "team"
    t.integer "tournament"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chekins", force: :cascade do |t|
    t.integer "player"
    t.integer "team"
    t.integer "game"
    t.boolean "chekin", default: false
    t.integer "reasons"
    t.boolean "presence", default: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer "whose_event"
    t.string "what_event"
    t.datetime "time_event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "federations", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "contacts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer "team_one"
    t.integer "team_two"
    t.string "name"
    t.datetime "time"
    t.integer "tournament"
    t.string "game_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logins", force: :cascade do |t|
    t.string "login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_teams", primary_key: ["player", "team"], force: :cascade do |t|
    t.integer "player", null: false
    t.integer "team", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name", default: ""
    t.date "birthday"
    t.integer "gamenumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "reasons", force: :cascade do |t|
    t.string "reason"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role"
  end

  create_table "team_tournaments", primary_key: ["team", "tournaments"], force: :cascade do |t|
    t.integer "team", null: false
    t.integer "tournaments", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", default: ""
    t.integer "owner"
    t.integer "captain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.string "season"
    t.integer "location"
    t.integer "federation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", id: false, force: :cascade do |t|
    t.bigint "user1", null: false
    t.bigint "role", null: false
    t.bigint "team"
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

end
