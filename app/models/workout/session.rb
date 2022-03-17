class Session < ApplicationRecord
  self.table_name = "workout_sessions"

  belongs_to :workout, class_name: "Workout"

  def get_duration
    self.end - self.start
  end
end

