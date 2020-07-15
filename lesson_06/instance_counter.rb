module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def instances
      self.instance_variable_get(:@instances)
    end
  end

  module InstanceMethods
    private
      def register_instance
        instances = self.class.instance_variable_get(:@instances)
        instances = 0 unless instances
        self.class.instance_variable_set(:@instances, instances + 1)
      end
  end
end
