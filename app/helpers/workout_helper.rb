module WorkoutHelper
  def print_pace(pace)
    "%3.2f" % pace
  end

  def print_date(date)
    date.strftime('%Y-%m-%d')
  end

  def print_time(date)
    date.strftime('%H:%M')
  end

  def print_duration(seconds)
    hours = (seconds / (60 * 60)).floor()
    seconds = (seconds - hours * 3600).floor()
    minutes = (seconds / 60).floor()
    seconds = (seconds - minutes * 60).floor()
    return "%d:%02d:%02d h" % [hours, minutes, seconds]
  end

  def get_maximum_heart_rate(parsed)
    exercise_stats = parsed[:exercise_stats]
    if exercise_stats
      if exercise_stats.heart_rate
        return exercise_stats.heart_rate.maximum
      end
    end
  end

  def get_average_heart_rate(parsed)
    exercise_stats = parsed[:exercise_stats]
    if exercise_stats
      if exercise_stats.heart_rate
        return exercise_stats.heart_rate.average
      end
    end
  end
end
