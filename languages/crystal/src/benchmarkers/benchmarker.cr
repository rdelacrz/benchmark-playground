# Implements base benchmarking logic

class Benchmarker
  NANO_PER_MILLI = 1_000_000

  getter operation_name

  def initialize(@operation_name : String)
  end

  def consume_file_input(input_file_path : String)
    raise NotImplementedError.new("Expected to be implemented by child class!")
  end
  
  def get_operation_execution_time(&)
    start_time = Time.monotonic
    yield
    end_time = Time.monotonic

    (end_time - start_time).nanoseconds
  end

  def get_operation_execution_time()
    raise NotImplementedError.new("Expected to be implemented by child class!")
  end

  def get_operation_execution_results(execution_count : Int32)
    [*0..execution_count-1].map { get_operation_execution_time }
  end

  def print_benchmark_analysis(execution_count : Int32)
    results = get_operation_execution_results(execution_count)
    total_time = results.sum

    milliseconds = total_time.to_f / NANO_PER_MILLI
    formatted_time = sprintf("%.6f", milliseconds)

    puts "Crystal's #{@operation_name} execution time (over #{execution_count} loops): #{formatted_time} ms"
  end
end