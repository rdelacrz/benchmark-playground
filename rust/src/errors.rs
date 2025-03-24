/**
 * Customs error used within the benchmarking system.
 */

use thiserror::Error;

#[derive(Error, Debug)]
pub enum BenchmarkerError {
    #[error("Benchmarking verification failed: {0}")]
    VerificationFailure(String)
}