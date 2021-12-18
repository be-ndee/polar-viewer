class DateModel
  attr_reader :date
  attr_reader :trainings

  def initialize(date, trainings)
    @date = date
    @trainings = trainings
  end
end

