module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, type, param = nil)
      if class_variable_defined?(:@@validations)
        validations = class_variable_get(:@@validations)
      else
        validations = []
      end
      validations << { name: name, type: type, param: param }
      class_variable_set(:@@validations, validations)
    end
  end

  module InstanceMethods
    def check_presence(name, param)
      attr_value = instance_variable_get("@#{name}".to_sym)
      raise "Пустое значение" \
        if attr_value.nil? || attr_value.to_s.empty?
    end

    def check_format(name, param)
      raise "Неправильный формат" \
        if instance_variable_get("@#{name}".to_sym) !~ param
    end

    def check_type(name, param)
      raise "Неправильный класс" \
        if instance_variable_get("@#{name}".to_sym).class != param
    end

    def validate!
      # puts self.class.class_variable_get(:@@validations).inspect
      return unless self.class.class_variable_defined?(:@@validations)
      self.class.class_variable_get(:@@validations).each do |value|
        send "check_#{value[:type]}", value[:name], value[:param]
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end    
  end  
end

# class Test
#   include Validation

#   validate :a, :type, String

#   def initialize
#     @a = "abc"
#     # @a = 1
#   end
# end

# t = Test.new
# t.validate!
