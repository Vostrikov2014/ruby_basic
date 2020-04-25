class CargoTrain < Train
  def initialize(train_number)
    super
    @TRAIN_TYPE = 'cargo'
  end

  def attach_wagon(wagon)
    @wagons << wagon if @speed.zero? && @TRAIN_TYPE == wagon.WAGON_TYPE
  end

end
