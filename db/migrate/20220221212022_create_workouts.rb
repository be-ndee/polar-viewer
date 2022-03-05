class CreateWorkouts < ActiveRecord::Migration[6.1]
  def change
    create_table :workout_types do |t|
      t.string :name

      t.timestamps
    end

    create_table :workout_workouts do |t|
      t.string :directory
      t.datetime :start
      t.datetime :end
      t.integer :heart_rate_average
      t.integer :heart_rate_maximum
      t.integer :calories

      t.timestamps
    end

    create_table :workout_workout_types do |t|
      t.references :workout, null: false, foreign_key: {to_table: "workout_workouts"}
      t.references :type, null: false, foreign_key: {to_table: "workout_types"}

      t.timestamps
    end
  end
end

