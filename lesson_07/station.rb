require_relative "instance_counter"

class Station
  include InstanceCounter

  attr_reader :name
  attr_reader :trains
  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    register_instance
    validate!
    @@stations.append(self)
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

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise "Не указано название станции" if name.empty?
    raise "Такая станция уже существует" if @@stations.select { |station| station.name == name }.any?
  end
end
