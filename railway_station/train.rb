class Train
  attr_accessor :speed
  attr_reader :wagon_count, :train_number, :type, :route

  def initialize(train_number, type, wagon_count)
    @train_number = train_number
    @type = type
    @wagon_count = wagon_count
    @speed = 0
    @route = []
  end

  def stop
    @speed = 0
  end

  def attach_wagon
    @wagon_count += 1 if @speed == 0
  end
  def detach_wagon
    @wagon_count -= 1 if @speed == 0
  end

  def set_route(route)
    self.remove_train_from_station

    @route = route
    route.stations.first.train = self
  end

  def move_next_station
    self.set_current_station
    @route.stations[@route.stations.index(@current_station) + 1].train = self
    @current_station.del_train(self)
  end

  def move_previous_station
    self.set_current_station
    @route.stations[@route.stations.index(@current_station) - 1].train = self
    @current_station.del_train(self)
  end

  def location_train(type)
    self.set_current_station
    i = @route.stations.index(@current_station)

    if type == "пpедыдущая"
      @route.stations[i - 1]
    elsif type == "текущая"
      @current_station
    elsif type == "следующая"
      @route.stations[i + 1]
    end
  end

  protected

  def remove_train_from_station
    if @route.any?
      @route.each { |s| s.del_train(self) }
    end
  end

  def set_current_station
    @current_station = @route.stations.find { |station| station.trains.include?(self) }
  end
end