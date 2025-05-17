require "json"

require "./benchmarkers/benchmarker_manager"
require "./cli_parse"

benchmarker_manager = BenchmarkerManager.new
options = parse_options(benchmarker_manager)

benchmarker = benchmarker_manager.benchmarker_map[options.operation]
benchmarker.consume_file_input(options.input_file)
benchmarker.print_benchmark_analysis(options.count)
