# Implements QuickSort benchmarking logic
require "json"

require "../benchmarker"
require "../../operations/quick_sort"

class QuickSortBenchmarker < Benchmarker
  @unsorted_list : Array(String)

  def initialize()
    super("QuickSort")
    @unsorted_list = [] of String
  end

  def consume_file_input(input_file_path : String)
    file_content = File.read(input_file_path)
    json_content = JSON.parse(file_content)
    @unsorted_list = json_content.as_a.map(&.to_s)
  end

  def get_operation_execution_time()
    arr_copy = @unsorted_list.clone
    super() { QuickSortOperation.quick_sort(arr_copy) }
  end
end