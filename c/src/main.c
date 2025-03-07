#include <stdio.h>
#include "quick_sort_benchmarker.h"

#define EXECUTION_COUNT 1000

// make
// ./build/bin/main
int main(int argc, char *argv[]) {
    QuickSortBenchmarker benchmarker = {};
    QuickSortBenchmarker_init(&benchmarker, "../random.json");
    QuickSortBenchmarker_print_benchmark_analysis(&benchmarker, EXECUTION_COUNT, true);

    return 0;
}