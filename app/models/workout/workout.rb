class Workout < ApplicationRecord
  self.table_name = "workout_workouts"

  belongs_to :sport, class_name: "Sport"
  has_one :session, class_name: "Session"
  has_one :samples_data, class_name: "SamplesData"
  has_one :route, class_name: "Route"
end

