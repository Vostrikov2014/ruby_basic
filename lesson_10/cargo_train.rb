class CargoTrain < Train
  attr_reader :type, :wagons

  # lesson_10
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super(number)
    @type = 'cargo'
  end
end
