pub mod benchmarker;
pub mod implementations;

use benchmarker::Benchmarker;
use implementations::quick_sort_benchmarker::QuickSortBenchmarker;

use crate::utils::errors::BenchmarkerError;

pub fn get_benchmarker(operation_name: &str) -> Result<Box<dyn Benchmarker>, BenchmarkerError> {
    let benchmarkers: Vec<Box<dyn Benchmarker>> = vec![
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
