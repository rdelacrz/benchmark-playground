#include <argp.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include "quick_sort_benchmarker.h"

#define EXECUTION_COUNT 1000

// Structure to hold command-line arguments
struct arguments {
    char *operation;
    char *input_file;
    int count;
};

// List of operations
const char *operations[] = {
    "QuickSort",
    NULL // NULL-terminated list
};

// Function to check if the operation is valid
bool is_valid_operation(const char *op) {
    for (const char **ptr = operations; *ptr != NULL; ptr++) {
        if (strcmp(op, *ptr) == 0) {
            return true;
        }
    }
    return false;
}

// Argp parser function
error_t parse_opt(int key, char *arg, struct argp_state *state) {
    struct arguments *args = state->input;

    switch (key) {
        case 'o':
            if (is_valid_operation(arg)) {
                args->operation = arg;
            } else {
                fprintf(stderr, "Invalid operation: %s\n", arg);
                argp_usage(state);
            }
            break;
        case 'i':
            args->input_file = arg;
            break;
        case 'c':
            args->count = atoi(arg);
            break;
        case ARGP_KEY_END:
            if (args->operation == NULL) {
                fprintf(stderr, "Operation is required.\n");
                return ARGP_ERR_UNKNOWN;
            }
            break;
        default:
            return ARGP_ERR_UNKNOWN;
    }
    return 0;
}

// Argp options
static struct argp_option options[] = {
    {"operation", 'o', "OPERATION", 0, "The operation to be benchmarked."},
    {"inputfile", 'i', "FILE", 0, "The path to a file containing the input data."},
    {"count", 'c', "COUNT", 0, "The number of times an operation will be executed."},
    { 0 } // End of options
};

// Argp parser
static struct argp argp = {options, parse_opt, NULL, "Benchmarker: Benchmarks operations by executing them a set number of times."};

/**
 * Sets up the benchmarking environment based on the given operation name.
 */
void setup_benchmarker(Benchmarker *benchmarker, BenchmarkerContext *context, char* operation_name, char* input_file, int count) {
    if (strcmp(operation_name, "QuickSort") == 0) {
        QuickSortBenchmarkerContextData data = {};
        QuickSortBenchmarker_initializeBenchmarker(benchmarker);
        QuickSortBenchmarker_initializeContextData(&data, input_file);
        QuickSortBenchmarker_initializeContext(context, benchmarker, &data, count);
    }
}

int main(int argc, char *argv[]) {
    struct arguments args;

    // Set default values
    args.operation = NULL;
    args.input_file = NULL;
    args.count = EXECUTION_COUNT;

    // Parse command-line arguments
    argp_parse(&argp, argc, argv, 0, 0, &args);

    Benchmarker benchmarker = {};
    BenchmarkerContext context = {};

    setup_benchmarker(&benchmarker, &context, args.operation, args.input_file, args.count);
    execute_benchmarker(&context);
    clean_up_benchmarker(&context);

    return 0;
}