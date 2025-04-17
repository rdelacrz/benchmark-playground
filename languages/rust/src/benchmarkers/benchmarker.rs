/**
 * Contains base benchmarker trait that will be used by all operation benchmarkers.
 */
 
use std::{ops::Add, time::Duration};

use crate::utils::errors::BenchmarkerError;

pub trait Benchmarker {
    fn consume_input_file(&mut self, input_file_path: &str) -> Result<(), BenchmarkerError>;

    fn get_operation_name(&self) -> &str;

    fn get_operation_execution_time(&self) -> Duration;

    fn get_operation_execution_results(&self, execution_count: u32) -> Vec<Duration> {
        Vec::from_iter((0..execution_count).map(|_| self.get_operation_execution_time()))
    }

    fn print_benchmark_analysis(&self, execution_count: u32) -> Result<(), BenchmarkerError> {
        let execution_results = self.get_operation_execution_results(execution_count);
        let total_elapsed = execution_results.into_iter().fold(Duration::from_secs(0), |a, b| a.add(b));

        // Prints statistics
        let operation_name = self.get_operation_name();
        let milliseconds = total_elapsed.as_nanos() as f64 / 1_000_000 as f64;
        println!("Rust's {} execution time (over {:?} loops): {:.6} ms", operation_name, execution_count, milliseconds);

        Ok(())
    }
}
