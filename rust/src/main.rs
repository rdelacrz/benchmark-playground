mod quick_sort;

use std::fs::File;
use std::io::BufReader;
use std::time::{Duration, Instant};

use crate::quick_sort::quick_sort;

const LOOP_COUNT: i32 = 1000;

fn looped_operation() -> Result<Duration, Box<dyn std::error::Error>> {
    // Open the file
    let file = File::open("../random.json")?;
    let reader = BufReader::new(file);

    // Deserialize the JSON into a Vec<String>
    let mut strings: Vec<String> = serde_json::from_reader(reader)?;

    // Sort the strings, measuring the execution time
    let now = Instant::now();
    quick_sort(&mut strings);
    let elapsed = now.elapsed();

    Ok(elapsed)
}

// cargo build --release
// ./target/release/rust
fn main() -> Result<(), Box<dyn std::error::Error>> {
    let mut total_elapsed = Duration::from_secs(0);

    for _ in 0..LOOP_COUNT {
        total_elapsed += looped_operation()?;
    }

    // Prints statistics
    println!("Rust's QuickSort execution time (over {:?} loops): {:?}", LOOP_COUNT, total_elapsed);

    Ok(())
}
