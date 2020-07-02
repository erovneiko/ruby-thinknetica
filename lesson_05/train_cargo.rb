require_relative "train"

class CargoTrain < Train
  # Прицепка вагона
  def attach(wagon)
    super if wagon.class == CargoWagon
  end
  
  # Отцепка вагона
  def detach(wagon)
    super if wagon.class == CargoWagon
  end
end
