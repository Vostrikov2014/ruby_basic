%w[instance_counter validation].each { |f| require_relative f }

class Station
  include InstanceCounter

  # lesson_10
  extend Validation::ClassMethods
  include Validation::InstanceMethods

  attr_reader :name, :trains

  # lesson_10
  validate :name, :presence

  @@instances = []

  def self.all
    @@instances
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@instances << self
    register_instance
  end

  def each_train
    @trains.each { |train| yield train }
  end

  def add_train(train)
    @trains << train
  end

  def del_train(train)
    @trains.delete(train)
  end

  def train_at_station(type)
    raise 'Поездов нет' unless @trains.any?

    @trains.select { |t| t.type == type }
  end

=begin lesson_10
  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise 'Введите имя' if @name.nil?
    raise 'Минимальная длина имени 2 символа' if @name.length < 2
    end
=end

end
