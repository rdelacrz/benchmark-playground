package main

import (
	"github.com/benchmark-playground/go/benchmarkers"
)

// go build -ldflags="-s -w" -o main
// ./main
func main() {
	benchmarker := benchmarkers.NewQuickSortBenchmarker("../../inputs/random.json")
	benchmarker.PrintQuickSortBenchmarkAnalysis(1000, true)
}
