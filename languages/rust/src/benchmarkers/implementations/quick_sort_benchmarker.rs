/**
 * Contains QuickSort benchmarker.
 */

use std::fs::File;
use std::io::BufReader;

use crate::benchmarkers::benchmarker::Benchmarker;
use crate::utils::errors::BenchmarkerError;
use crate::operations::quick_sort::quick_sort;

pub struct QuickSortBenchmarker {
    operation_name: String,
    unsorted_list: Vec<String>,
}

impl QuickSortBenchmarker {
    pub fn new() -> Self {
        Self {
            operation_name: "QuickSort".to_string(),
            unsorted_list: Vec::new(),
        }
    }
}

impl Benchmarker for QuickSortBenchmarker {
    fn consume_input_file(&mut self, input_file_path: &str) -> Result<(), BenchmarkerError> {
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

        // Deserializes the JSON into a Vec<String> and loads it
        let serde_results = serde_json::from_reader(reader);
        self.unsorted_list = match serde_results {
            Ok(unsorted_list) => unsorted_list,
            Err(e) => return Err(BenchmarkerError::InputFileParsingError(
                format!("An error occurred while attempting to deserialize the input file '{}': {}",
                input_file_path,
                e.to_string())
            )),
        };

        Ok(())
    }

    fn get_operation_name(&self) -> &str {
        self.operation_name.as_str()
    }

    fn generate_operation_performer(&self) -> Box<dyn FnMut()> {
        let mut unsorted_list_copy = self.unsorted_list.to_owned();
        Box::new(move || {
            quick_sort(unsorted_list_copy.as_mut_slice()); ()
        })
    }
} 