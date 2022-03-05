require "#{File.dirname(__FILE__)}/../../lib/polar/lib/polar_data_parser"

def get_directory()
  return "#{File.dirname(__FILE__)}/../../synch/U/0"
end

def get_date_directory(date)
  return "#{self.get_directory()}/#{date}/E"
end

def get_time_directory(date, time)
  return "#{self.get_date_directory(date)}/#{time}"
end

def is_valid_date(date)
  return /^\d{8}$/ =~ date
end

def is_valid_time(time)
  return /^\d{6}$/ =~ time
end

def run_import
  directory = get_directory()

  if !Dir.exists?(directory)
    return false
  end

  training_directories = Dir.glob("#{directory}/*/E/*/")

  training_directories.each do |training_directory|
    training_directory.slice! "#{directory}/"

    date = training_directory[0..7]
    time = training_directory[11..16]

    training_directory = self.get_time_directory(date, time)

    if Dir.exists?(training_directory)
      parsed = PolarDataParser.parse_training_session(training_directory)
      sport = parsed[:sport]

      workout = Workout.new(date: "#{date} #{time}")
      workout.save

      type_names = sport.translation.map { |t| t.text.text if t.id.language == 'en' }
      types = Type.where(name: type_names)

      type_names.each do |type_name|
        type = Type.where(name: type_name).first

        if type == nil
          type = Type.new(name: type_name)
          type.save
        end

        workout_type = WorkoutType.new(workout: workout, type: type)
        workout_type.save
      end
    end
  end
end

