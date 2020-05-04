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

ActiveRecord::Schema.define(version: 2020_05_04_212318) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "bet_type"
    t.string "position"
    t.integer "odds"
    t.decimal "line"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "prediction_delta"
    t.string "outcome"
    t.index ["event_id"], name: "index_bets_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "league_id", null: false
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "home_score"
    t.integer "away_score"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "game_id"
    t.index ["league_id"], name: "index_events_on_league_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.bigint "sport_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sport_id"], name: "index_leagues_on_sport_id"
  end

  create_table "predictions", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.decimal "home_score"
    t.decimal "away_score"
    t.decimal "home_confidence"
    t.decimal "away_confidence"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_predictions_on_event_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "sports", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.string "city"
    t.string "state"
    t.bigint "league_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "db_lookup"
    t.string "py_lookup"
    t.index ["league_id"], name: "index_teams_on_league_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "bet_id", null: false
    t.decimal "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bet_id"], name: "index_tickets_on_bet_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.decimal "balance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "bets", "events"
  add_foreign_key "events", "leagues"
  add_foreign_key "leagues", "sports"
  add_foreign_key "predictions", "events"
  add_foreign_key "teams", "leagues"
  add_foreign_key "tickets", "bets"
  add_foreign_key "tickets", "users"
end
