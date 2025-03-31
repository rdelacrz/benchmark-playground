#include "quick_sort_benchmarker.h"

#define NANOS 1000000000LL

void QuickSortBenchmarker_initializeBenchmarker(Benchmarker* benchmarker) {
    benchmarker->execute = _QuickSortBenchmarker_execute;
    benchmarker->clean_up = _QuickSortBenchmarker_clean_up;
}

void QuickSortBenchmarker_initializeContextData(QuickSortBenchmarkerContextData *data, const char *input_file_path) {
    // Reads raw file data as a string
    char *json_data = reads_file_data(input_file_path);

    // Converts JSON data into string array, and sets converted data internally
    StringListData string_list_data = extract_str_list_from_json_str(json_data);

    data->unsorted_list = string_list_data.list;
    data->list_size = string_list_data.size;
}

void QuickSortBenchmarker_initializeContext(BenchmarkerContext* context, Benchmarker* benchmarker, QuickSortBenchmarkerContextData* data, int execution_count) {
    context->benchmarker = benchmarker;
    context->operation_name = "QuickSort";
    context->data = data;
    context->execution_count = execution_count;
}

void _QuickSortBenchmarker_execute(void *context) {
    BenchmarkerContext *quick_sort_context = (BenchmarkerContext *) context;

    double total_time = 0.0;
    for (int i = 0; i < quick_sort_context->execution_count; i++) {
        total_time += _QuickSortBenchmarker_get_operation_execution_time(quick_sort_context);
    }

    print_benchmark_analysis(quick_sort_context->operation_name, quick_sort_context->execution_count, total_time);
}

void _QuickSortBenchmarker_clean_up(void *context) {
    BenchmarkerContext *quick_sort_context = (BenchmarkerContext *) context;
    QuickSortBenchmarkerContextData *data = (QuickSortBenchmarkerContextData*) quick_sort_context->data;
    for (int i = 0; i < data->list_size; i++) {
        free(data->unsorted_list[i]);
    }
    free(data->unsorted_list);
}

long _QuickSortBenchmarker_get_operation_execution_time(BenchmarkerContext *context) {
    QuickSortBenchmarkerContextData *data = (QuickSortBenchmarkerContextData*) context->data;

    char **results = malloc(data->list_size * sizeof(char *));
    memcpy(results, data->unsorted_list, data->list_size * sizeof(char *));
    
    struct timespec start, end;

    clock_gettime(CLOCK_MONOTONIC_RAW, &start);
    quick_sort(results, data->list_size);
    clock_gettime(CLOCK_MONOTONIC_RAW, &end);

    // Frees results after performing quick_sort and determining its execution time
    free(results);

    return ((end.tv_sec * NANOS + end.tv_nsec) - (start.tv_sec * NANOS + start.tv_nsec));
}