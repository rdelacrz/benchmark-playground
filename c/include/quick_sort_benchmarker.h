#ifndef QUICKSORT_BENCHMARKER_H
#define QUICKSORT_BENCHMARKER_H

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "cJSON.h"
#include "file_utils.h"
#include "quick_sort.h"
#include "string_utils.h"

typedef struct QuickSortBenchmarker {
    char *operation_name;
    char **unsorted_list;
    char **valid_sorted_list;
    int list_size;
} QuickSortBenchmarker;

void QuickSortBenchmarker_init(QuickSortBenchmarker *self, const char *input_file_path);
void QuickSortBenchmarker_print_benchmark_analysis(QuickSortBenchmarker *self, int execution_count, bool verify);

long _QuickSortBenchmarker_get_operation_execution_time(QuickSortBenchmarker *self, bool verify);
void _QuickSortBenchmarker_verify_operation_results(QuickSortBenchmarker *self, char **results);

#endif