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

def pb_sysdatetime_to_datetime(sysdatetime)
  if sysdatetime
    return sysdatetime.date.year > 0 ? DateTime.new(
      sysdatetime.date.year,
      sysdatetime.date.month,
      sysdatetime.date.day,
      sysdatetime.time.hour,
      sysdatetime.time.minute,
      sysdatetime.time.seconds,
      "%+i" % (sysdatetime.time_zone_offset / 60)
    ) : nil
  end
  return nil
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

    full_path = self.get_time_directory(date, time)

    if Dir.exists?(full_path)
      parsed = PolarDataParser.parse_training_session(full_path)
      sport = parsed[:sport]
      training_session = parsed[:training_session]
      exercise_stats = parsed[:exercise_stats]
      heart_rate = nil
      if exercise_stats
        if exercise_stats.heart_rate
          heart_rate = exercise_stats.heart_rate
        end
      end

      workout = Workout.new(
        directory: training_directory,
        start: pb_sysdatetime_to_datetime(training_session.start),
        end: pb_sysdatetime_to_datetime(training_session.end),
        heart_rate_average: heart_rate ? heart_rate.average : nil,
        heart_rate_maximum: heart_rate ? heart_rate.maximum : nil,
        calories: training_session.calories
      )
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

