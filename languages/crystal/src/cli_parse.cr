require "colorize"
require "option_parser"

require "./benchmarkers/benchmarker_manager"

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
  puts msg.colorize(:cyan)
  exit 1
end

class ParseOptions
  getter count
  getter operation
  getter input_file

  def initialize(@count : Int32, @operation : String, @input_file : String)
  end
end

def parse_options(benchmarker_manager : BenchmarkerManager)
  operation : String = ""
  input_file : Path | String = ""
  count = 1000

  parser = OptionParser.parse do |p|
    p.on("-o OPERATION", "--operation OPERATION", "The operation to be benchmarked.") do |o|
      operation = o
    end
    p.on("-i INPUTFILE", "--inputfile INPUTFILE", "The path to a file containing the input data.") do |i|
      input_file = i
    end
    p.on("-c COUNT", "--count COUNT", "The number of times an operation will be executed.") do |c|
      count = c.to_i
    end

    p.on("-h", "--help", "Show help") do
      puts p
      exit
    end
  end

  # Validates CLI options
  help "No operation was passed! Operation must be one of the following: #{benchmarker_manager.valid_operations}" if operation.blank?
  if !benchmarker_manager.benchmarker_map.has_key?(operation)
    help "Operation name '#{operation}' not valid. Operation must be one of the following: #{benchmarker_manager.valid_operations}"
  end

  help "No inputfile was passed!" if input_file.blank?
  help "Given input file '#{input_file}' does not exist!" unless File.exists?(input_file)

  help "Given count '#{count}' is not a valid integer greater than 0!" if count <= 0

  ParseOptions.new(count, operation, input_file)
end