package operations

import (
	"github.com/benchmark-playground/go/utils"
)

func partition[T utils.Comparable[T]](arr []T) int {
	len := len(arr)
	pivot := len - 1
	storeIndex := 0

	for i := range len {
		if arr[i].CompareTo(arr[pivot]) < 0 {
			arr[i], arr[storeIndex] = arr[storeIndex], arr[i]
			storeIndex++
		}
	}
	arr[storeIndex], arr[pivot] = arr[pivot], arr[storeIndex]
	return storeIndex
}

func QuickSort[T utils.Comparable[T]](arr []T) []T {
	if len(arr) > 1 {
		pivot := partition(arr)
		QuickSort(arr[:pivot])
		QuickSort(arr[pivot+1:])
	}
	return arr
}
