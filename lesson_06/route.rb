class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
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
