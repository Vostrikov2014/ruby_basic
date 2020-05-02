class WagonCargo < Wagon
  attr_reader :wagon_type, :free_volume

  def initialize(number, all_volume)
    super(number)
    @wagon_type = 'cargo'
    @all_volume = all_volume
    @free_volume = all_volume
  end

  def take_volume(volume)
    raise 'All volume busy' if @free_volume < volume
    @free_volume -= volume
  end

  def busy_volume
    @all_volume - @free_volume
  end
end
