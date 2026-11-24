/**
 * Implements the QuickSort algorithm.
 */

import { Comparable } from '@utils/comparable';

function swap<T>(arr: Comparable<T>[], i: number, j: number) {
    [arr[i], arr[j]] = [arr[j], arr[i]];
}

function partition<T>(arr: Comparable<T>[], low: number, high: number): number {
    const pivot = arr[high]; // Last element is pivot
    let i = low - 1;        // Index of smaller element

    for (let j = low; j < high; j++) {
        if (arr[j].compareTo(pivot) < 0) {
            i++;
            swap(arr, i, j);
        }
    }

    i++;
    swap(arr, i, high);
    return i;
}

function quickSortInner<T>(arr: Comparable<T>[], low: number, high: number): Comparable<T>[] {
    if (low < high) {
        const pivotIndex = partition(arr, low, high);
        quickSortInner(arr, low, pivotIndex - 1);
        quickSortInner(arr, pivotIndex + 1, high);
    }
    return arr;
}

export function quickSort<T>(arr: Comparable<T>[]): Comparable<T>[] {
    return quickSortInner(arr, 0, arr.length - 1);
}