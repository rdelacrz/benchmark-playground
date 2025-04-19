require_relative 'cli_parser'
require_relative 'operations/quick_sort'
require_relative 'benchmarkers/impl/quick_sort_benchmarker'

require 'json'

options = parse_options

benchmarker = QuickSortBenchmarker.new()
benchmarker.consume_file_input(options[:inputfile])
benchmarker.print_benchmark_analysis(options[:count])
