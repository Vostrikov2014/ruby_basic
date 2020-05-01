%w[manufacturer instance_counter].each { |f| require_relative f }

class Train
  include Manufacturer
  include InstanceCounter

  attr_accessor :speed
  attr_reader :train_number, :route

  @@trains = {}

  NUMBER_FORMAT = /^[а-яa-z0-9]{3}-?[а-яa-z0-9]{2}$/i.freeze

  def initialize(train_number)
    @train_number = train_number
    @wagons = []
    @route = []
    @speed = 0
    @@trains[train_number] = self
    register_instance
    validate!
  end

  def self.find(number)
    @@trains[number]
  end

  def stop
    @speed = 0
  end

  def attach_wagon(wagon)
    @wagons << wagon if @speed.zero? && @train_type == wagon.wagon_type
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

    if type == "пpедыдущая"
      puts "Предыдущая станция: #{@route.stations[i - 1].name}"
    elsif type == "текущая"
      puts "Текущая станция: #{@current_station.name}"
    elsif type == "следующая"
      puts "Следующая станция : #{@route.stations[i + 1].name}"
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected
# методы используются только внутри класса
# пока нет необходимости вызывать извне
  def remove_train_from_station
    if @route.any?
      @route.each { |s| s.del_train(self) }
    end
  end

  def set_current_station
    @current_station = @route.stations.find { |station| station.trains.include?(self) }
  end

  def validate!
    raise "Введите номер" if @train_number.nil?
    raise "Номер не соответствует формату" if @train_number !~ NUMBER_FORMAT
  end

end