module QuickSortOperation(T)
  def self.quick_sort(arr : Array(T)) : Array(T)
    quick_sort_inner(arr, 0, arr.size - 1)
  end

  private def self.partition(arr : Array(T), low : Int32, high : Int32) : Int32
    pivot = high
    i = low - 1

    (low..high).each do |j|
      if arr[j] < arr[pivot]
        i += 1
        arr[i], arr[j] = arr[j], arr[i]
      end
    end

    i += 1
    arr[i], arr[pivot] = arr[pivot], arr[i]

    i
  end

  private def self.quick_sort_inner(arr : Array(T), low : Int32, high : Int32) : Array(T)
    if low < high
      pivot_index = partition(arr, low, high)
      quick_sort_inner(arr, low, pivot_index - 1)
      quick_sort_inner(arr, pivot_index + 1, high)
    end

    arr
  end
end