require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    !self.get(key).nil?
  end

  def set(key, val)
    resize! if @count > num_buckets
    linked_list = @store[(key.hash % num_buckets)]
    if linked_list.include?(key)
      linked_list.update(key, val)
    else
      linked_list.append(key, val)
      @count += 1
    end
  end

  def get(key)
    linked_list = @store[(key.hash % num_buckets)]
    linked_list.get(key)
  end

  def delete(key)
    linked_list = bucket(key)
    if linked_list.include?(key)
      @count -= 1
      linked_list.remove(key)
    end
  end

  def each(&prc)
    @store.each do |linked_list|
      linked_list.each do |node|
        prc.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { LinkedList.new }
    temp_store = @store
    @store = new_store

    temp_store.each do |linked_list|
      linked_list.each do |node|
        set(node.key, node.val)
        @count -= 1
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[(key.hash % num_buckets)]
  end
end
