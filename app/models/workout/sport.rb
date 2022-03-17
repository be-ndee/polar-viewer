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

  def get_fontawesome_icon_class
    name = self.get_name("en")
    if name == "Running"
      return "fa-solid fa-person-running"
    end
    if name == "Swimming"
      return "fa-solid fa-person-swimming"
    end
    if name == "Yoga"
      return "fa-solid fa-spa"
    end
    if name == "Other indoor"
      return "fa-solid fa-dumbbell"
    end
    #if name == "TODO"
      #return "fa-solid fa-dumbbell"
    #end
    #if name == "TODO"
      #return "fa-solid fa-person-biking"
    #end
    return nil
  end
end

