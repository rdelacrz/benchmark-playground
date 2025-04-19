# Implements the QuickSort algorithm.

module QuickSortOperation
  def self.quick_sort(arr)
    self.quick_sort_inner(arr, 0, arr.length() - 1)
  end

  private_class_method def self.partition(arr, low, high)
    pivot = high
    i = low - 1
  
    for j in low..high
      if (arr[j] <=> arr[pivot]) < 0 then
        i += 1
        arr[i], arr[j] = arr[j], arr[i]
      end
    end
  
    i += 1
    arr[i], arr[pivot] = arr[pivot], arr[i]
  
    i
  end
  
  private_class_method def self.quick_sort_inner(arr, low, high)
    if low < high then
      pivot_index = partition(arr, low, high)
      quick_sort_inner(arr, low, pivot_index - 1)
      quick_sort_inner(arr, pivot_index + 1, high)
    end
    
    arr
  end
end