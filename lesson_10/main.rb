require_relative 'route'
require_relative 'station'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'wagon_passenger'
require_relative 'wagon_cargo'

def print_menu
  system('clear')
  puts "\
0. Создать данные
1. Создать станции
2. Создать поезда
3. Создать маршрут
4. Назначить маршрут
5. Прицепить вагоны
6. Отцепить вагоны
7. Переместить поезд
8. Список станций и поездов
9. Занять место или объём в вагоне
00. Выход"
  print '> '
end

def create_test_data
  routes ||= []
  Station.new('Голутвин')
  Station.new('Луховицы')
  Station.new('Кривандино')
  Station.new('Курская')
  Station.new('Кусково')
  Station.new('Реутово')
  Station.new('Фрязево')
  Station.new('Павловский Посад')
  Station.new('Люблино-Сортировочное')
  Station.new('Царицыно')
  Station.new('Серпухов')
  PassengerTrain.new('ПАС-01')
  PassengerTrain.new('ПАС-02')
  PassengerTrain.new('ПАС-03')
  CargoTrain.new('ГРЗ-01')
  CargoTrain.new('ГРЗ-02')
  Train.find('ПАС-01').attach(PassengerWagon.new(20))
  Train.find('ПАС-01').attach(PassengerWagon.new(25))
  Train.find('ПАС-02').attach(PassengerWagon.new(20))
  Train.find('ПАС-02').attach(PassengerWagon.new(25))
  Train.find('ПАС-03').attach(PassengerWagon.new(20))
  Train.find('ПАС-03').attach(PassengerWagon.new(30))
  Train.find('ПАС-03').attach(PassengerWagon.new(30))
  Train.find('ГРЗ-01').attach(CargoWagon.new(100))
  Train.find('ГРЗ-01').attach(CargoWagon.new(110))
  Train.find('ГРЗ-01').attach(CargoWagon.new(110))
  Train.find('ГРЗ-01').attach(CargoWagon.new(100))
  Train.find('ГРЗ-02').attach(CargoWagon.new(100))
  Train.find('ГРЗ-02').attach(CargoWagon.new(120))
  Train.find('ГРЗ-02').attach(CargoWagon.new(120))
  Train.find('ГРЗ-02').attach(CargoWagon.new(100))
  routes.append(Route.new(Station.find('Голутвин'), Station.find('Курская')))
  routes.last.add_station(Station.find('Луховицы'))
  routes.last.add_station(Station.find('Кривандино'))
  routes.append(Route.new(Station.find('Кривандино'), Station.find('Павловский Посад')))
  routes.last.add_station(Station.find('Курская'))
  routes.last.add_station(Station.find('Кусково'))
  routes.last.add_station(Station.find('Реутово'))
  routes.last.add_station(Station.find('Фрязево'))
  routes.append(Route.new(Station.find('Голутвин'), Station.find('Серпухов')))
  routes.last.add_station(Station.find('Кривандино'))
  routes.last.add_station(Station.find('Кусково'))
  routes.last.add_station(Station.find('Фрязево'))
  routes.last.add_station(Station.find('Люблино-Сортировочное'))
  routes.append(Route.new(Station.find('Голутвин'), Station.find('Серпухов')))
  routes.last.add_station(Station.find('Реутово'))
  routes.append(Route.new(Station.find('Кривандино'), Station.find('Люблино-Сортировочное')))
  Train.find('ПАС-01').route = routes[0]
  Train.find('ПАС-02').route = routes[1]
  Train.find('ПАС-03').route = routes[2]
  Train.find('ГРЗ-01').route = routes[3]
  Train.find('ГРЗ-02').route = routes[4]
  Train.find('ПАС-02').move_forward
  Train.find('ПАС-03').move_forward
  Train.find('ПАС-03').move_forward
  Train.find('ПАС-03').move_forward
  Train.find('ГРЗ-01').move_forward
  Train.find('ГРЗ-01').move_forward
  Train.find('ГРЗ-02').move_forward
  puts 'Тестовые данные созданы'
  puts 'Нажмите [Enter] для выхода...'
  gets
end

def enter_stations
  puts 'Введите станции:'
  loop do
    begin
      name = gets.chomp
      break if name.empty?   # Признак окончания ввода списка станций

      Station.new(name)
    rescue RuntimeError => e
      puts e.message
      retry
    end
  end
end

def enter_trains
  puts 'Введите пассажирские поезда в формате XXX-XX:'
  loop do
    begin
      name = gets.chomp
      break if name.empty?   # Признак окончания ввода списка поездов

      train = PassengerTrain.new(name)
      puts "Создан поезд #{train.name}"
    rescue RuntimeError => e
      puts e.message
      retry
    end
  end

  puts 'Введите грузовые поезда в формате XXX-XX:'
  loop do
    begin
      name = gets.chomp
      break if name.empty?   # Признак окончания ввода списка поездов

      train = CargoTrain.new(name)
      puts "Создан поезд #{train.name}"
    rescue RuntimeError => e
      puts e.message
      retry
    end
  end
end

def enter_route
  buffer = []
  puts 'Введите станции маршрута:'
  loop do
    name = gets.chomp
    break if name.empty? # Признак окончания ввода списка станций

    station = Station.find(name)
    if !station
      puts 'Станция не найдена'
    else
      buffer << station
    end
  end
  begin
    routes ||= []
    routes.append(Route.new(buffer.first, buffer.last))
    buffer[1..buffer.size - 2].each { |name| routes.last.add_station(name) }
  rescue RuntimeError => e
    puts e.message
    puts
    puts 'Нажмите [Enter] для выхода...'
    gets
  end
end

def assign_route
  train = nil
  puts 'Введите название поезда:'
  loop do
    name = gets.chomp
    break if name.empty?

    train = Train.find(name)
    break if train

    puts 'Поезд не найден'
  end
  if train
    puts 'Введите номер маршрута (начиная с единицы):'
    loop do
      routes ||= []
      route = gets.chomp.to_i
      break if route.empty?

      if routes[route - 1]
        train.route = routes[route - 1]
        break
      else
        puts 'Маршрут не найден'
      end
    end
  end
end

def attach_wagons
  train = nil
  puts 'Введите название поезда:'
  loop do
    name = gets.chomp
    break if name.empty?

    train = Train.find(name)
    break if train

    puts 'Поезд не найден'
  end
  if train
    puts 'Введите количество прицепляемых вагонов:'
    n = gets.to_i
    if train.class == CargoTrain
      puts 'Введите объём каждого вагона:'
      n.times { train.attach(CargoWagon.new(gets.to_i)) }
    elsif train.class == PassengerTrain
      puts 'Введите количество мест для каждого вагона:'
      n.times { train.attach(PassengerWagon.new(gets.to_i)) }
    end
  end
end

def detach_wagons
  train = nil
  puts 'Введите название поезда:'
  loop do
    name = gets.chomp
    break if name.empty?

    train = Train.find(name)
    break if train

    puts 'Поезд не найден'
  end
  if train
    puts 'Введите количество отцепляемых вагонов:'
    gets.chomp.to_i.times do
      if train.class == CargoTrain
        train.detach(train.wagons.last)
      elsif train.class == PassengerTrain
        train.detach(train.wagons.last)
      end
    end
  end
end

def move_train
  train = nil
  puts 'Введите название поезда:'
  loop do
    name = gets.chomp
    break if name.empty?

    train = Train.find(name)
    break if train

    puts 'Поезд не найден'
  end
  if train
    puts 'Маршрут:'
    train.route.stations.each { |station| puts station.name }
    puts 'Поезд на станции:'
    puts train.route.stations[train.cur_station_index].name
    puts 'Куда переместить? (\'<\', \'>\')'
    loop do
      direction = gets.chomp
      case direction
      when '>'
        train.move_forward
      when '<'
        train.move_backward
      when ''
        break
      end
      puts train.route.stations[train.cur_station_index].name
    end
  end
end

def list_stations_and_trains
  Station.all.each do |name, station|
    puts name.to_s
    station.each_train do |train|
      puts "    #{train.class} #{train.name} (#{train.wagons.size})"
      train.each_wagon do |i, wagon|
        puts "        #{wagon.class} #{i} (свободно #{wagon.free}, занято #{wagon.occupied})"
      end
    end
  end
  puts
  puts 'Нажмите [Enter] для выхода...'
  gets
end

def take_wagon
  train = nil
  puts 'Введите название поезда:'
  loop do
    name = gets.chomp
    break if name.empty?

    train = Train.find(name)
    break if train

    puts 'Поезд не найден'
  end
  if train
    wagon = nil
    puts "#{train.class} (#{train.wagons.size})"
    puts 'Введите номер вагона:'
    loop do
      number = gets.to_i
      wagon = train.wagons[number - 1]
      break if wagon

      puts 'Такого вагона нет'
    end
    case wagon.class.to_s
    when 'PassengerWagon'
      begin
        wagon.take
      rescue RuntimeError => e
        puts e.message
        puts 'Нажмите [Enter] для выхода...'
        gets
      end
    when 'CargoWagon'
      puts "Свободно #{wagon.free}"
      puts 'Введите загружаемый объём:'
      begin
        wagon.take(gets.to_i)
      rescue RuntimeError => e
        puts e.message
        retry
      end
    end
  end
end

def function
  function = gets.chomp
  system('clear')
  function
end

# Main loop
loop do
  print_menu

  case function
  when '0'
    create_test_data
  when '1'
    enter_stations
  when '2'
    enter_trains
  when '3'
    enter_route
  when '4'
    assign_route
  when '5'
    attach_wagons
  when '6'
    detach_wagons
  when '7'
    move_train
  when '8'
    list_stations_and_trains
  when '9'
    take_wagon
  when '00'
    break
  end
end
