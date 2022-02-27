class Workout < ApplicationRecord
  self.table_name = "workout_workouts"

  has_many :workout_workout_types
end

