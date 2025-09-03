# Node class that keeps track of value and next_node in line
class Node
  attr_accessor :value, :next_node, :key

  def initialize(key, val)
    @value = val
    @key = key
    @next_node = nil
  end
end
