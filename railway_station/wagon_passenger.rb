class WagonPassenger < Wagon
  attr_reader :wagon_type

  def initialize
    super
    @wagon_type = 'passenger'
  end
end
