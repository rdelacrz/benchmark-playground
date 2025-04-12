package benchmarkers

import (
	"maps"
	"slices"
	"sort"
	"strings"

	"github.com/benchmark-playground/languages/go/utils"
)

type BenchmarkerManager struct {
	benchmarkers map[string]Benchmarker
}

func GetBenchmarkerManager() *BenchmarkerManager {
	benchmarkerList := []Benchmarker{
		GetQuickSortBenchmarker(),
	}

	// Maps each benchmarker to its associated operation name
	benchmarkers := make(map[string]Benchmarker)
	for _, benchmarker := range benchmarkerList {
		benchmarkers[benchmarker.getOperationName()] = benchmarker
	}

	return &BenchmarkerManager{
		benchmarkers,
	}
}

func (m *BenchmarkerManager) GetOperationNames() []string {
	operationNames := slices.Collect(maps.Keys(m.benchmarkers))
	sort.Strings(operationNames)
	return operationNames
}

func (m *BenchmarkerManager) GetOperationBenchmarker(operationName string) Benchmarker {
	benchmarker, exists := m.benchmarkers[operationName]
	if !exists {
		validOperations := m.GetOperationNames()
		utils.Fatalf(
			"Operation name '%s' not found. Operation must be one of the following: %s",
			operationName,
			strings.Join(validOperations, ", "),
		)
	}
	return benchmarker
}
