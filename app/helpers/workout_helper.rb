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
end
