class WagonCargo < Wagon
  attr_reader :type, :free_volume

  # lesson_10
  validate :name, :presence

  def initialize(number, all_volume)
    super(number)
    @type = 'cargo'
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
