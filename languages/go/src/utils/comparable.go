package utils

// Interface for two generic types that can be compared to each other
type Comparable[T any] interface {
	CompareTo(other T) int
}
