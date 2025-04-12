package org.benchmarkplayground.operations;

import java.util.List;

public final class QuickSort {
    private static <T extends Comparable<T>> void swap(List<T> arr, int i, int j) {
        T temp = arr.get(i);
        arr.set(i, arr.get(j));
        arr.set(j, temp);
    }

    private static <T extends Comparable<T>> int partition(List<T> arr, int low, int high) {
        int pivot = high;   // Last element is pivot
        int i = low - 1;    // Index of smaller element

        for (int j = low; j < high; j++) {
            if (arr.get(j).compareTo(arr.get(pivot)) < 0) {
                i++;
                swap(arr, i, j);
            }
        }

        i++;
        swap(arr, i, pivot);
        return i;
    }

    private static <T extends Comparable<T>> List<T> quickSort(List<T> arr, int low, int high) {
        if (low < high) {
            int pivotIndex = partition(arr, low, high);
            quickSort(arr, low, pivotIndex - 1);
            quickSort(arr, pivotIndex + 1, high);
        }
        return arr;
    }

    public static <T extends Comparable<T>> List<T> quickSort(List<T> arr) {
        return quickSort(arr, 0, arr.size() - 1);
    }
}
