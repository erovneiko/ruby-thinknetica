require_relative 'train'

class PassengerTrain < Train
  # Прицепка вагона
  def attach(wagon)
    super if wagon.class == PassengerWagon
  end

  # Отцепка вагона
  def detach(wagon)
    super if wagon.class == PassengerWagon
  end
end
