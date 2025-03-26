/**
 * Contains QuickSort benchmarker.
 */

use std::fs::File;
use std::io::BufReader;
use std::time::Instant;

use crate::benchmarkers::base_benchmarker::{BaseBenchmarker, OperationResult};
use crate::errors::BenchmarkerError;
use crate::errors::BenchmarkerError::VerificationFailure;
use crate::operations::quick_sort::quick_sort;

pub struct QuickSortBenchmarker {
    operation_name: String,
    unsorted_list: Vec<String>,
    valid_sorted_list: Vec<String>,
}

impl QuickSortBenchmarker {
    pub fn new(input_file_path: &str) -> Self {
        let input_file = File::open(input_file_path).unwrap();
        let reader = BufReader::new(input_file);

        // Deserializes the JSON into a Vec<String>
        let unsorted_list: Vec<String> = serde_json::from_reader(reader).unwrap();

        // Sorts the list with built-in sorting function to use to validate results of QuickSort
        let mut valid_sorted_list = unsorted_list.clone();
        valid_sorted_list.sort();
        
        Self {
            operation_name: "QuickSort".to_string(),
            unsorted_list,
            valid_sorted_list
        }
    }
}

impl BaseBenchmarker<Vec<String>> for QuickSortBenchmarker {
    fn get_operation_name(&self) -> &str {
        self.operation_name.as_str()
    }

    fn get_operation_results(&self) -> OperationResult<Vec<String>> {
        let mut unsorted_list_copy = self.unsorted_list.to_owned();
        let quick_sort_input = unsorted_list_copy.as_mut_slice();

        let start_time = Instant::now();
        let sorted_list = quick_sort(quick_sort_input);
        let execution_time = start_time.elapsed();
        
        OperationResult::new(sorted_list.to_vec(), execution_time)
    }

    fn verify_operation_output(&self, output: Vec<String>) -> Result<(), BenchmarkerError> {
        if !output.eq(self.valid_sorted_list.as_slice()) {
            return Err(VerificationFailure("QuickSort results are not properly sorted.".to_string()));
        }
        Ok(())
    }
} 