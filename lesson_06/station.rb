require_relative "instance_counter"

class Station
  include InstanceCounter

  attr_reader :name
  attr_reader :trains
  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations.append(self)
    register_instance
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
    return @trains unless type
    @trains.each { |t| t.type == type }    
  end

  def self.all
    @@stations
  end
end
