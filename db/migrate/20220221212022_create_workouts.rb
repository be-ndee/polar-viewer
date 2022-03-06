class CreateWorkouts < ActiveRecord::Migration[6.1]
  def change
    create_table :workout_sports do |t|
      t.integer :identifier

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
  end
end

