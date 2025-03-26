/**
 * Contains base benchmarker trait that will be used by all operation benchmarkers.
 */
 
use std::time::Duration;

use crate::errors::BenchmarkerError;

pub struct OperationResult<O> {
    output: O,
    execution_time: Duration,
}

impl<O> OperationResult<O> {
    pub fn new(output: O, execution_time: Duration) -> Self {
        Self { output, execution_time }
    }
}

pub trait BaseBenchmarker<O> {
    fn get_operation_name(&self) -> &str;

    fn get_operation_results(&self) -> OperationResult<O>;

    fn verify_operation_output(&self, output: O) -> Result<(), BenchmarkerError>;

    fn print_benchmark_analysis(&self, execution_count: u32, verify: bool) -> Result<(), BenchmarkerError> {
        let mut total_elapsed = Duration::from_secs(0);

        for _ in 0..execution_count {
            let results = self.get_operation_results();
            total_elapsed += results.execution_time;
            if verify {
                self.verify_operation_output(results.output)?;
            }
        }

        // Prints statistics
        let operation_name = self.get_operation_name();
        println!("Rust's {:?} execution time (over {:?} loops): {:?}", operation_name, execution_count, total_elapsed);

        Ok(())
    }
}