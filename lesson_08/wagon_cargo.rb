require_relative "wagon"

class CargoWagon < Wagon
  attr_reader :occupied

  def initialize(volume)
    super()
    @volume = volume
    @occupied = 0
  end

  def take(volume)
    raise "Недостаточно свободного места" if volume > free
    @occupied += volume
  end

  def free
    @volume - @occupied
  end
end
