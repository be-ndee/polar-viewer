class Sport < ApplicationRecord
  self.table_name = "workout_sports"

  has_many :workouts, class_name: "Workout"
end

