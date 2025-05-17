# Manages all benchmarkers

require "./benchmarker"
require "./impl/quick_sort_benchmarker"

class BenchmarkerManager
  getter benchmarker_map : Hash(String, Benchmarker)
  getter valid_operations : String

  def initialize()
    benchmarker_list : Array(Benchmarker) = [
      QuickSortBenchmarker.new.as(Benchmarker)
    ]

    @valid_operations = benchmarker_list
      .map { |benchmarker| benchmarker.operation_name }
      .sort
      .join(", ")
    @benchmarker_map = benchmarker_list
      .map { |benchmarker| {benchmarker.operation_name.to_s, benchmarker} }
      .to_h
  end
end