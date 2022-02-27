class CreateWorkouts < ActiveRecord::Migration[6.1]
  def change
    create_table :workout_types do |t|
      t.string :name

      t.timestamps
    end

    create_table :workout_workouts do |t|
      t.datetime :date, null: false

      t.timestamps
    end

    create_table :workout_workout_types do |t|
      t.references :workout, null: false, foreign_key: {to_table: "workout_workouts"}
      t.references :type, null: false, foreign_key: {to_table: "workout_types"}

      t.timestamps
    end
  end
end

