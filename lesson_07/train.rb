require_relative "manufacturer"
require_relative "instance_counter"

class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :name
  attr_reader :wagons
  attr_accessor :speed  # Набор скорости: speed = number
  attr_reader :route
  attr_reader :cur_station_index
  @@trains = {}

  def initialize(name)
    @name = name
    @wagons = []
    @speed = 0
    @@trains[name] = self
    register_instance
  end

  # Остановка
  def stop
    @speed = 0
  end

  # Прицепка вагона
  def attach(wagon)
    @wagons << wagon if @speed == 0
  end

  # Отцепка вагона
  def detach(wagon)
    @wagons.delete(wagon) if @speed == 0
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
    @route.stations[@cur_station_index-2..@cur_station_index]
  end

  # Объект поезда по его номеру
  def self.find(name)
    @@trains[name]
  end
end
