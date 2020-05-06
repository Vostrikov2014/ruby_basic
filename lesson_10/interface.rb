%w[station route train passenger_train cargo_train wagon wagon_passenger wagon_cargo manufacturer].each { |f| require_relative f }

class Interface

  def initialize
    @station = []
    @route = []
    @wagon_passenger = []
    @wagon_cargo = []
    @train = []
    @passenger_train = []
    @cargo_train = []
  end

  def seed

    @station << Station.new('Moscow')
    @station << Station.new('Smolensk')
    @station << Station.new('Gagarin')
    @station << Station.new('Kursk')
    @station << Station.new('Krasnodar')
    @station << Station.new('Voroneg')
    @station << Station.new('Rayzan')

    route = Route.new(@station[0], @station[1])
    @route << route
    route_1 = Route.new(@station[3], @station[6])
    route_1.add_station(@station[4])
    route_1.add_station(@station[5])
    @route << route_1

    train_p = PassengerTrain.new('340-23')
    @train << train_p
    @passenger_train << train_p

    train_p.set_route(route)

    train_c = CargoTrain.new('122-45')
    @train << train_c
    @cargo_train << train_c

    train_c.set_route(route)

    wagon_p_1 = WagonPassenger.new(1,53)
    wagon_p_2 = WagonPassenger.new(2,53)
    wagon_c_1 = WagonCargo.new(1,3456)
    wagon_c_2 = WagonCargo.new(2,3456)
    @wagon_passenger << wagon_p_1
    @wagon_cargo << wagon_c_1
    @wagon_passenger << wagon_p_2
    @wagon_cargo << wagon_c_2

    train_p.attach_wagon(@wagon_passenger[0])
    train_p.attach_wagon(@wagon_passenger[1])
    train_c.attach_wagon(@wagon_cargo[0])
    train_c.attach_wagon(@wagon_cargo[1])
  end

  def run

    loop do
      ['Введите число для выбора операции:', '1 - создать станцию', '2 - создать или редактировать маршрут',
       '3 - создать поезд', '4 - назначить маршрут поезду', '5 - добавить вагон поезду', '6 - удалить вагон поезду',
       '7 - переместить поезд по маршруту', '8 - просмотр местоположения поезда', '9 - просмотр списка станций и поездов на станциях',
       '10 - просмотр вагонов поезда', '11 - посадить пассажира / загрузить вагон', '0 - ВЫХОД'].each { |f| puts f}

      entered_number = gets.chomp.to_i

      case entered_number
      when 1 then create_station
      when 2 then create_route
      when 3 then create_train
      when 4 then set_route_train
      when 5 then attach_wagon
      when 6 then detach_wagon
      when 7 then train_move
      when 8 then location_train
      when 9 then list_train
      when 10 then puts_wagon
      when 11 then load_wagon
      when 0
        puts 'Вы закончили работу с программой'
        break
      end
    end
  end

  private

  def puts_menu(list_menu, hiading_menu = '')
    puts hiading_menu

    list_menu.each_with_index do |value, index|
      if value.class == Train || value.class == PassengerTrain || value.class == CargoTrain
        puts " #{index+1} - #{value.train_type} №#{value.train_number}"
      elsif value.class == Wagon || value.class == WagonPassenger || value.class == WagonCargo
        puts " #{index+1} - #{value.number}"
      elsif
        puts " #{index+1} - #{value.name}"
      end
    end
    puts ' 0 - ОТМЕНА'
  end

  def create_station
    puts 'Введите название станции'
    name = gets.chomp
    @station << Station.new(name)
    puts "Создана станция: #{@station.last.name}"
  end

  def create_route
    ['Введите число для выбора операции:', '1 - создать маршрут',
     '2 - редактировать маршрут', '0 - ОТМЕНА'].each { |f| puts f }

    entered_number = gets.chomp.to_i

    case entered_number
    when 1 then create_new_route
    when 2 then edit_route
    when 0 then puts 'Редактирование маршрута отменено'
    end
  end

  def create_new_route
    puts_menu(@station, 'Введите число - начало пути')
    entered_number = gets.chomp.to_i - 1
    puts_menu(@station, 'Введите число - окончание пути')
    entered_number1 = gets.chomp.to_i - 1

    @route << Route.new(@station[entered_number], @station[entered_number1])
  end

  def edit_route
    ['Введите число для выбора операции:', '1 - добавить станцию',
     '2 - удалить станцию', '0 - ОТМЕНА'].each { |f| puts f}

    entered_number = gets.chomp.to_i

    case entered_number
    when 1 then add_station_in_route
    when 2 then del_station_from_route
    when 0 then puts 'Редактирование маршрута отменено'
    end
  end

  def add_station_in_route
    puts_menu(@route, 'Введите число - редактируемый маршрут')
    route = @route[gets.chomp.to_i - 1]

    puts_menu(@station, 'Введите число - добавить станцию')
    station = @station[gets.chomp.to_i - 1]

    route.add_station(station)
  end

  def del_station_from_route
    puts_menu(@route, 'Введите число - редактируемый маршрут')
    route = @route[gets.chomp.to_i - 1]

    puts_menu(@station, 'Введите число - удалить станцию')
    station = @station[gets.chomp.to_i - 1]

    route.del_station(station)
  end

  def create_train
    ['Введите число для выбора операции:', '1 - создать ПАССАЖИРСКИЙ поезд',
     '2 - создать ГРУЗОВОЙ поезд', '0 - ОТМЕНА'].each { |f| puts f }

    entered_number = gets.chomp.to_i

    case entered_number
    when 1 then create_passenger_train
    when 2 then create_cargo_train
    when 0 then puts 'Добавление поезда отменено'
    end
  end

  def create_passenger_train
    ['Введите номер пассажирского поезда',
    'Допустимый формат: три буквы или цифры в любом порядке, необязательный дефис (может быть, а может нет) и
     еще 2 буквы или цифры после дефиса. Пример: 340-МН или 340МН или 34000 и т.д.'].each { |f| puts f }

    train_number = gets.chomp

    train = PassengerTrain.new(train_number)
    @train << train
    @passenger_train << train

    puts "Добавлен пассажирский поезд №#{train_number}"

  rescue RuntimeError => e
    puts "#{e.message}"
    retry
  end

  def create_cargo_train
    ['Введите номер грузового поезда', 'Допустимый формат: три буквы или цифры в любом порядке, необязательный',
     'дефис (может быть, а может нет) и еще 2 буквы или цифры после дефиса.',
     'Пример: 340-МН или 340МН или 34000 и т.д.'].each { |f| puts f }

    train_number = gets.chomp

    train = CargoTrain.new(train_number)
    @train << train
    @cargo_train << train
    puts "Добавлен грузовой поезд №#{train_number}"
  rescue RuntimeError => e
    puts "#{e.message}"
    retry
  end

  def set_route_train
    puts_menu(@train, 'Введите число - поезд которому добавляется маршрут' )
    train = @train[gets.chomp.to_i - 1]
    puts_menu(@route, 'Введите число - маршрут который назначить поезду')
    route = @route[gets.chomp.to_i - 1]

    train.set_route(route)
    puts "Поезду #{train.train_number} обавлен маршрут #{route.name}"
  end

  def attach_wagon
    puts_menu(@train, 'Введите число - поезд которому добавляется вагон' )
    train = @train[gets.chomp.to_i - 1]

    if train.train_type == 'passenger'

      puts 'Введите число - количество мест в вагоне'
      all_place = gets.chomp.to_i
      wagon = WagonPassenger.new(all_place)
      @wagon_passenger << wagon
      train.attach_wagon(wagon)

    elsif train.train_type == 'cargo'

      puts 'Введите число - объем вагона'
      all_volume = gets.chomp.to_i
      wagon = WagonCargo.new(all_volume)
      @wagon_cargo << wagon
      train.attach_wagon(wagon)
    end
  end

  def detach_wagon
    puts_menu(@train, 'Введите число - поезд у которого удаляется вагон' )
    train = @train[gets.chomp.to_i - 1]

    if train.train_type == 'passenger'
      puts_menu(@wagon_passenger, 'Введите число - вагон который хотите удалить' )
      wagon = @wagon_passenger[gets.chomp.to_i - 1]
      train.detach_wagon(wagon)
    elsif train.train_type == 'cargo'
      puts_menu(@wagon_cargo, 'Введите число - вагон который хотите удалить' )
      wagon = @wagon_cargo[gets.chomp.to_i - 1]
      train.detach_wagon(wagon)
    end
  end

  def train_move
    puts_menu(@train, 'Введите число - поезд который необходимо переместить по маршрут' )
    train = @train[gets.chomp.to_i - 1]

    ['Введите число - переместить:', '1 - ВПЕРЕД на одну станцию',
     '2 - НАЗАД на одну станцию', '0 - ОТМЕНА'].each { |f| puts f}

    entered_number = gets.chomp.to_i

    case entered_number
    when 1 then train.move_next_station
    when 2 then train.move_previous_station
    when 0 then puts 'Перемещение отменено'
    end
  end

  def location_train
    puts_menu(@train, 'Введите число - поезд местоположение которого необходимо посмотреть' )
    train = @train[gets.chomp.to_i - 1]

    ['Введите число - тип местоположения:', '1 - пpедыдущая',
     '2 - текущая', '3 - следующая', '0 - ОТМЕНА'].each { |f| puts f}

    entered_number = gets.chomp.to_i

    type = %w[пpедыдущая текущая следующая]

    if entered_number == 1 || entered_number == 2 || entered_number == 3
      train.location_train(type[entered_number - 1])
    elsif entered_number == 0
      puts 'Перемещение отменено'
    end
  end

  def list_train
    @station.each do |station|
      puts "СТАНЦИЯ  #{station.name}"
      station.each_train do |train|
        puts "Поезд: #{train.train_number}, #{train.train_type}, #{train.wagons.size}" if station.trains.any?
        puts 'Вагоны: '
        list_wagon(train)
      end
    end
  end

  def puts_wagon
    puts_menu(@train, 'Введите число - поезд вагоны которого просмотреть' )
    train = @train[gets.chomp.to_i - 1]

    print "ПОЕЗД № #{train.train_number}; "
    puts 'Вагоны: '
    list_wagon(train)
  end

  def list_wagon(train)
    if train.train_type == 'passenger'
      train.each_wagon do |wagon|
        puts "#{wagon.wagon_type}, #{wagon.free_place}, #{wagon.busy_place}"
      end
    elsif train.train_type == 'cargo'
      train.each_wagon do |wagon|
        puts "#{wagon.wagon_type}, #{wagon.free_volume}, #{wagon.busy_volume}"
      end
    end
  end

  def load_wagon
    puts_menu(@train, 'Введите число - поезд в вагоны которого хотите посадить пассажиров / добавить груз')
    train = @train[gets.chomp.to_i - 1]

    if train.wagons.none?
      puts 'У этого поезда нет вагонов'
    else
      if train.train_type == 'passenger'
        puts_menu(@wagon_passenger, 'Введите номер вагона')
        n = gets.chomp.to_i

        if n.zero?
          puts 'Ввод отменен!'
        else
          wagon = @wagon_passenger[n - 1]
          wagon.take_place
          puts 'Пассажир сел в вагон'
        end

      elsif train.train_type == 'cargo'

        puts_menu(@wagon_cargo, 'Введите номер вагона')
        n = gets.chomp.to_i

        if n.zero?
          puts 'Ввод отменен!'
        else
          wagon = @wagon_cargo[n - 1]
          puts 'Введите обем груза'
          cargo_volume = gets.chomp.to_i
          wagon.take_volume(cargo_volume)
        end
      end
    end
  end
end