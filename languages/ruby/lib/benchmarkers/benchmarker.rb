# Implements base benchmarking logic

class Benchmarker
  NANO_PER_MILLI = 1_000_000

  def initialize(operation_name)
    @operation_name = operation_name
  end

  def consume_file_input(input_file_path)
    raise NotImplementedError("Expected to be implemented by child class!")
  end
  
  def get_operation_execution_time()
    start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC, :nanosecond)
    yield
    end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC, :nanosecond)

    end_time - start_time
  end

  def get_operation_execution_results(execution_count, &operation_execution_block)
    [*0..execution_count-1].map { get_operation_execution_time }
  end

  def print_benchmark_analysis(execution_count)
    results = get_operation_execution_results(execution_count)
    total_time = results.sum

    milliseconds = total_time.to_f / NANO_PER_MILLI
    formatted_time = sprintf("%.6f", milliseconds)

    puts "Ruby's #{@operation_name} execution time (over #{execution_count} loops): #{formatted_time} ms"
  end
end