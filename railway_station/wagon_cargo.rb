class WagonCargo < Wagon
  attr_reader :wagon_type

  def initialize
    super
    @wagon_type = 'cargo'
  end
end
