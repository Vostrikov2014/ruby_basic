%w[instance_counter].each { |f| require_relative f }

class Route
  include InstanceCounter

  attr_reader :stations, :name

  def initialize(begin_station, end_station)
    @stations = [begin_station, end_station]
    @name = ''
    self.set_route_name
    register_instance
    validate!
  end

  def add_station(station)
    @stations.insert(-2, station)
    self.set_route_name
  end

  def del_station(station)
    @stations.delete(station)
    self.set_route_name
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  # Вспомогательный метод. не имеет смысла вызывать из других объектов
  protected

  def set_route_name
    @name = ''
    @stations.each { |station| @name += '/' + station.name }
  end

  def validate!
    raise "Введите первую станцию." if @stations.first.nil?
    raise "Введите конечную станцию." if @stations.last.nil?
    raise "Первая и конечная станции не должны совпадать." if @stations.first == @stations.last
  end
end

