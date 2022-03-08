class SamplesData < ApplicationRecord
  self.table_name = "workout_samples_datas"

  belongs_to :workout, class_name: "Workout"
end

