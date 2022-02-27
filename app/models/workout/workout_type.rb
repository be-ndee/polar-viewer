class WorkoutType < ApplicationRecord
  self.table_name = "workout_workout_types"

  belongs_to :workout, class_name: "Workout", foreign_key: "workout_id"
  belongs_to :type, class_name: "Type", foreign_key: "type_id"
end


