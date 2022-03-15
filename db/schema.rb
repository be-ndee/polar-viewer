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

ActiveRecord::Schema.define(version: 2022_02_21_212022) do

  create_table "workout_routes", force: :cascade do |t|
    t.integer "count"
    t.text "durations"
    t.text "latitudes"
    t.text "longitudes"
    t.text "gps_altitudes"
    t.text "satellite_amounts"
    t.integer "workout_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["workout_id"], name: "index_workout_routes_on_workout_id"
  end

  create_table "workout_samples_datas", force: :cascade do |t|
    t.integer "count"
    t.integer "interval_hours"
    t.integer "interval_minutes"
    t.integer "interval_seconds"
    t.float "interval_millis"
    t.text "heart_rates"
    t.text "cadences"
    t.text "altitudes"
    t.text "speeds"
    t.text "distances"
    t.integer "workout_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["workout_id"], name: "index_workout_samples_datas_on_workout_id"
  end

  create_table "workout_sessions", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.float "distance"
    t.integer "calories"
    t.integer "heart_rate_average"
    t.integer "heart_rate_maximum"
    t.integer "workout_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["workout_id"], name: "index_workout_sessions_on_workout_id"
  end

  create_table "workout_sports", force: :cascade do |t|
    t.integer "identifier"
    t.text "translations"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "workout_workouts", force: :cascade do |t|
    t.string "directory"
    t.datetime "date"
    t.integer "sport_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sport_id"], name: "index_workout_workouts_on_sport_id"
  end

  add_foreign_key "workout_routes", "workout_workouts", column: "workout_id"
  add_foreign_key "workout_samples_datas", "workout_workouts", column: "workout_id"
  add_foreign_key "workout_sessions", "workout_workouts", column: "workout_id"
  add_foreign_key "workout_workouts", "workout_sports", column: "sport_id"
end
