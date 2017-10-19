class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @prc = prc ||= Proc.new {|el1, el2| el1 <=> el2}
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[count-1] = @store[count-1], @store[0]
    extractedEl = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, &@prc)
    extractedEl
  end

  def peek
    @store.first
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, count - 1, &@prc)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    result = []
    [((2 * parent_index) + 1), ((2 * parent_index) + 2)].each {|child| result << child if child < len }
    result
  end

  def self.parent_index(child_index)
    raise Exception, "root has no parent" if child_index.zero?
    child_index.odd? ? (child_index - 1) / 2 : (child_index - 2) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new {|el1, el2| el1 <=> el2}
    left_ch_idx, right_ch_idx = self.child_indices(len, parent_idx)
    return array if right_ch_idx.nil? && left_ch_idx.nil?
    right_child = array[right_ch_idx] if right_ch_idx
    left_child = array[left_ch_idx] if left_ch_idx

    if right_child.nil? || prc.call(left_child, right_child) < 0
      swap_idx = left_ch_idx
    else
      swap_idx = right_ch_idx
    end

    if prc.call(array[parent_idx], array[swap_idx]) > 0
      array[parent_idx], array[swap_idx] = array[swap_idx], array[parent_idx]
      self.heapify_down(array, swap_idx, len, &prc)
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new {|el1, el2| el1 <=> el2}
    return array if child_idx.zero?
    child = array[child_idx]
    parent_idx = self.parent_index(child_idx)
    parent = array[parent_idx]

    if prc.call(child, parent) < 0
      array[parent_idx], array[child_idx] = child, parent
      self.heapify_up(array, parent_idx, len, &prc)
    end
    array
  end
end
