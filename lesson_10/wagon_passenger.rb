require_relative 'wagon'

class PassengerWagon < Wagon
  def take
    super(1)
  end
end
