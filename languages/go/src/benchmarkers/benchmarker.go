package benchmarkers

import (
	"fmt"
	"time"

	"github.com/benchmark-playground/languages/go/utils"
	"github.com/samber/lo"
)

var nanoPerMilli int64 = 1000000

type Benchmarker interface {
	getOperationName() string
	getOperationExecutionTime() time.Duration
}

func GetOperationExecutionResults(b Benchmarker, executionCount uint) []time.Duration {
	return lo.Map(make([]struct{}, executionCount), func(_ struct{}, _ int) time.Duration {
		return b.getOperationExecutionTime()
	})
}

func PrintBenchmarkAnalysis(b Benchmarker, executionCount uint) {
	results := GetOperationExecutionResults(b, executionCount)
	total := lo.Reduce(results, func(agg int64, item time.Duration, _ int) int64 {
		return agg + item.Nanoseconds()
	}, int64(0))

	// TODO: Print more detailed time information
	totalMilli := utils.RoundToDecimals(float64(total)/float64(nanoPerMilli), 6)

	fmt.Printf("Go's %s execution time (over %d loops): %.6f ms\n", b.getOperationName(), executionCount, totalMilli)
}
