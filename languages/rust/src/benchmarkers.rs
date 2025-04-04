pub mod base_benchmarker;
pub mod quick_sort_benchmarker;
use base_benchmarker::BaseBenchmarker;
use quick_sort_benchmarker::QuickSortBenchmarker;

use crate::errors::BenchmarkerError;

pub fn get_benchmarker(operation_name: &str) -> Result<Box<dyn BaseBenchmarker>, BenchmarkerError> {
    let benchmarkers: Vec<Box<dyn BaseBenchmarker>> = vec![
        Box::new(QuickSortBenchmarker::new())
    ];
    
    let actual_operation_names = benchmarkers
        .iter()
        .map(|s| s.get_operation_name().to_string())
        .collect::<Vec<_>>()
        .join(", ");

    for benchmarker in benchmarkers {
        if benchmarker.get_operation_name().eq(operation_name) {
            return Ok(benchmarker);
        }
    }

    Err(BenchmarkerError::InvalidOperationName(operation_name.to_string(), actual_operation_names))
}
