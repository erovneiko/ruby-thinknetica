require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name
  class << self
    attr_reader :stations
  end
  @stations = {}

  def initialize(name)
    @name = name
    @trains = []
    register_instance
    validate!
    self.class.stations[name] = self
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

    @trains.map { |t| t.type == type }
  end

  def self.all
    @stations
  end

  def self.find(name)
    @stations[name]
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  private

  def validate!
    raise 'Не указано название станции' if name.empty?
    raise 'Такая станция уже существует' if self.class.stations[name]
  end
end
