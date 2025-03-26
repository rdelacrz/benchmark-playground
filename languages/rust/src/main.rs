mod benchmarkers;
mod errors;
mod operations;

use clap::Parser;

use crate::benchmarkers::base_benchmarker::BaseBenchmarker;
use crate::benchmarkers::quick_sort_benchmarker::QuickSortBenchmarker;
use crate::errors::BenchmarkerError;

#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
struct Args {
    #[arg(short, long)]
    operation: String,

    #[arg(short, long)]
    input_file: String,

    /// The count of operations to perform (default: 1000)
    #[arg(short, long, default_value_t = 1000)]
    count: u32,

    /// Whether to verify the operation (default: false)
    #[arg(short, long, default_value_t = false)]
    verify: bool,
}

// cargo build --release
// ./target/release/rust -o quick_sort -i ../../inputs/random.json -c 1000 -v
fn main() -> Result<(), BenchmarkerError> {
    let args = Args::parse();

    let benchmarker = match args.operation.as_str() {
        "quick_sort" => QuickSortBenchmarker::new(&args.input_file),
        _ => panic!("Invalid operation"),
    };

    benchmarker.print_benchmark_analysis(args.count, args.verify)
}
