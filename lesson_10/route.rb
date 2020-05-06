%w[instance_counter validation].each { |f| require_relative f }

class Route
  include InstanceCounter

  # lesson_10
  extend Validation::ClassMethods
  include Validation::InstanceMethods

  attr_reader :stations, :name

  validate :stations, :presence

  def initialize(begin_station, end_station)
    @stations = [begin_station, end_station]
    @name = ''
    validate!
    self.set_route_name
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
    self.set_route_name
  end

  def del_station(station)
    @stations.delete(station)
    self.set_route_name
  end

  #def valid?
  #  validate!
  #  true
  #rescue
  #  false
  #end

  # Helper Method it makes no sense to call from other objects
  protected

  def set_route_name
    @name = ''
    @stations.each { |station| @name += '/' + station.name }
  end

  #def validate!
  #  raise 'Введите первую станцию.' if @stations.first.nil?
  #  raise 'Введите конечную станцию.' if @stations.last.nil?
  #  raise 'Первая и конечная станции не должны совпадать.' if @stations.first == @stations.last
  #end
end
