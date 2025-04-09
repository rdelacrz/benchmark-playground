package operations

import (
	"reflect"
	"strings"
	"testing"

	"github.com/samber/lo"
)

// String wrapper that allows strings to be compared against each other for sorting purposes
type ComparableString string

// Implements the Comparable interface's CompareTo function for ComparableString
func (a ComparableString) CompareTo(b ComparableString) int {
	return strings.Compare(string(a), string(b))
}

// Implements the Comparable interface's CompareTo function for ints
type ComparableInt int

// Implements the Comparable interface's CompareTo function for ComparableInt
func (a ComparableInt) CompareTo(b ComparableInt) int {
	return int(a) - int(b)
}

func TestQuickSortZeroElements(t *testing.T) {
	// Arrange
	unsorted := []ComparableString{}
	expectedResult := []ComparableString{}

	// Act
	actualResult := QuickSort(unsorted)

	// Assert
	if !reflect.DeepEqual(expectedResult, actualResult) {
		t.Errorf("Invalid sorting results.")
	}
}

func TestQuickSortSingleElement(t *testing.T) {
	// Arrange
	unsorted := []ComparableString{ComparableString("badger")}
	expectedResult := []ComparableString{ComparableString("badger")}

	// Act
	actualResult := QuickSort(unsorted)

	// Assert
	if !reflect.DeepEqual(expectedResult, actualResult) {
		t.Errorf("Invalid sorting results.")
	}
}

func TestQuickSortMultipleOddElements(t *testing.T) {
	// Arrange
	unsorted := lo.Map(
		[]string{"zinc", "trap", "tree", "trait", "badger", "apple", "chemistry", "pig", "zoo"},
		func(elem string, index int) ComparableString {
			return ComparableString(elem)
		})
	expectedResult := lo.Map(
		[]string{"apple", "badger", "chemistry", "pig", "trait", "trap", "tree", "zinc", "zoo"},
		func(elem string, index int) ComparableString {
			return ComparableString(elem)
		})

	// Act
	actualResult := QuickSort(unsorted)

	// Assert
	if !reflect.DeepEqual(expectedResult, actualResult) {
		t.Errorf("Invalid sorting results.")
	}
}

func TestQuickSortMultipleEvenElements(t *testing.T) {
	// Arrange
	unsorted := lo.Map(
		[]string{"trap", "apple", "chemistry", "pig", "zoo", "tree", "trait", "badger", "zinc", "crack"},
		func(elem string, index int) ComparableString {
			return ComparableString(elem)
		})
	expectedResult := lo.Map(
		[]string{"apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo"},
		func(elem string, index int) ComparableString {
			return ComparableString(elem)
		})

	// Act
	actualResult := QuickSort(unsorted)

	// Assert
	if !reflect.DeepEqual(expectedResult, actualResult) {
		t.Errorf("Invalid sorting results.")
	}
}

func TestQuickSortAlreadySorted(t *testing.T) {
	// Arrange
	unsorted := lo.Map(
		[]string{"apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo"},
		func(elem string, index int) ComparableString {
			return ComparableString(elem)
		})
	expectedResult := lo.Map(
		[]string{"apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo"},
		func(elem string, index int) ComparableString {
			return ComparableString(elem)
		})

	// Act
	actualResult := QuickSort(unsorted)

	// Assert
	if !reflect.DeepEqual(expectedResult, actualResult) {
		t.Errorf("Invalid sorting results.")
	}
}

func TestQuickSortIntegers(t *testing.T) {
	// Arrange
	unsorted := lo.Map(
		[]int{4, -54, 40, 400, 2, -7, 0, 1, 4},
		func(elem int, index int) ComparableInt {
			return ComparableInt(elem)
		})
	expectedResult := lo.Map(
		[]int{-54, -7, 0, 1, 2, 4, 4, 40, 400},
		func(elem int, index int) ComparableInt {
			return ComparableInt(elem)
		})

	// Act
	actualResult := QuickSort(unsorted)

	// Assert
	if !reflect.DeepEqual(expectedResult, actualResult) {
		t.Errorf("Invalid sorting results.")
	}
}
