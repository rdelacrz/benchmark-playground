require_relative 'cli_parser'
require_relative 'benchmarkers/benchmarker_manager'

benchmarker_manager = BenchmarkerManager.new
options = parse_options(benchmarker_manager)

benchmarker = benchmarker_manager.benchmarker_map[options[:operation]]
benchmarker.consume_file_input(options[:inputfile])
benchmarker.print_benchmark_analysis(options[:count])
