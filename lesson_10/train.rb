require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :name
  attr_reader :wagons
  attr_accessor :speed # Набор скорости: speed = number
  attr_reader :route
  attr_reader :cur_station_index
  @@trains = {}

  def initialize(name)
    @name = name
    @wagons = []
    @speed = 0
    register_instance
    validate!
    @@trains[name] = self
  end

  # Остановка
  def stop
    @speed = 0
  end

  # Прицепка вагона
  def attach(wagon)
    @wagons << wagon if @speed.empty?
  end

  # Отцепка вагона
  def detach(wagon)
    @wagons.delete(wagon) if @speed.empty?
  end

  # Назначение маршрута, прибытие на первую станцию
  def route=(route)
    @route = route
    @route.stations.first.arrive(self)
    @cur_station_index = 0
  end

  # Перемещение на следующую станцию
  def move_forward
    if @cur_station_index != @route.stations.size - 1
      @route.stations[@cur_station_index].dispatch(self)
      @cur_station_index += 1
      @route.stations[@cur_station_index].arrive(self)
    end
  end

  # Перемещение на предыдущую станцию
  def move_backward
    if @cur_station_index != 0
      @route.stations[@cur_station_index].dispatch(self)
      @cur_station_index -= 1
      @route.stations[@cur_station_index].arrive(self)
    end
  end

  # Возврат предыдущей, текущей и следующей станции
  def status
    @route.stations[@cur_station_index - 2..@cur_station_index]
  end

  # Объект поезда по его номеру
  def self.find(name)
    @@trains[name]
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def each_wagon
    @wagons.each.with_index(1) { |wagon, i| yield(i, wagon) }
  end

  private

  def validate!
    raise 'Не указан номер поезда' if name.empty?
    raise 'Недопустимый формат номера поезда' if name !~ /^[a-zа-я\d]{3}-?[a-zа-я\d]{2}$/i
    raise 'Такой поезд уже существует' if @@trains[name]
  end
end
