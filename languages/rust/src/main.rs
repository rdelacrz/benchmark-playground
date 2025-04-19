mod benchmarkers;
mod operations;
mod utils;

use clap::Parser;

use crate::benchmarkers::get_benchmarker;
use crate::utils::errors::BenchmarkerError;

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
}

// cargo build --release
// ./target/release/rust -o QuickSort -i ../../inputs/random_string_list.json -c 1000 -v
fn main() -> Result<(), BenchmarkerError> {
    let args = Args::parse();

    let mut benchmarker = get_benchmarker(&args.operation)?;
    benchmarker.consume_input_file(&args.input_file)?;
    benchmarker.print_benchmark_analysis(args.count)?;

    Ok(())
}
