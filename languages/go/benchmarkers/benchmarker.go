package benchmarkers

import (
	"fmt"
	"time"

	"github.com/benchmark-playground/go/utils"
)

var nanoPerMilli int64 = 1000000

type OperationResult[O any] struct {
	output        O
	executionTime time.Duration
}

type Benchmarker[O any] interface {
	getOperationName() string
	getOperationResults() OperationResult[O]
	verifyOperationOutput(output O) bool
}

func PrintBenchmarkAnalysis[O any](b Benchmarker[O], executionCount int, verify bool) {
	total := int64(0)

	for range make([]struct{}, executionCount) {
		results := b.getOperationResults()

		if verify && !b.verifyOperationOutput(results.output) {
			panic("QuickSort results are not properly sorted!")
		}

		total += b.getOperationResults().executionTime.Nanoseconds()
	}

	totalMilli := utils.RoundToDecimals(float64(total)/float64(nanoPerMilli), 4)

	fmt.Printf("Go's %s execution time (over %d loops): %.4f ms\n", b.getOperationName(), executionCount, totalMilli)
}
