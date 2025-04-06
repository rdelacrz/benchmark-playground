#include "benchmarker.h"

#define NANO_PER_MILLI 1000000L

// Prints execution time, converting nanoseconds into milliseconds up to 4 decimal places
void print_benchmark_analysis(char* operation_name, int execution_count, double time_in_nanoseconds) {
    printf("C's %s execution time (over %d loops): %.6f ms\n", 
        operation_name,
        execution_count,
        time_in_nanoseconds / NANO_PER_MILLI
    );
}

void execute_benchmarker(BenchmarkerContext *context) {
    if (context->benchmarker != NULL && context->benchmarker != NULL && context->benchmarker->execute != NULL) {
        context->benchmarker->execute(context);
    }
}

void clean_up_benchmarker(BenchmarkerContext *context) {
    if (context->benchmarker != NULL && context->benchmarker->clean_up != NULL) {
        context->benchmarker->clean_up(context);
    }
}