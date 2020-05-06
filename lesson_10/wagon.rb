%w[manufacturer validation].each { |f| require_relative f }

class Wagon
  include Manufacturer

  # lesson_10
  extend Validation::ClassMethods
  include Validation::InstanceMethods

  attr_accessor :number

  # lesson_10
  validate :name, :presence

  def initialize(number)
    @number = number
  end
end
