class PassengerTrain < Train
  attr_reader :TRAIN_TYPE, :wagons

  def initialize(train_number)
    super
    @TRAIN_TYPE = 'passenger'
  end

  def attach_wagon(wagon)
    @wagons << wagon if @speed.zero? && @TRAIN_TYPE == wagon.WAGON_TYPE
  end

end
