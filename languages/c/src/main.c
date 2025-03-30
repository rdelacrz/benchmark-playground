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
    bool verify;
};

// List of operations
const char *operations[] = {
    "quick_sort",
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
        case 'v':
            args->verify = true;
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
    {"input_file", 'i', "FILE", 0, "The path to a file containing the input data."},
    {"count", 'c', "COUNT", 0, "The number of times an operation will be executed."},
    {"verify", 'v', 0, 0, "Flag to verify the results of the benchmarked operation."},
    { 0 } // End of options
};

// Argp parser
static struct argp argp = {options, parse_opt, NULL, "Benchmarker: Benchmarks operations by executing them a set number of times."};

int main(int argc, char *argv[]) {
    struct arguments args;

    // Set default values
    args.operation = NULL;
    args.input_file = NULL;
    args.count = EXECUTION_COUNT;
    args.verify = false;

    // Parse command-line arguments
    argp_parse(&argp, argc, argv, 0, 0, &args);

    if (strcmp(args.operation, "quick_sort") == 0) {
        QuickSortBenchmarker benchmarker = {};
        QuickSortBenchmarker_init(&benchmarker, args.input_file);
        QuickSortBenchmarker_print_benchmark_analysis(&benchmarker, args.count, args.verify);
    }

    return 0;
}