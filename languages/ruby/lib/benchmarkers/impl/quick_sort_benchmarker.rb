# Implements QuickSort benchmarking logic
require 'json'

require_relative '../benchmarker'
require_relative '../../operations/quick_sort'

class QuickSortBenchmarker < Benchmarker
  def initialize()
    super("QuickSort")
  end

  def consume_file_input(input_file_path)
    json_raw = File.read(input_file_path)
    @unsorted_list = JSON.parse(json_raw)
  end

  def get_operation_execution_time()
    arr_copy = @unsorted_list.map(&:clone)
    super() { QuickSortOperation.quick_sort(arr_copy) }
  end
end