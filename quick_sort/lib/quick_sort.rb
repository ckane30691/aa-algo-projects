class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2
    pivot = rand(0..array.length).floor
    right = []
    left = []
    array.each_with_index do |el, idx|
      if idx != pivot
        el <= array[pivot] ? left << el : right << el
      end
    end

    sort1(left) + [array[pivot]] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    pivot_idx = self.partition(array, start, length, &prc)
    sort2!(array, start, pivot_idx - start, &prc)
    sort2!(array, pivot_idx + 1, length - ((pivot_idx - start) + 1), &prc)
    array
  end

  def quick_select(k)
    return -1 if k > length
    left = 0
    right = length - 1
    loop do
      pivot = self.class.partition(self, left, right - left + 1)
      if pivot == k - 1
        return self[pivot]
      elsif pivot > k
        right = pivot - start + 1
      else
        left = pivot
      end
    end
  end

  def self.partition(array, start, length, &prc)
      return if length < 2
      prc ||= proc { |el1, el2| el1 <=> el2 }
      pivot = start
      partition_idx = start + 1
      ((start + 1)...(start + length)).each do |idx|
        if prc.call(array[idx], array[pivot]) < 1
          array[idx], array[partition_idx] = array[partition_idx], array[idx]
          partition_idx += 1
        end
      end
      array[pivot], array[partition_idx - 1] = array[partition_idx - 1], array[pivot]
      partition_idx - 1
  end
end

class Array
  def quick_select(k)
    return -1 if k > length
    left = 0
    right = length - 1
    loop do
      debugger
      pivot = QuickSort.partition(self, left, right - left + 1)
      if pivot == k - 1
        return self[pivot]
      elsif pivot > k
        right = pivot - start
      else
        left = pivot
      end
    end
  end
end



ans = [1,2,3,4,5].quick_select(2)
puts ans
