package benchmarkers

import (
	"errors"
	"fmt"
	"maps"
	"slices"
	"sort"
	"strings"

	"github.com/benchmark-playground/languages/go/benchmarkers/impl"
)

type BenchmarkerManager struct {
	benchmarkers map[string]Benchmarker
}

func GetBenchmarkerManager() *BenchmarkerManager {
	benchmarkerList := []Benchmarker{
		impl.GetQuickSortBenchmarker(),
	}

	// Maps each benchmarker to its associated operation name
	benchmarkers := make(map[string]Benchmarker)
	for _, benchmarker := range benchmarkerList {
		benchmarkers[benchmarker.GetOperationName()] = benchmarker
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

func (m *BenchmarkerManager) GetOperationBenchmarker(operationName string) (Benchmarker, error) {
	var err error
	benchmarker, exists := m.benchmarkers[operationName]
	if !exists {
		validOperations := m.GetOperationNames()
		errorMessage := fmt.Sprintf("Operation name '%s' is invalid. Operation must be one of the following: %s",
			operationName,
			strings.Join(validOperations, ", "))
		err = errors.New(errorMessage)
	}
	return benchmarker, err
}
