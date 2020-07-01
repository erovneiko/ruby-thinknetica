class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
  end

  # Добавление станции
  def add(station)
    @stations.insert(-1, station)
  end

  # Удаление станции
  def delete(station)
    @stations.delete(station)
  end
end
