class Route
  attr_reader :stations, :name

  def initialize(begin_station, end_station)
    @stations = [begin_station, end_station]
    @name = ''
    self.set_route_name
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def del_station(station)
    @stations.delete(station)
  end

  protected

  def set_route_name
    @stations.each { |station| @name += '/' + station.name }
  end

end

