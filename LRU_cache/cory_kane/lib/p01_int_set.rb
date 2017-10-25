class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) { false }
  end

  def insert(num)
    validate! num
    @store[num - 1] = true
  end

  def remove(num)
    validate! num
    @store[num - 1] = false
  end

  def include?(num)
    validate! num
    @store[num - 1]
  end

  private

  def is_valid?(num)
    num > 0 && num <= @max
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid? num
    end
  end



class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete_if do |el|
      el == num
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets
    unless include?(num)
      @count += 1
      self[num] << num
    end
  end

  def remove(num)
    @count -= 1 if include?(num)
    self[num].delete_if do |el|
      el == num
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    temp_store = @store
    @store = new_store

    temp_store.each do |sub_arr|
      sub_arr.each do |el|
        insert(el)
        @count -= 1
      end
    end
  end
end
