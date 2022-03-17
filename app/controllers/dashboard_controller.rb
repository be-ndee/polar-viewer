class DashboardController < ApplicationController
  def index
    @last_workout = Workout.order("date DESC").limit(1).first()
  end
end
