class Train
  attr_accessor :speed  # Набор скорости: speed = number
  attr_reader :length   # Количество вагонов

  def initialize(name, type, length)
    @name = name
    @type = type
    @length = length
  end

  # Остановка
  def stop
    @speed = 0
  end

  # Прицепка вагона
  def attach
    @length += 1 if @speed == 0
  end

  # Отцепка вагона
  def detach
    @lenght -= 1 if @speed == 0
  end

  # Назначение маршрута, прибытие на первую станцию
  def route=(route)
    @route = route
    @route.stations.first.arrive(self)
    @route_index = 1
  end

  # Перемещение на следующую станцию
  def move_forward
    if @route_index != @route.stations.size
      @route.stations[@route_index - 1].dispatch(self)
      @route_index += 1
      @route.stations[@route_index - 1].arrive(self)
    end
  end

  # Перемещение на предыдущую станцию
  def move_backward
    if @route_index != 1
      @route.stations[@route_index - 1].dispatch(self)
      @route_index -= 1
      @route.stations[@route_index - 1].arrive(self)
    end
  end

  # Возврат предыдущей, текущей и следующей станции
  def status
    return [] \
      << @route.stations[@route_index - 2] \
      << @route.stations[@route_index - 1] \
      << @route.stations[@route_index - 0]
  end
end
