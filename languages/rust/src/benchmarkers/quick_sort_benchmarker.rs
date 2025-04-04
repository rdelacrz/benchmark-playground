/**
 * Contains QuickSort benchmarker.
 */

use std::fs::File;
use std::io::BufReader;
use std::time::{Duration, Instant};

use crate::benchmarkers::base_benchmarker::BaseBenchmarker;
use crate::errors::BenchmarkerError;
use crate::operations::quick_sort::quick_sort;

pub struct QuickSortBenchmarker {
    operation_name: String,
    unsorted_list: Vec<String>,
}

impl QuickSortBenchmarker {
    pub fn new(input_file_path: &str) -> Result<Self, BenchmarkerError> {
        let file_open_result = File::open(input_file_path);

        let input_file = match file_open_result {
            Ok(file) => file,
            Err(e) => return Err(BenchmarkerError::InputFileLoadError(
                format!("An error occurred while attempting to open the input file '{}': {}", 
                input_file_path,
                e.to_string())
            )),
        };

        let reader: BufReader<File> = BufReader::new(input_file);

        // Deserializes the JSON into a Vec<String>
        let serde_results = serde_json::from_reader(reader);
        let unsorted_list = match serde_results {
            Ok(unsorted_list) => unsorted_list,
            Err(e) => return Err(BenchmarkerError::InputFileParsingError(
                format!("An error occurred while attempting to deserialize the input file '{}': {}",
                input_file_path,
                e.to_string())
            )),
        };

        let benchmarker = Self {
            operation_name: "QuickSort".to_string(),
            unsorted_list,
        };
        
        Ok(benchmarker)
    }
}

impl BaseBenchmarker<Vec<String>> for QuickSortBenchmarker {
    fn get_operation_name(&self) -> &str {
        self.operation_name.as_str()
    }

    fn get_operation_execution_time(&self) -> Duration {
        let mut unsorted_list_copy = self.unsorted_list.to_owned();
        let quick_sort_input = unsorted_list_copy.as_mut_slice();

        let start_time = Instant::now();
        quick_sort(quick_sort_input);
        start_time.elapsed()
    }
} 