package main

import (
	"flag"
	"strings"

	"github.com/benchmark-playground/languages/go/benchmarkers"
	"github.com/benchmark-playground/languages/go/utils"
)

type Args struct {
	Operation string
	InputFile string
	Count     uint
}

// Parses arguments from CLI
func getArgs() Args {
	// Define command line flags
	var args Args
	flag.StringVar(&args.Operation, "operation", "", "The operation to be benchmarked")
	flag.StringVar(&args.Operation, "o", "", "The operation to be benchmarked (short)")
	flag.StringVar(&args.InputFile, "inputfile", "", "The path to a file containing the input data for the benchmarked operation.")
	flag.StringVar(&args.InputFile, "i", "", "The path to a file containing the input data for the benchmarked operation. (short)")
	flag.UintVar(&args.Count, "count", 1000, "The number of times an operation will be executed over the course of being benchmarked (default = 1000).")
	flag.UintVar(&args.Count, "c", 1000, "The number of times an operation will be executed over the course of being benchmarked (short).")

	// Parse the flags
	flag.Parse()

	return args
}

// Validates arguments and throws errors if any of them are invalid
func validateArgs(args Args, validOperations []string) {
	if args.Operation == "" {
		utils.Fatalf("You must specify a valid operation to benchmark: (%s)", strings.Join(validOperations, ", "))
	}

	if args.InputFile == "" {
		utils.Fatal("You must specify a file containing the input data for the benchmarked operation.")
	}
}

// go build -C src -ldflags="-s -w" -o ../build/main
// ./build/main -i ../../inputs/random_string_list.json -o QuickSort -c 1000 -v
func main() {
	var err error = nil
	benchmarkerManager := benchmarkers.GetBenchmarkerManager()

	args := getArgs()
	validateArgs(args, benchmarkerManager.GetOperationNames())

	// Retrieves benchmarker for given operation
	benchmarker, err := benchmarkerManager.GetOperationBenchmarker(args.Operation)
	if err != nil {
		utils.Fatalf("An error occurred while getting a benchmarker for a given operation: %v", err)
	}

	// Performs benchmark
	if err = benchmarker.ConsumeInputFile(args.InputFile); err != nil {
		utils.Fatalf("An error occurred while attempting to consume input file: %v", err)
	}

	if err = benchmarkers.PrintBenchmarkAnalysis(benchmarker, uint(args.Count)); err != nil {
		utils.Fatalf("An error occurred while attempting to print benchmark analysis: %v", err)
	}
}
