mod benchmarkers;
mod errors;
mod operations;

use crate::benchmarkers::base_benchmarker::BaseBenchmarker;
use crate::benchmarkers::quick_sort_benchmarker::QuickSortBenchmarker;
use crate::errors::BenchmarkerError;

const LOOP_COUNT: u32 = 1000;

// cargo build --release
// ./target/release/rust
fn main() -> Result<(), BenchmarkerError> {
    let quick_sort_benchmarker = QuickSortBenchmarker::new("../inputs/random.json");
    quick_sort_benchmarker.print_benchmark_analysis(LOOP_COUNT, true)
}
