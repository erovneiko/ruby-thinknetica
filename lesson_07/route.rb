require_relative "instance_counter"

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
    register_instance
    validate!
  end

  # Добавление станции
  def add_station(station)
    @stations.insert(-2, station)
  end

  # Удаление станции
  def delete_station(station)
    @stations.delete(station)
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise "В маршруте не может быть меньше двух станций" if @stations.first == @stations.last
  end
end
