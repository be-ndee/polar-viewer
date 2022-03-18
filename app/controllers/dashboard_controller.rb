class DashboardController < ApplicationController
  def index
    a_week_ago = Date.today - 7

    @last_workout = Workout.order("date DESC").limit(1).first()
    workouts_last_week = Workout.where("DATE(date) >= ?", a_week_ago)

    @days_last_week = []
    date = a_week_ago
    while date < Date.today do
      day = {
        date: date,
        workouts: []
      }

      for workout in workouts_last_week
        if workout.start.at_beginning_of_day == date.at_beginning_of_day
          day[:workouts].append(workout)
        end
      end

      @days_last_week.append(day)

      date = date + 1
    end
  end
end
