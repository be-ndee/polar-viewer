class Type < ApplicationRecord
  self.table_name = "workout_types"

  has_many :workout_workout_types
end
