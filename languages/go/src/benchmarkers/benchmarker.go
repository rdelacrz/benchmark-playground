package benchmarkers

import (
	"fmt"
	"log"
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

func PrintBenchmarkAnalysis[O any](b Benchmarker[O], executionCount uint, verify bool) {
	total := int64(0)

	for range make([]struct{}, executionCount) {
		results := b.getOperationResults()

		if verify && !b.verifyOperationOutput(results.output) {
			log.Fatal("QuickSort results are not properly sorted!")
		}

		total += results.executionTime.Nanoseconds()
	}

	totalMilli := utils.RoundToDecimals(float64(total)/float64(nanoPerMilli), 6)

	fmt.Printf("Go's %s execution time (over %d loops): %.6f ms\n", b.getOperationName(), executionCount, totalMilli)
}
