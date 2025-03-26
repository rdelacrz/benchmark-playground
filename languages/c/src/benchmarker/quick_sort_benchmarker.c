#include "quick_sort_benchmarker.h"

#define NANOS 1000000000LL
#define NANO_PER_MILLI 1000000L

void QuickSortBenchmarker_init(QuickSortBenchmarker *self, const char *input_file_path) {
    self->operation_name = "QuickSort";

    // Reads raw file data as a string
    char *json_data = reads_file_data(input_file_path);

    // Converts JSON data into string array, and sets converted data internally
    StringListData string_list_data = extract_str_list_from_json_str(json_data);
    self->unsorted_list = string_list_data.list;
    self->list_size = string_list_data.size;

    // Creates valid sorted list to compare other sorts to it
    self->valid_sorted_list = malloc(self->list_size * sizeof(char *));
    memcpy(self->valid_sorted_list, self->unsorted_list, self->list_size * sizeof(char *));
    qsort(self->valid_sorted_list, self->list_size, sizeof(char *), compare_strings);
}

void QuickSortBenchmarker_print_benchmark_analysis(QuickSortBenchmarker *self, int execution_count, bool verify) {
    double total_time = 0.0;
    for (int i = 0; i < execution_count; i++) {
        total_time += _QuickSortBenchmarker_get_operation_execution_time(self, verify);
    }
    printf("C's %s execution time (over %d loops): %.4f ms\n", self->operation_name, execution_count, total_time / NANO_PER_MILLI);
}

long _QuickSortBenchmarker_get_operation_execution_time(QuickSortBenchmarker *self, bool verify) {
    char **results = malloc(self->list_size * sizeof(char *));
    memcpy(results, self->unsorted_list, self->list_size * sizeof(char *));
    
    struct timespec start, end;

    clock_gettime(CLOCK_MONOTONIC_RAW, &start);
    quick_sort(results, self->list_size);
    clock_gettime(CLOCK_MONOTONIC_RAW, &end);

    if (verify) {
        _QuickSortBenchmarker_verify_operation_results(self, results);
    }

    return ((end.tv_sec * NANOS + end.tv_nsec) - (start.tv_sec * NANOS + start.tv_nsec));
}

void _QuickSortBenchmarker_verify_operation_results(QuickSortBenchmarker *self, char **results) {
    for (int i = 0; i < self->list_size; i++) {
        if (strcmp(results[i], self->valid_sorted_list[i]) != 0) {
            fprintf(stderr, "QuickSort results are not properly sorted: %s != %s\n", results[i], self->valid_sorted_list[i]);
            exit(EXIT_FAILURE);
        }
    }
}