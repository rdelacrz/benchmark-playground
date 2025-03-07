/**
 * Implementation of QuickSort.
 */

#include "quick_sort.h"

// Function to swap two elements
void swap(char** a, char** b) {
    char* temp = *a;
    *a = *b;
    *b = temp;
}

// Partition function to find the pivot position
int partition(char *arr[], int low, int high) {
    char* pivot = arr[high];   // Choosing the last element as pivot
    int i = (low - 1); // Index of the smaller element

    for (int j = low; j < high; j++) {
        if (strcmp(arr[j], pivot) <= 0) {
            i++;
            swap(&arr[i], &arr[j]);
        }
    }

    int pivot_index = i + 1;
    swap(&arr[pivot_index], &arr[high]);
    return pivot_index;
}

char** quick_sort(char *arr[], int low, int high) {
    if (low < high) {
        int pivot_index = partition(arr, low, high);
        quick_sort(arr, low, pivot_index - 1);
        quick_sort(arr, pivot_index + 1, high);
    }
    return arr;
}