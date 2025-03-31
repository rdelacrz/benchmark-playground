#ifndef BENCHMARKER_H
#define BENCHMARKER_H

#include <stdio.h>

typedef struct Benchmarker {
    void (*execute)(void* context);
    void (*clean_up)(void* context);
} Benchmarker;

typedef struct BenchmarkerContext {
    Benchmarker* benchmarker;
    char* operation_name;
    void* data;
    int execution_count;
} BenchmarkerContext;

void print_benchmark_analysis(char* operation_name, int execution_count, double time_in_nanoseconds);
void execute_benchmarker(BenchmarkerContext *context);
void clean_up_benchmarker(BenchmarkerContext *context);

#endif