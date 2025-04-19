# Manages all benchmarkers

require_relative 'impl/quick_sort_benchmarker'

class BenchmarkerManager
  attr_accessor :benchmarker_map, :valid_operations

  def initialize()
    benchmarker_list = [
      QuickSortBenchmarker.new
    ]

    @valid_operations = benchmarker_list
      .map { |benchmarker| benchmarker.operation_name }
      .sort
      .join(', ')
    @benchmarker_map = benchmarker_list
      .map { |benchmarker| [benchmarker.operation_name, benchmarker] }
      .to_h
  end
end