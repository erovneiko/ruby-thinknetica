require_relative "instance_counter"

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
    register_instance
  end

  # Добавление станции
  def add_station(station)
    @stations.insert(-2, station)
  end

  # Удаление станции
  def delete_station(station)
    @stations.delete(station)
  end
end
