class Sport < ApplicationRecord
  self.table_name = "workout_sports"

  has_many :workouts, class_name: "Workout"

  def get_name(language)
    translations = JSON.parse(self.translations)
    if translations.has_key? language
      return translations[language]
    end
    return nil
  end
end

