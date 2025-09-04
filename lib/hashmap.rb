require_relative "linkedlist"
# hashMap class for storing data with string keys
class HashMap
  attr_reader :capacity

  def initialize
    @buckets = Array.new(16)
    @capacity = 16
    @load_factor = 0.75
    @current_entries = 0
  end

  def set(key, value)
    # for increasing capacity do it before finding the index of next one, dont return so the value is added as normal
    # to the updated hashmap
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    unless @buckets[index].instance_of?(LinkedList)
      @buckets[index] = LinkedList.new
      @buckets[index].append(key, value)
      @current_entries += 1
      rebalance
      return
    end

    unless @buckets[index].find_and_update(key, value)
      @buckets[index].append(key, value)
      @current_entries += 1
      rebalance
    end
    nil
  end

  def get(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length
    return nil unless @buckets[index].instance_of?(LinkedList)

    @buckets[index].find(key)
  end

  def has?(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length
    return false unless @buckets[index].instance_of?(LinkedList)

    @buckets[index].contains?(key)
  end

  def remove(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length
    return nil unless @buckets[index].instance_of?(LinkedList)

    @buckets[index].delete(key)
    @current_entries -= 1
  end

  def length
    @current_entries
  end

  def clear
    @buckets = Array.new(16)
    @capacity = 16
    @current_entries = 0
    nil
  end

  def keys
    iterate_with_action("key")
  end

  def values
    iterate_with_action("value")
  end

  def entries
    iterate_with_action("both")
  end

  private

  def rebalance
    return unless (@capacity * @load_factor) < @current_entries

    all_entries = entries
    reset_map(@capacity * 2)
    all_entries.each do |entry|
      set(entry[0], entry[1])
    end
    nil
  end

  def iterate_with_action(action)
    @buckets.map do |bucket|
      bucket.get_all(action) if bucket.instance_of?(LinkedList)
    end.flatten(1).compact
  end

  def reset_map(size = 16)
    @buckets = Array.new(size)
    @capacity = size
    @current_entries = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }
    hash_code % @capacity
  end
end
