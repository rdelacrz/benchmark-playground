package impl

import (
	"encoding/json"
	"errors"
	"io"
	"os"
	"strings"

	"github.com/benchmark-playground/languages/go/operations"
	"github.com/samber/lo"
)

// String wrapper that allows strings to be compared against each other for sorting purposes
type ComparableString string

// Implements the Comparable interface's CompareTo function for ComparableString
func (a ComparableString) CompareTo(b ComparableString) int {
	return strings.Compare(string(a), string(b))
}

// Encapsulates QuickSort benchmarking logic
type QuickSortBenchmarker struct {
	operationName string
	unsortedList  []string
}

func (b *QuickSortBenchmarker) ConsumeInputFile(inputFilePath string) error {
	var err error

	// Opens file for reading
	file, err := os.Open(inputFilePath)
	if err != nil {
		return err
	}
	defer file.Close()

	// Reads file data
	inputValue, err := io.ReadAll(file)
	if err != nil {
		return err
	}

	var unsortedList []string
	if err = json.Unmarshal(inputValue, &unsortedList); err == nil {
		b.unsortedList = unsortedList
	}

	return err
}

func (b *QuickSortBenchmarker) GetOperationName() string {
	return b.operationName
}

func (b *QuickSortBenchmarker) GetOperationInput() any {
	return lo.Map(b.unsortedList, func(elem string, _ int) ComparableString {
		return ComparableString(elem)
	})
}

func (b *QuickSortBenchmarker) PerformOperation(inputContext any) error {
	comparableStrings, ok := inputContext.([]ComparableString)
	if !ok {
		return errors.New("Invalid input type passed to QuickSort!")
	}
	operations.QuickSort(comparableStrings)
	return nil
}

func GetQuickSortBenchmarker() *QuickSortBenchmarker {
	return &QuickSortBenchmarker{
		operationName: "QuickSort",
	}
}
