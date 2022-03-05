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

  create_table "workout_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "workout_workout_types", force: :cascade do |t|
    t.integer "workout_id", null: false
    t.integer "type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["type_id"], name: "index_workout_workout_types_on_type_id"
    t.index ["workout_id"], name: "index_workout_workout_types_on_workout_id"
  end

  create_table "workout_workouts", force: :cascade do |t|
    t.string "directory"
    t.datetime "start"
    t.datetime "end"
    t.integer "heart_rate_average"
    t.integer "heart_rate_maximum"
    t.integer "calories"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "workout_workout_types", "workout_types", column: "type_id"
  add_foreign_key "workout_workout_types", "workout_workouts", column: "workout_id"
end
