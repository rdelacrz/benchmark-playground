package benchmarkers

import (
	"encoding/json"
	"io"
	"log"
	"os"
	"sort"
	"strings"
	"time"

	"github.com/benchmark-playground/go/operations"
)

// String wrapper that allows strings to be compared against each other for sorting purposes
type ComparableString string

func (a ComparableString) CompareTo(b ComparableString) int {
	return strings.Compare(string(a), string(b))
}

// Benchmarker logic
type QuickSortBenchmarker struct {
	operationName   string
	unsortedList    []string
	validSortedList []string
}

func (b *QuickSortBenchmarker) getOperationName() string {
	return b.operationName
}

func (b *QuickSortBenchmarker) getOperationResults() OperationResult[[]string] {
	listCopy := make([]ComparableString, len(b.unsortedList))

	for i, elem := range b.unsortedList {
		listCopy[i] = ComparableString(elem)
	}

	// Gets execution time of QuickSort
	start := time.Now()
	operations.QuickSort(listCopy)
	executionTime := time.Since(start)

	// Converts String[] format back into regular slice of strings
	output := make([]string, len(listCopy))
	for i, elem := range listCopy {
		output[i] = string(elem)
	}

	return OperationResult[[]string]{
		output:        output,
		executionTime: executionTime,
	}
}

func (b *QuickSortBenchmarker) verifyOperationOutput(output []string) bool {
	if len(output) != len(b.validSortedList) {
		return false
	}
	for i := range output {
		if output[i] != b.validSortedList[i] {
			return false
		}
	}
	return true
}

func NewQuickSortBenchmarker(inputFile string) QuickSortBenchmarker {
	// Reads file
	file, err := os.Open(inputFile)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	inputValue, _ := io.ReadAll(file)

	// Unmarshal the JSON data into the slice
	var unsortedList []string
	err = json.Unmarshal(inputValue, &unsortedList)
	if err != nil {
		log.Fatal(err)
	}

	validSortedList := make([]string, len(unsortedList))
	copy(validSortedList, unsortedList)
	sort.Strings(validSortedList)

	return QuickSortBenchmarker{
		operationName:   "QuickSort",
		unsortedList:    unsortedList,
		validSortedList: validSortedList,
	}
}

func (b *QuickSortBenchmarker) PrintQuickSortBenchmarkAnalysis(executionCount int, verify bool) {
	PrintBenchmarkAnalysis(b, executionCount, verify)
}
