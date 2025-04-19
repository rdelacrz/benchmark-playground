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

def parse_options
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
  if !%w[QuickSort].include?(options[:operation])
    help "Operation name '#{options[:operation]}' is invalid. Operation must be one of the following: QuickSort"
  end

  help 'No inputfile was passed!' if options[:inputfile].nil?
  help "Given input file '#{options[:inputfile]}' does not exist!" if !File.exist? options[:inputfile]

  help "Given count '#{options[:count]}' is not a valid integer greater than 0!" if options[:count] <= 0

  options
end