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
  Route.delete_all
  SamplesData.delete_all
  Session.delete_all
  Workout.delete_all
  Sport.delete_all

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
      training_session = parsed[:training_session]
      exercise_stats = parsed[:exercise_stats]

      start = pb_sysdatetime_to_datetime(training_session.start)

      heart_rate = nil
      if exercise_stats
        if exercise_stats.heart_rate
          heart_rate = exercise_stats.heart_rate
        end
      end

      sport_identifier = parsed[:sport].identifier.value

      sport = Sport.where(identifier: sport_identifier).first
      if sport == nil
        translations = Hash.new
        parsed[:sport].translation.each do |translation|
          translations[translation.id.language] = translation.text.text
        end

        sport = Sport.new(
          identifier: sport_identifier,
          translations: translations.to_json
        )
        sport.save
      end

      workout = Workout.new(
        directory: training_directory,
        date: start,
        sport_id: sport.id
      )
      workout.save

      session = Session.new(
        start: start,
        end: pb_sysdatetime_to_datetime(training_session.end),
        distance: training_session.distance,
        calories: training_session.calories,
        heart_rate_average: heart_rate ? heart_rate.average : nil,
        heart_rate_maximum: heart_rate ? heart_rate.maximum : nil,
        workout_id: workout.id
      )
      session.save

      samples = parsed[:samples]

      samples_data = SamplesData.new(
        count: samples.speed_samples.count,
        interval_hours: samples.recording_interval.hours,
        interval_minutes: samples.recording_interval.minutes,
        interval_seconds: samples.recording_interval.seconds,
        interval_millis: samples.recording_interval.millis.to_f,
        heart_rates: samples.heart_rate_samples.to_json,
        cadences: samples.cadence_samples.to_json,
        altitudes: samples.altitude_samples.to_json,
        speeds: samples.speed_samples.to_json,
        distances: samples.distance_samples.to_json,
        workout_id: workout.id
      )
      samples_data.save

      route_samples = parsed[:route_samples]

      route = Route.new(
        count: route_samples.latitude.count,
        durations: route_samples.duration.to_json,
        latitudes: route_samples.latitude.to_json,
        longitudes: route_samples.longitude.to_json,
        gps_altitudes: route_samples.gps_altitude.to_json,
        satellite_amounts: route_samples.satellite_amount.to_json,
        workout_id: workout.id
      )
      route.save
    end
  end
end

