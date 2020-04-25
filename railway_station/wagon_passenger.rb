class WagonPassenger < Wagon
  attr_reader :WAGON_TYPE

  def initialize
    super
    @WAGON_TYPE = 'passenger'
  end
end
