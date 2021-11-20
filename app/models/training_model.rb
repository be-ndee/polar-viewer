class TrainingModel
  attr_reader :date
  attr_reader :time

  def initialize(date, time)
    @date = date
    @time = time
  end
end
