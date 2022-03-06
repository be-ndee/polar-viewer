class Workout < ApplicationRecord
  self.table_name = "workout_workouts"

  belongs_to :sport, class_name: "Sport"
  has_one :session, class_name: "Session"
end

