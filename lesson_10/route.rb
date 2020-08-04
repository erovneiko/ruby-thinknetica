require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations
  
  validate :stations, :type, Array

  def initialize(first, last)
    @stations = [first, last]
    register_instance
    validate!
    raise 'В маршруте не может быть меньше двух станций' \
      if @stations.first == @stations.last
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
