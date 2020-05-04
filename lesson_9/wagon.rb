require_relative 'manufacturer'

class Wagon
  include Manufacturer

  attr_accessor :number

  def initialize(number)
    @number = number
  end
end
