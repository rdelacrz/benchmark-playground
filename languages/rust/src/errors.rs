/**
 * Customs error used within the benchmarking system.
 */

use thiserror::Error;

#[derive(Error, Debug)]
pub enum BenchmarkerError {
    #[error("Input file for benchmarker failed to load: {0}")]
    InputFileLoadError(String),

    #[error("Input file for benchmarker could not be parsed: {0}")]
    InputFileParsingError(String),
    
    #[error("'{0}' is not a valid operation name. It must be one of the following: {1}")]
    InvalidOperationName(String, String),
}
