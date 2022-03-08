class Route < ApplicationRecord
  self.table_name = "workout_routes"

  belongs_to :workout, class_name: "Workout"
end

