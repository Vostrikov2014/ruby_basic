class PassengerTrain < Train
  attr_reader :train_type, :wagons

  def initialize(train_number)
    super
    @train_type = 'passenger'
  end

end
