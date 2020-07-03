require_relative "route"
require_relative "station"
require_relative "train_passenger"
require_relative "train_cargo"
require_relative "wagon_passenger"
require_relative "wagon_cargo"

stations = []
trains = []
routes = []

loop do
  system("clear")
  puts "\
1. Создать станции
2. Создать поезда
3. Создать маршрут
4. Назначить маршрут
5. Прицепить вагоны
6. Отцепить вагоны
7. Переместить поезд
8. Список станций и поездов
0. Выход"
  print"> "

  answer = gets.chomp
  system("clear")

  case answer
    when "1"
      puts "Введите станции:"
      loop do
        name = gets.chomp
        break if name == ""
        if stations.select { |station| station.name == name }.any?
          puts "ОШИБКА: такая станция уже существует"
        else
          stations.append(Station.new(name))
        end
      end

    when "2"
      puts "Введите пассажирские поезда:"
      loop do
        name = gets.chomp
        break if name == ""
        if trains.select { |train| train.name == name }.any?
          puts "ОШИБКА: такой поезд уже существует"
        else
          trains.append(PassengerTrain.new(name))
        end
      end

      puts "Введите грузовые поезда:"
      loop do
        name = gets.chomp
        break if name == ""
        if trains.select { |train| train.name == name }.any?
          puts "ОШИБКА: такой поезд уже существует"
        else
          trains.append(CargoTrain.new(name))
        end
      end

    when "3"
      buffer = []
      puts "Введите станции маршрута:"
      loop do
        name = gets.chomp
        break if name == ""
        station = stations.select { |station| station.name == name }.first
        if !station
          puts "ОШИБКА: Станция не найдена в общем списке"
        else
          buffer << station
        end
      end
      if buffer.size < 2
        puts "ОШИБКА: В маршруте меньше двух станций"
        gets
      else
        routes.append(Route.new(buffer.first, buffer.last))
        if buffer.size > 2
          buffer[1..buffer.size - 2].each { |name| routes.last.add_station(name) }
        end
      end

    when "4"
      train = nil
      puts "Введите название поезда:"
      loop do
        name = gets.chomp
        break if name == ""
        train = trains.select { |train| train.name == name }.first
        break if train
        puts "ОШИБКА: поезд не найден в общем списке"
      end
      if train
        puts "Введите номер маршрута (начиная с единицы):"
        loop do
          route = gets.chomp.to_i
          break if route == 0
          if routes[route - 1]
            train.route = routes[route - 1]
            break
          else
            puts "ОШИБКА: маршрут не найден"
          end
        end
      end

    when "5"
      train = nil
      puts "Введите название поезда:"
      loop do
        name = gets.chomp
        break if name == ""
        train = trains.select { |train| train.name == name }.first
        break if train
        puts "ОШИБКА: поезд не найден в общем списке"
      end
      if train
        puts "Введите количество прицепляемых вагонов:"
        gets.chomp.to_i.times do
          if train.class == CargoTrain
            train.attach(CargoWagon.new)
          elsif train.class == PassengerTrain
            train.attach(PassengerWagon.new)
          end
        end
      end

    when "6"
      train = nil
      puts "Введите название поезда:"
      loop do
        name = gets.chomp
        break if name == ""
        train = trains.select { |train| train.name == name }.first
        break if train
        puts "ОШИБКА: поезд не найден в общем списке"
      end
      if train
        puts "Введите количество отцепляемых вагонов:"
        gets.chomp.to_i.times do
          if train.class == CargoTrain
            train.detach(train.wagons.last)
          elsif train.class == PassengerTrain
            train.detach(train.wagons.last)
          end
        end
      end

    when "7"
      train = nil
      puts "Введите название поезда:"
      loop do
        name = gets.chomp
        break if name == ""
        train = trains.select { |train| train.name == name }.first
        break if train
        puts "ОШИБКА: поезд не найден в общем списке"
      end
      if train
        puts "Маршрут:"
        train.route.stations.each { |station| puts station.name }
        puts "Поезд на станции:"
        puts train.route.stations[train.cur_station_index].name
        puts "Куда переместить? (""<"", "">"")"
        loop do
          direction = gets.chomp
          case direction
            when ">"
              train.move_forward
            when "<"
              train.move_backward
            when ""
              break
          end
          puts train.route.stations[train.cur_station_index].name
        end
      end

    when "8"
      stations.each do |station|
        print station.name
        station.trains.each do |train|
          print " [#{train.name}]"
        end
        puts
      end
      gets

    when "0"
      break
  end
end
