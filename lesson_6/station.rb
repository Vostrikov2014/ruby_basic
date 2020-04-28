%w[instance_counter].each { |f| require_relative f }

class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@instances = 0

  def self.all
    @@instances
  end

  def initialize(name)
    @name = name
    @trains = []
    @@instances += 1
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def del_train(train)
    @trains.delete(train)
  end

  def train_at_station(type)
    @trains.select { |t| t.type == type }
  end
end
