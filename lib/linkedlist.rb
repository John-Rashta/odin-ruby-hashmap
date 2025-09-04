require_relative "node"
# LinkedList class
class LinkedList
  attr_reader :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(key, value)
    new_node = Node.new(key, value)
    unless @head
      apply_all(new_node)
      return
    end
    @tail.next_node = new_node
    @tail = new_node
    @size += 1
  end

  def delete(key)
    return unless @head

    if @head.key == key && @head == @tail
      apply_all(nil, -1)
      return
    elsif @head.key == key
      @head = @head.next_node
      @size -= 1
      return
    end
    current_node, after_node = remove_iterator(@head, key)

    return if after_node.nil?

    if @tail == after_node
      current_node.next_node = nil
      @tail = current_node
    else
      current_node.next_node = after_node.next_node
    end
    @size -= 1
    nil
  end

  def contains?(key)
    current_node = @head
    until current_node.nil?
      return true if current_node.key == key

      current_node = current_node.next_node
    end
    false
  end

  def find_and_update(key, value)
    current_node = @head
    until current_node.nil?
      if current_node.key == key
        current_node.value = value
        return current_node
      end
      current_node = current_node.next_node
    end
    nil
  end

  def find(key)
    current_node = @head
    until current_node.nil?
      return current_node.value if current_node.key == key

      current_node = current_node.next_node
    end
    nil
  end

  def get_all(action)
    return unless %w[key value both].include?("action")

    temp_arr = []
    current_node = @head
    until current_node.nil?
      case action
      when "key"
        temp_arr.push(current_node.key)
      when "value"
        temp_arr.push(current_node.value)
      else
        temp_arr.push([current_node.key, current_node.value])
      end
      current_node = current_node.next_node
    end
    temp_arr
  end

  def clear_list
    apply_all(nil, -size)
    nil
  end

  private

  def remove_iterator(head, key)
    current_node = head
    after_node = head.next_node

    until after_node.nil?
      break if after_node.key == key

      current_node = after_node
      after_node = current_node.next_node
    end

    [current_node, after_node]
  end

  def apply_all(value, size_adjust)
    @head = value
    @tail = value
    @size += size_adjust
  end
end
