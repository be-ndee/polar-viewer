class CalendarController < ApplicationController
  before_action :redirect_if_not_authenticated

  def index
    @year = params[:year]
    @month = params[:month]

    if not @year
      @year = Date.today.year
    else
      @year = Integer(@year)
    end

    if not @month
      @month = Date.today.month
    else
      @month = Integer(@month)
    end

    @first_month_date = Date.parse("#{@year}-#{@month}-01")
    @last_month_date = Date.parse("#{@year}-#{@month}-01").at_end_of_month

    @first_calendar_date = @first_month_date.beginning_of_week
    @last_calendar_date = @last_month_date.end_of_week

    @previous_month_date = @first_month_date - 1.month
    @next_month_date = @last_month_date + 1.month

    @weeks = Array.new
    dates = Array.new
    date = @first_calendar_date
    last_week = date.cweek
    while date <= @last_calendar_date do
      if date.cweek != last_week
        @weeks.append(dates)
        dates = Array.new
      end

      dates.append(date)

      last_week = date.cweek
      date += 1
    end

    if dates.length > 0
      @weeks.append(dates)
    end
  end
end
