require "colorize"
require "option_parser"

def help(msg = nil)
  puts "Error: #{msg}" if msg
  msg = <<-END_HELP
    Benchmarks a given operation using the input defined within an input file based on the given count of executions.

    Syntax: -o OPERATION -i INPUTFILE -c COUNT

    Options:
      -o The operation to be benchmarked
      -i The path to a file containing the input data.
      -c The number of times an operation will be executed (default: 1000).
      -h Show this help message
  END_HELP
  puts msg.cyan
  exit 1
end

def parse_options(benchmarker_manager)
  options = { count: 1000 }
  parser = OptionParser.new do |p|
    p.on("-o", "--operation OPERATION", "The operation to be benchmarked.") do |operation|
      options[:operation] = operation
    end
    p.on("-i", "--inputfile INPUTFILE", "The path to a file containing the input data.") do |inputfile|
      options[:inputfile] = inputfile
    end
    p.on("-c", "--count COUNT", "The number of times an operation will be executed.") do |count|
      options[:count] = count.to_i
    end

    p.on_tail("-h", "--help", "Show this message") do
      help
    end
  end

  parser.parse(ARGV)

  # Validates CLI options
  operation = options[:operation]
  help "No operation was passed! Operation must be one of the following: #{benchmarker_manager.valid_operations}" if operation.nil?
  if benchmarker_manager.benchmarker_map[operation].nil?
    help "Operation name '#{operation}' not valid. Operation must be one of the following: #{benchmarker_manager.valid_operations}"
  end

  input_file = options[:inputfile]
  help "No inputfile was passed!" if input_file.nil?
  help "Given input file '#{input_file}' does not exist!" unless File.exists?(input_file)

  help "Given count '#{options[:count]}' is not a valid integer greater than 0!" if options[:count] <= 0

  options
end