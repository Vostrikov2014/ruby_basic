=begin
Описание классов

Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).


Класс Route (Маршрут):
Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся
при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной


Класс Train (Поезд):
Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются
при создании экземпляра класса
Может набирать скорость
Может возвращать текущую скорость
Может тормозить (сбрасывать скорость до нуля)
Может возвращать количество вагонов
Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество
вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
Может принимать маршрут следования (объект класса Route).
При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на
1 станцию за раз.
Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end

class Station
  # Возвращает список всех поездов на станции, находящиеся в текущий момент
  attr_reader :name, :trains

  # Определяется название, которое указывается при создании станции
  def initialize(name)
    @name = name
    @trains = []
  end

  # Принимает поезда (по одному за раз)
  def train=(train)
    @trains << train
  end

  # Возвращает список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def type_trains(type)
    @trains.select { |t| t.type == type }
  end

  # Отправляет поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def del_train(train)
    @trains.delete(train)
  end
end


class Route

  # Выводит список всех станций по-порядку от начальной до конечной
  attr_reader :stations

  # Установка начальной и конечной станции
  def initialize(begin_station, end_station)
    @stations = [begin_station, end_station]
  end

  # Добавление промежуточных станций
  def station=(station)
    @stations.insert(-2, station)
  end

  # Удаление промежуточной станции из списка
  def del_station(station)
    @stations.delete(station)
  end
end


class Train
  #Установка скорости - Может набирать скорость
  # Может возвращать текущую скорость
  # Может принимать маршрут следования (объект класса Route).
  # Может возвращать количество вагонов

  attr_accessor :speed #, :station_index
  attr_reader :wagon_count, :train_number, :type, :route

  # Устанавливается номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов,
  # эти данные указываются при создании экземпляра класса
  def initialize(train_number, type, wagon_count)
    @train_number = train_number
    @type = type
    @wagon_count = wagon_count
    @speed = 0
    @route = []
    #@station_index = 0
  end

  # Останавливаем поезд
  def stop
    @speed = 0
  end

  # Прицепляет/отцепляет вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
  # Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  def add_wagon
    @wagon_count += 1 if @speed == 0
  end
  def del_wagon
    @wagon_count -= 1 if @speed == 0
  end


  def route=(route)
    # !!!При изменении маршрута "убираем поезд со всех станций".
    if @route.any?
      @route.each { |s| s.del_train(self) }
    end

    # Добавляем новый и помещаем на первую станцию.
    @route = route
    route.stations.first.train = self
  end


  ##########################################################################################
  # #################  СПРАВЛЕНИЯ ПО ЗАМЕЧАНИЮ #############################################

  def set_current_station
    # Подразумевается что поезд находится только на одной станции,
    # поэтому нужно следить за удалением "ушедших" поездов
    @current_station = @route.stations.find { |station| station.trains.include?(self) }
  end

  def forward
    # Тут идея такая, получил текущую станцию, отправил с нее поезд (удалил со станции).
    # Получил из маршрута следующую станцию по индексу текущей + 1  или  соответственно -1
    # и присвоил этой станции текущий поезд. Такая же логика в def station(type)
    self.set_current_station
    @route.stations[@route.stations.index(@current_station) + 1].train = self
    @current_station.del_train(self)
  end

  def backward
    self.set_current_station
    @route.stations[@route.stations.index(@current_station) - 1].train = self
    @current_station.del_train(self)
  end

  def station(type)
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

  ############################################################################################
  # ##########################################################################################


=begin
  # Перемещение между станциями, указанными в маршруте.
  # Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def forward_station
    if station_index < @route.stations.size - 1
      @route.stations.at(@station_index).del_train(self)
      self.station_index += 1
      @route.stations.at(@station_index).train = self
    end
  end

  def backward_station
    if station_index > 0
      @route.stations.at(@station_index).del_train(self)
      self.station_index -= 1
      @route.stations.at(@station_index).train = self
    end
  end

  #Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def station_return(type)
    if type == "пpедыдущая"
      self.route.stations[station_index - 1] if station_index != 0
    elsif type == "текущая"
      self.route.stations[station_index]
    elsif type == "следующая"
      self.route.stations[station_index + 1] if station_index < self.route.stations.size - 1
    end
  end
=end

end


#БЛОК ОСНОВНОЙ ПРОГРАММЫ

station1 = Station.new('Начальная')
station2 = Station.new('Станция2')
station3 = Station.new('Станция3')
station4 = Station.new('Конечная')

route_train22_49 = Route.new(station1, station4)
route_train22_49.station = station2
route_train22_49.station = station3

train22_49 = Train.new('22-49', 'грузовой', 21)

train22_49.route = route_train22_49

puts train22_49.station("текущая").name
puts ''

train22_49.forward
train22_49.forward
#puts train22_49.station("пpедыдущая").name
puts train22_49.station("текущая").name
#puts train22_49.station("следующая").name
puts ''


train22_49.backward
#puts train22_49.station("пpедыдущая").name
puts train22_49.station("текущая").name
#puts train22_49.station("следующая").name


=begin
# СТАНЦИЯ
# Станция имеет название, которое указывается при ее создании
first_station = Station.new('Начальная')
last_station = Station.new('Конечная')

# Станция может принимать поезда (по одному за раз)
train22_49 = Train.new('22-49', 'грузовой', 21)
first_station.train = train22_49
train392 = Train.new('392', 'пассажирский', 13)
first_station.train = train392

# Может возвращать список всех поездов на станции, находящиеся в текущий момент
puts "На станции #{first_station.name} находятся поезда №: #{first_station.trains}"

# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
puts "Грузовые поезда: #{first_station.type_trains("грузовой")}"
puts "Пассажирские поезда: #{first_station.type_trains("пассажирский")}"

# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции)
first_station.del_train(train22_49)
puts "На станции #{first_station.name} находятся поезда №: #{first_station.trains}"

# МАРШРУТЫ
# Маршрут имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании
# маршрута, а промежуточные могут добавляться между ними.
route_train22_49 = Route.new(first_station, last_station)

# Может добавлять промежуточную станцию в список
route_train22_49.station = Station.new("Станция1")
station2 = Station.new("Станция2") # Через переменную чтобы потом использовать при удалении
route_train22_49.station = station2
route_train22_49.station = Station.new("Станция3")

#Может удалять промежуточную станцию из списка
route_train22_49.del_station(station2)

#Может выводить список всех станций по-порядку от начальной до конечной
puts route_train22_49.stations

# ПОЕЗД
# Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются
# при создании экземпляра класса
train18_99 = Train.new("18-99", "грузовой", 34)
train340 = Train.new("340", "пассажирский", 15)

#Может набирать скорость
train18_99.speed = 23

#Может возвращать текущую скорость
puts train18_99.speed

#Может тормозить (сбрасывать скорость до нуля)
train18_99.stop
puts train18_99.speed

#Может возвращать количество вагонов
puts train18_99.wagon_count

#Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество
#вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
train18_99.stop
train18_99.add_wagon
train18_99.add_wagon

train18_99.del_wagon
puts train18_99.wagon_count

#Может принимать маршрут следования (объект класса Route)
train18_99.route = Route.new(first_station, last_station)

# При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
puts first_station.trains

# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на
# 1 станцию за раз.
train18_99.forward
train18_99.backward

#Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
puts train18_99.station('предыдущая')
puts train18_99.station('текущая')
puts train18_99.station('следующая')
=end

