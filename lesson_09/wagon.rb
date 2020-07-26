require_relative 'manufacturer'

class Wagon
  include Manufacturer
  attr_reader :type
  attr_reader :occupied

  def initialize(volume)
    @volume = volume
    @occupied = 0
  end

  def take(volume = 1)
    raise 'Недостаточно свободного места' if volume > free

    @occupied += volume
  end

  def free
    @volume - @occupied
  end
end
