/**
 * Benchmarking here is for more advanced, Rust-exclusive benchmarking logic.
 */

use criterion::{BatchSize, criterion_group, criterion_main, Criterion};
use std::{fs::File, io::BufReader};

use rust_benchmark_runner::operations::quick_sort::quick_sort;

fn read_input() -> Vec<String> {
    let input_file = File::open("../../inputs/random_string_list.json").unwrap();
    let reader = BufReader::new(input_file);
    let unsorted_list: Vec<String> = serde_json::from_reader(reader).unwrap();
    return unsorted_list;
}

fn quick_sort_benchmark(c: &mut Criterion) {
    let data = read_input();

    c.bench_function("QuickSort", move |b| {
        // This will avoid timing the clone() call
        b.iter_batched(|| data.clone(), |mut data| {
            quick_sort(&mut data);
            true
        }, BatchSize::SmallInput)
    });
}

criterion_group!(benches, quick_sort_benchmark);
criterion_main!(benches);