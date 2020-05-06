%w[manufacturer instance_counter validation].each { |f| require_relative f }

class Train
  include Manufacturer
  include InstanceCounter

  # lesson_10
  extend Validation::ClassMethods
  include Validation::InstanceMethods

  attr_accessor :speed
  attr_reader :number, :route, :wagons

  @@trains = {}

  NUMBER_FORMAT = /^[а-яa-z0-9]{3}-?[а-яa-z0-9]{2}$/i.freeze

  # lesson_10
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    @number = number
    @wagons = []
    @route = []
    @speed = 0
    validate!
    @@trains[number] = self
    register_instance
  end

  def each_wagon
    @wagons.each { |wagon| yield wagon }
  end

  def self.find(number)
    @@trains[number]
  end

  def stop
    @speed = 0
  end

  def attach_wagon(wagon)
    @wagons << wagon if @speed.zero? && @type == wagon.type
  end

  def detach_wagon(wagon)
    @wagons.delete(wagon)
  end

  def set_route(route)
    self.remove_train_from_station
    @route = route
    route.stations.first.trains << self
  end

  def move_next_station
    self.set_current_station
    @route.stations[@route.stations.index(@current_station) + 1].trains << self
    @current_station.del_train(self)
  end

  def move_previous_station
    self.set_current_station
    @route.stations[@route.stations.index(@current_station) - 1].trains << self
    @current_station.del_train(self)
  end

  def location_train(type)
    self.set_current_station
    i = @route.stations.index(@current_station)

    if type == 'пpедыдущая'
      puts "Предыдущая станция: #{@route.stations[i - 1].name}"
    elsif type == 'текущая'
      puts "Текущая станция: #{@current_station.name}"
    elsif type == 'следующая'
      puts "Следующая станция : #{@route.stations[i + 1].name}"
    end
  end

  #def valid?
  #  validate!
  #  true
  #rescue
  #  false
  #end

  protected

  def remove_train_from_station
    @route.each { |station| station.del_train(self) } if @route.any?
  end

  def set_current_station
    @current_station = @route.stations.find { |station| station.trains.include?(self) }
  end

  #def validate!
  #  raise 'Введите номер' if @train_number.nil?
  #  raise 'Номер не соответствует формату' if @train_number !~ NUMBER_FORMAT
  #end
end