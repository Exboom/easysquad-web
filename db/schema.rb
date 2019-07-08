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

ActiveRecord::Schema.define(version: 2019_07_04_071346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.integer "player_id"
    t.integer "team_id"
    t.integer "tournament_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chekins", force: :cascade do |t|
    t.integer "player_id"
    t.integer "team_id"
    t.integer "game_id"
    t.boolean "chekin", default: true
    t.integer "reason_id"
    t.boolean "presence"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id", "team_id", "game_id"], name: "uq_chekin", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.integer "user_id"
    t.string "what_event"
    t.datetime "time_event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "score", limit: 500
    t.integer "team_id"
    t.boolean "checkin"
    t.integer "player_id"
    t.integer "game_id"
    t.boolean "admin"
    t.integer "reason_id"
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
    t.integer "tournament_id"
    t.string "game_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations_tournaments", id: false, force: :cascade do |t|
    t.bigint "tournament_id", null: false
    t.bigint "location_id", null: false
  end

  create_table "player_teams", id: :serial, force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "team_id", null: false
    t.index ["player_id", "team_id"], name: "uq_player_team", unique: true
  end

  create_table "players", force: :cascade do |t|
    t.string "name", default: ""
    t.date "birthday"
    t.integer "gamenumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reasons", force: :cascade do |t|
    t.string "reason"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role"
  end

  create_table "team_tournaments", id: :serial, force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "tournament_id", null: false
    t.index ["team_id", "tournament_id"], name: "uq_team_tourn", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", default: ""
    t.integer "user_id"
    t.integer "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "default_password"
    t.index ["user_id"], name: "fki_owner_to_user_pk"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.string "season"
    t.integer "location_id"
    t.integer "federation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["federation_id"], name: "fki_tourn_to_feder_fk"
  end

  create_table "user_roles", id: :serial, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.bigint "team_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approved", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "tournaments", "federations", name: "tourn_to_feder_fk"
end
