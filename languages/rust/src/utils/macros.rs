/**
 * Contains application macros.
 */

/// Wraps expression with time measuring logic that determines that execution time
/// of the operation being wrapped by this macro.
#[macro_export]
macro_rules! benchmark_operation {
    ($operation_execution: expr) => {
        {
            let start_time = Instant::now();
            $operation_execution;
            start_time.elapsed()
        }
    };
}
