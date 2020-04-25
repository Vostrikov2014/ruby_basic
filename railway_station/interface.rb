%w[station route train wagon_passenger wagon_cargo passenger_train cargo_train].each { |f| require_relative f }

class Interface

  def initialize
    @station = []
    @route = []
    @wagon_passenger = []
    @wagon_cargo = []
    @passenger_train = []
    @cargo_train = []
  end

  # seed ###
  #
  def seed
    @station << Station.new('Moscow')
    @station << Station.new('Smolensk')
    @station << Station.new('Gagarin')

    @route << Route.new(@station[0], @station[1])
  end

  def run
    loop do
      puts ''
      puts 'Введите число для выбора операции:'
      puts ' 1 - создать станцию'
      puts ' 2 - создать или редактировать маршрут'
      puts ' 3 - создать поезд'
      puts ' 4 - назначить маршрут поезду'
      puts ' 5 - добавить вагон поезду'
      puts ' 6 - удалить вагон поезду'
      puts ' 7 - переместить поезд по маршруту'
      puts ' 8 - просмотр списка станций и поездов на станциях'
      puts ' 0 - ВЫХОД'
      puts ''

      entered_number = gets.chomp.to_i

      case entered_number
      when 1
        create_station
      when 2
        create_route
      when 3
        create_train
      when 1
        create_station
      when 1
        create_station
      when 0
        puts 'Вы закончили работу с программой'
        break
      end
    end
  end


  private

  # Формируем меню выбора по массиву
  def puts_menu(list_menu, hiading_menu = '')
    puts hiading_menu

    list_menu.each_with_index do |value, index|
      if value.class == Train
        puts " #{index+1} - #{value.@TRAIN_TYPE} №#{value.number}"
      elsif
        puts " #{index+1} - #{value.name}"
      end
    end
    puts ' 0 - ОТМЕНА'
  end


  # CREATE STATION ###
  #
  def create_station
    puts 'Введите название станции'
    name = gets.chomp
    @station << Station.new(name)
    puts "Создана станция: #{@station.last.name}"
  end


  # CREATE & EDIT ROUTE ###
  #
  def create_route
    puts 'Введите число для выбора операции:'
    puts ' 1 - создать маршрут'
    puts ' 2 - редактировать маршрут'
    puts ' 0 - ОТМЕНА'

    entered_number = gets.chomp.to_i

    case entered_number
    when 1
      create_new_route
    when 2
      edit_route
    when 0
      puts 'Редактирование маршрута отменено'
    else
      puts "'#{entered_number}' - операция несуществует!"
    end
  end

  def create_new_route
    puts_selection_menu(@station, 'Введите число - начало пути')
    entered_number = gets.chomp.to_i - 1
    puts_selection_menu(@station, 'Введите число - окончание пути')
    entered_number1 = gets.chomp.to_i - 1

    @route << Route.new(@station[entered_number], @station[entered_number1])
  end

  def edit_route
    puts 'Введите число для выбора операции:'
    puts ' 1 - добавить станцию'
    puts ' 2 - удалить станцию'
    puts ' 0 - ОТМЕНА'
    entered_number = gets.chomp.to_i

    case entered_number
    when 1
      add_station_in_route
    when 2
      del_station_from_route
    when 0
      puts 'Редактирование маршрута отменено'
    else
      puts "'#{entered_number}' - операция несуществует!"
    end
  end

  def add_station_in_route
    puts_menu(@route, 'Введите число - редактируемый маршрут')
    ruote = @route[gets.chomp.to_i - 1]

    puts_menu(@station, 'Введите число - добавить станцию')
    station = @station[gets.chomp.to_i - 1]

    route.add_station(station)
  end

  def del_station_from_route
    puts_menu(@route, 'Введите число - редактируемый маршрут')
    ruote = @route[gets.chomp.to_i - 1]

    puts_menu(@station, 'Введите число - удалить станцию')
    station = @station[gets.chomp.to_i - 1]

    route.del_station(station)
  end


  # CREATE TRAIN ###
  #
  def create_train
    puts 'Введите число для выбора операции:'
    puts ' 1 - создать ПАССАЖИРСКИЙ поезд'
    puts ' 2 - создать ГРУЗОВОЙ поезд'
    puts ' 0 - ОТМЕНА'

    entered_number = gets.chomp.to_i

    case entered_number
    when 1
      create_passenger_train
    when 2
      create_cargo_train
    when 0
      puts 'Добавление поезда отменено'
    else
      puts "'#{entered_number}' - операция несуществует!"
    end
  end

  def create_passenger_train
    puts 'Введите номер пассажирского поезда'
    train_number = gets.chomp
    @passenger_train << PassengerTrain.new(train_number)
    puts "Добавлен пассажирский поезд №#{@passenger_train.last.train_number}"
  end

  def create_cargo_train
    puts 'Введите номер грузового поезда'
    train_number = gets.chomp
    @cargo_train << CargoTrain.new(train_number)
    puts "Добавлен грузовой поезд №#{@cargo_train.last.train_number}"
  end

end