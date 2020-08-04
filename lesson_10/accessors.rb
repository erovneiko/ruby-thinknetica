module Accessors
  def attr_accessor_with_history(*args)
    args.each do |name|
      var_name = "@#{name}".to_sym
      var_hist = "@#{name}_history".to_sym
      
      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |new_value|
        history = instance_variable_get(var_hist)
        history ||= []
        history << instance_variable_get(var_name)
        instance_variable_set(var_hist, history)
        instance_variable_set(var_name, new_value)
      end

      define_method("#{name}_history") { instance_variable_get(var_hist) }
    end
  end

  def strong_attr_accessor(name, class_type)
    var_name = "@#{name}".to_sym
    var_class = "@#{name}_class".to_sym
    instance_variable_set(var_class, class_type)
  
    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) do |new_value|
      raise 'Wrong type!' if new_value.class != self.class.instance_variable_get(var_class)
      instance_variable_set(var_name, new_value)
    end
  end
end

class Test
  extend Accessors

  attr_accessor_with_history :a, :b, :c, :d
  strong_attr_accessor :e, String
end
