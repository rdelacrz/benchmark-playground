#ifndef QUICK_SORT_H
#define QUICK_SORT_H

#include <string.h>

void swap(char** a, char** b);
int partition(char *arr[], int low, int high);
char** quick_sort(char *arr[], int start, int end);

#endif