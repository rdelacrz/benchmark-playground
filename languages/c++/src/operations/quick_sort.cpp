#include <cstring>

#include "operations.h"

namespace operations {
    inline void swap(char* arr[], int index1, int index2) {
        char* temp = arr[index1];
        arr[index1] = arr[index2];
        arr[index2] = temp;
    }

    // Partition function to find the pivot position
    inline int partition(char *arr[], int len) {
        char *pivot = arr[len - 1]; // Choose the last element as pivot
        int storeIndex = 0;

        for (int i = 0; i < len - 1; i++) {
            if (strcmp(arr[i], pivot) < 0) {    // Compare strings
                swap(arr, i, storeIndex);
                storeIndex++;
            }
        }
        swap(arr, storeIndex, len - 1);
        return storeIndex;
    }

    char** quickSort(char *arr[], int len) {
        if (len > 1) {
            int pivot = partition(arr, len);
            quickSort(arr, pivot);             // Recursively sort the left part
            quickSort(arr + pivot + 1, len - pivot - 1); // Recursively sort the right part
        }
        return arr;
    }
}