class CreateWorkouts < ActiveRecord::Migration[6.1]
  def change
    create_table :workout_sports do |t|
      t.integer :identifier
      t.text :translations

      t.timestamps
    end

    create_table :workout_workouts do |t|
      t.string :directory
      t.datetime :date

      t.references :sport, null: false, foreign_key: {to_table: "workout_sports"}

      t.timestamps
    end

    create_table :workout_sessions do |t|
      t.datetime :start
      t.datetime :end
      t.float :distance
      t.integer :calories
      t.integer :heart_rate_average
      t.integer :heart_rate_maximum

      t.references :workout, null: false, foreign_key: {to_table: "workout_workouts"}

      t.timestamps
    end

    create_table :workout_samples_datas do |t|
      t.integer :count
      t.integer :interval_hours
      t.integer :interval_minutes
      t.integer :interval_seconds
      t.float :interval_millis
      t.text :heart_rates
      t.text :cadences
      t.text :altitudes
      t.text :speeds
      t.text :distances

      t.references :workout, null: false, foreign_key: {to_table: "workout_workouts"}

      t.timestamps
    end

    create_table :workout_routes do |t|
      t.integer :count
      t.text :durations
      t.text :latitudes
      t.text :longitudes
      t.text :gps_altitudes
      t.text :satellite_amounts

      t.references :workout, null: false, foreign_key: {to_table: "workout_workouts"}

      t.timestamps
    end
  end
end

