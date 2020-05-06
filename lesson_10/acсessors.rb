module Accessors

  def attr_accessor_with_history(*name)

    @history = {}

    name.each do |name|
      var_name = "@#{name}".to_sym

      # геттер
      define_method(name) { instance_variable_get(var_name)}

      # сеттер
      define_method("#{name}=".to_sym) do |value|

        # пишет историю
        @history[name] ||= []
        @history[name] << instance_variable_get(var_name)

        # устанавливает атрибут
        instance_variable_set(var_name, value)
      end
      # возврат всех значений
      define_method("#{name}_history".to_sym) { @history[name] }
    end
  end

  def strong_attr_accessor(name, attr_class)
    var_name = "@#{name}".to_sym

    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) do |value|
      raise 'Неправильныо указан класс' if !value.is_a?(attr_class)

      instance_variable_set(var_name, value)
    end
  end
end





class Test
  extend Accessors

  attr_accessor_with_history :my_attr, :a, :b, :c
end