class CargoTrain < Train
  attr_reader :train_type, :wagons

  def initialize(train_number)
    super(train_number)
    @train_type = 'cargo'
  end

end
