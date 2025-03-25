/**
 * Implementation of QuickSort.
 */

#include "quick_sort.h"

// Function to swap two elements
inline void swap(char** a, char** b) {
    char* temp = *a;
    *a = *b;
    *b = temp;
}

// Partition function to find the pivot position
inline int partition(char *arr[], int len) {
    char *pivot = arr[len - 1]; // Choose the last element as pivot
    int store_index = 0;

    for (int i = 0; i < len - 1; i++) {
        if (strcmp(arr[i], pivot) < 0) {    // Compare strings
            swap(&arr[i], &arr[store_index]);
            store_index++;
        }
    }
    swap(&arr[store_index], &arr[len - 1]); // Move pivot to its final place
    return store_index;
}

char** quick_sort(char *arr[], int len) {
    if (len > 1) {
        int pivot = partition(arr, len);
        quick_sort(arr, pivot);             // Recursively sort the left part
        quick_sort(arr + pivot + 1, len - pivot - 1); // Recursively sort the right part
    }
    return arr;
}