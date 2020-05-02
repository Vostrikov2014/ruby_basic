class WagonPassenger < Wagon
  attr_reader :wagon_type, :free_place

  def initialize(number, all_place)
    super(number)
    @wagon_type = 'passenger'
    @all_place = all_place
    @free_place = all_place
  end

  def take_place
    raise 'All place busy' if @free_place.zero?
    @free_place -= 1
  end

  def busy_place
    @all_place - @free_place
  end
end
