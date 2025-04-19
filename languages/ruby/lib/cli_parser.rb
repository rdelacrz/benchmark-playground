require 'colorator'
require 'optparse'

def help(msg = nil)
  printf "Error: #{msg}\n\n".red unless msg.nil?
  msg = <<~END_HELP
    Benchmarks a given operation using the input defined within an input file based on the given count of executions.

    Syntax: -o OPERATION -i INPUTFILE -c COUNT

    Options:
      -o The operation to be benchmarked
      -i The path to a file containing the input data.
      -c The number of times an operation will be executed (default: 1000).
      -h Show this help message
  END_HELP
  printf msg.cyan
  exit 1
end

def parse_options(benchmarker_manager)
  options = { count: 1000 }
  OptionParser.new do |parser|
    parser.on('-o', '--operation OPERATION', 'The operation to be benchmarked.')
    parser.on('-i', '--inputfile INPUTFILE', 'The path to a file containing the input data.')
    parser.on('-c', '--count COUNT', Integer, 'The number of times an operation will be executed.')

    parser.on_tail('-h', '--help', 'Show this message') do
      help
    end
  end.order!(into: options)

  # Validates CLI options
  operation = options[:operation]
  help "No operation was passed! Operation must be one of the following: #{benchmarker_manager.valid_operations}" if operation.nil?
  if benchmarker_manager.benchmarker_map[operation].nil? then
    help "Operation name '#{operation}' not valid. Operation must be one of the following: #{benchmarker_manager.valid_operations}"
  end

  input_file = options[:inputfile]
  help 'No inputfile was passed!' if input_file.nil?
  help "Given input file '#{input_file}' does not exist!" if !File.exist? input_file

  help "Given count '#{options[:count]}' is not a valid integer greater than 0!" if options[:count] <= 0

  options
end