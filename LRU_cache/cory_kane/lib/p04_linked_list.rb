class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
  end
end

class LinkedList

  include Enumerable

  def initialize(node = nil)
    @head = Node.new
    @tail = Node.new
    if node
      @head.next = node
      node.next = @tail
      node.prev = @head
      @tail.prev = node
    else
      @head.next = @tail
      @tail.prev = @head
    end
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each { |node| return node.val if node.key == key }
    nil
  end

  def move_to_end(node)
    return if node == last
    prev_node = node.prev
    next_node = node.next
    second_to_last_node = last
    prev_node.next = next_node
    next_node.prev = prev_node

    node.next = @tail
    node.prev = second_to_last_node
    second_to_last_node.next = node
    @tail.prev = node
  end

  def include?(key)
    self.each {|node| return true if node.key == key}
    false
  end

  def append(key, val)
    old_last_node = @tail.prev
    last_node = Node.new(key, val)
    @tail.prev = last_node
    old_last_node.next = last_node
    last_node.prev = old_last_node
    last_node.next = @tail
  end

  def update(key, val)
  self.each do |node|
    node.val = val if node.key == key
  end

end

def remove(key)
  self.each do |node|
    if node.key == key
      next_node = node.next
      prev_node = node.prev
      prev_node.next = next_node
      next_node.prev = prev_node
    end
  end
end

def each(&prc)
  current_node = @head.next
  until current_node.next.nil?
    prc.call(current_node)
    current_node = current_node.next
  end
end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end
