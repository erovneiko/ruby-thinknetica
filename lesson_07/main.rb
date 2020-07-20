require_relative "route"
require_relative "station"
require_relative "train_passenger"
require_relative "train_cargo"
require_relative "wagon_passenger"
require_relative "wagon_cargo"

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
        begin
          name = gets.chomp
          break if name.empty?   # Признак окончания ввода списка станций
          Station.new(name)
        rescue RuntimeError => ex
          puts ex.message
          retry
        end
      end

    when "2"
      puts "Введите пассажирские поезда:"
      loop do
        begin
          name = gets.chomp
          break if name.empty?   # Признак окончания ввода списка поездов
          train = PassengerTrain.new(name)
          puts "Создан поезд #{train.name}"
        rescue RuntimeError => ex
          puts ex.message
          retry
        end
      end

      puts "Введите грузовые поезда:"
      loop do
        begin
          name = gets.chomp
          break if name.empty?   # Признак окончания ввода списка поездов
          train = CargoTrain.new(name)
          puts "Создан поезд #{train.name}"
        rescue RuntimeError => ex
          puts ex.message
          retry
        end
      end

    when "3"
      buffer = []
      puts "Введите станции маршрута:"
      loop do
        name = gets.chomp
        break if name.empty?   # Признак окончания ввода списка станций
        station = Station.all.select { |station| station.name == name }.first
        if !station
          puts "ОШИБКА: Станция не найдена в общем списке"
        else
          buffer << station
        end
      end
      begin
        routes.append(Route.new(buffer.first, buffer.last))
        buffer[1..buffer.size - 2].each { |name| routes.last.add_station(name) }
      rescue RuntimeError => ex
        puts ex.message
        gets
      end

    when "4"
      train = nil
      puts "Введите название поезда:"
      loop do
        name = gets.chomp
        break if name.empty?
        train = Train.find(name)
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
        break if name.empty?
        train = Train.find(name)
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
        break if name.empty?
        train = Train.find(name)
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
        break if name.empty?
        train = Train.find(name)
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
      Station.all.each do |station|
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
