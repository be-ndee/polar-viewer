class Session < ApplicationRecord
  self.table_name = "workout_sessions"

  belongs_to :workout, class_name: "Workout"
end

