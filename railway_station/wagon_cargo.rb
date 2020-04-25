class WagonCargo < Wagon
  attr_reader :WAGON_TYPE

  def initialize
    super
    @WAGON_TYPE = 'cargo'
  end
end
