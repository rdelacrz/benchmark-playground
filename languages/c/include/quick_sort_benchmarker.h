#ifndef QUICKSORT_BENCHMARKER_H
#define QUICKSORT_BENCHMARKER_H

#include <time.h>

#include "benchmarker.h"
#include "file_utils.h"
#include "quick_sort.h"

typedef struct QuickSortBenchmarkerContextData {
    char **unsorted_list;
    int list_size;
} QuickSortBenchmarkerContextData;

void QuickSortBenchmarker_initializeBenchmarker(Benchmarker* benchmarker);
void QuickSortBenchmarker_initializeContextData(QuickSortBenchmarkerContextData *data, const char *input_file_path);
void QuickSortBenchmarker_initializeContext(BenchmarkerContext* context, Benchmarker* benchmarker, QuickSortBenchmarkerContextData* data, int execution_count);

void _QuickSortBenchmarker_execute(void *context);
void _QuickSortBenchmarker_clean_up(void *context);
long _QuickSortBenchmarker_get_operation_execution_time(BenchmarkerContext *context);

#endif