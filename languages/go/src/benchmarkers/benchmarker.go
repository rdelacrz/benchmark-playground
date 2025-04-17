package benchmarkers

import (
	"fmt"
	"time"

	"github.com/benchmark-playground/languages/go/utils"
	"github.com/samber/lo"
)

var nanoPerMilli int64 = 1000000

type Benchmarker interface {
	ConsumeInputFile(string) error
	GetOperationName() string
	GetOperationInput() any
	PerformOperation(inputContext any) error
}

func getOperationExecutionTime(b Benchmarker) (time.Duration, error) {
	contextInput := b.GetOperationInput()

	start := time.Now()
	err := b.PerformOperation(contextInput)
	executionTime := time.Since(start)

	return executionTime, err
}

func GetOperationExecutionResults(b Benchmarker, executionCount uint) ([]time.Duration, error) {
	var err error
	var results []time.Duration = make([]time.Duration, executionCount)
	for _ = range executionCount {
		executionTime, err := getOperationExecutionTime(b)
		if err != nil {
			return results, err
		}
		results = append(results, executionTime)
	}

	return results, err
}

func PrintBenchmarkAnalysis(b Benchmarker, executionCount uint) error {
	results, err := GetOperationExecutionResults(b, executionCount)
	if err != nil {
		return err
	}

	total := lo.Reduce(results, func(agg int64, item time.Duration, _ int) int64 {
		return agg + item.Nanoseconds()
	}, int64(0))

	// TODO: Print more detailed time information
	totalMilli := utils.RoundToDecimals(float64(total)/float64(nanoPerMilli), 6)

	fmt.Printf("Go's %s execution time (over %d loops): %.6f ms\n", b.GetOperationName(), executionCount, totalMilli)

	return nil
}
