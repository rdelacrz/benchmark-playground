//lint:file-ignore U1000 Code flagged as unused are actually invoked in PrintBenchmarkAnalysis within benchmarker.go

package benchmarkers

import (
	"encoding/json"
	"io"
	"os"
	"strings"
	"time"

	"github.com/benchmark-playground/languages/go/operations"
	"github.com/benchmark-playground/languages/go/utils"
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

func (b *QuickSortBenchmarker) consumeInputFile(inputFilePath string) {
	// Reads file data itself
	file, err := os.Open(inputFilePath)
	if err != nil {
		utils.Fatal(err.Error())
	}
	defer file.Close()
	inputValue, _ := io.ReadAll(file)

	// Unmarshal the JSON data into the slice
	var unsortedList []string
	err = json.Unmarshal(inputValue, &unsortedList)
	if err != nil {
		utils.Fatal(err.Error())
	}

	b.unsortedList = unsortedList
}

func (b *QuickSortBenchmarker) getOperationName() string {
	return b.operationName
}

func (b *QuickSortBenchmarker) getOperationExecutionTime() time.Duration {
	listCopy := lo.Map(b.unsortedList, func(elem string, _ int) ComparableString {
		return ComparableString(elem)
	})

	// Gets execution time of QuickSort
	start := time.Now()
	operations.QuickSort(listCopy)
	executionTime := time.Since(start)

	return executionTime
}

func GetQuickSortBenchmarker() *QuickSortBenchmarker {
	return &QuickSortBenchmarker{
		operationName: "QuickSort",
	}
}
