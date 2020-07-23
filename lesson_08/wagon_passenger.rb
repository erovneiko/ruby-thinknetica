require_relative "wagon"

class PassengerWagon < Wagon
  attr_reader :occupied

  def initialize(places)
    super()
    @places = places
    @occupied = 0
  end

  def take
    raise "Недостаточно свободного места" if free == 0
    @occupied += 1
  end

  def free
    @places - @occupied
  end
end
