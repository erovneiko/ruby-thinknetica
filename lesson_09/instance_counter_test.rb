require_relative 'instance_counter'

class Test1
  include InstanceCounter
  def initialize
    register_instance
  end
end

class Test2 < Test1
end

Test1.new
Test1.new
Test2.new

puts Test1.instances
puts Test2.instances
