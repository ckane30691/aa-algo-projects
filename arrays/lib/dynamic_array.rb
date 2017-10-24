require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = Array.new(8)
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise Exception, 'index out of bounds' if @length == 0
    poppedEl = @store[@length]
    @length -= 1
    poppedEl
  end
  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @capacity == 0
      @capacity = 1
      @length = 1
      @store[0] = val
    elsif @length < @capacity
      @length += 1
      @store[@length] = val
    else
      resize!
      @length += 1
      @store[@length] = val
    end
    @store
  end

  # O(n): has to shift over all the elements.
  def shift
    raise Exception, 'index out of bounds' if @length == 0
    shiftedEl = @store[0]
    idx = 1
    until idx > @length
      @store[idx - 1] = @store[idx]
      idx += 1
    end
    @length -= 1
    shiftedEl
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @capacity == @length
    idx = @length
    until idx < 0
      @store[idx + 1] = @store[idx]
      idx -= 1
    end
    @store[0] = val
    @length += 1
    @store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise Exception, 'index out of bounds' if self.length < (index + 1)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_arr = StaticArray.new(@capacity * 2)
    @capacity = (@capacity * 2)
    count = 0
    idx = 0
    until count > @length
      count += 1
      idx += 1
      new_arr[idx] = @store[idx]
    end
    @store = new_arr
  end
end
