module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstancesMethods
  end

  @@instances = 0

  module ClassMethods
    attr_reader :instances
    def register_instance
      @instances ||= 0
      @instances += 1
    end
  end

  module InstancesMethods
    protected
    def register_instance
      self.class.register_instance
    end
  end
end