class Station
  def initialize(name)
    @name = name
    @trains = []
  end

  # Прибытие
  def arrive(train)
    @trains << train
  end

  # Отправление
  def dispatch(train)
    @trains.delete(train)
  end

  def trains(type = nil)
    if type
      @trains.each { |t| t.type == type }
    else
      @trains
    end
  end
end
