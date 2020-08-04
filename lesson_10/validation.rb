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
    def validate!
      # puts self.class.class_variable_get(:@@validations).inspect
      return unless self.class.class_variable_defined?(:@@validations)
      self.class.class_variable_get(:@@validations).each do |value|
        attr_name = "@#{value[:name]}".to_sym
        attr_value = instance_variable_get(attr_name)
        case value[:type]
        when :presence
          raise "Пустое значение" \
            if attr_value.nil? || attr_value.to_s.empty?
        when :format
          raise "Неправильный формат" \
            if attr_value !~ value[:param]
        when :type
          raise "Неправильный класс" \
            if attr_value.class != value[:param]
        end
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
