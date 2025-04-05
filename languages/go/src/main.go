package main

import (
	"flag"
	"strings"

	"github.com/benchmark-playground/go/benchmarkers"
	"github.com/benchmark-playground/go/utils"
)

type Args struct {
	Operation string
	InputFile string
	Count     uint
	Verify    bool
}

// Parses arguments from CLI
func getArgs() Args {
	// Define command line flags
	var args Args
	flag.StringVar(&args.Operation, "operation", "", "The operation to be benchmarked")
	flag.StringVar(&args.Operation, "o", "", "The operation to be benchmarked (short)")
	flag.StringVar(&args.InputFile, "input_file", "", "The path to a file containing the input data for the benchmarked operation.")
	flag.StringVar(&args.InputFile, "i", "", "The path to a file containing the input data for the benchmarked operation. (short)")
	flag.UintVar(&args.Count, "count", 1000, "The number of times an operation will be executed over the course of being benchmarked (default = 1000).")
	flag.UintVar(&args.Count, "c", 1000, "The number of times an operation will be executed over the course of being benchmarked (short).")
	flag.BoolVar(&args.Verify, "verify", false, "Flag that determines whether or not to verify the results of the benchmarked operation. (default: false)")
	flag.BoolVar(&args.Verify, "v", false, "Flag that determines whether or not to verify the results of the benchmarked operation. (short)")

	// Parse the flags
	flag.Parse()

	return args
}

var validOperations = []string{"QuickSort"}

// Validates arguments and throws errors if any of them are invalid
func validateArgs(args Args) {
	if args.Operation == "" {
		utils.Fatalf("You must specify a valid operation to benchmark: (%s)", strings.Join(validOperations, ", "))
	}

	if args.InputFile == "" {
		utils.Fatal("You must specify a file containing the input data for the benchmarked operation.")
	}
}

// go build -C src -ldflags="-s -w" -o ../build/main
// ./build/main -i ../../inputs/random.json -o QuickSort -c 1000 -v
func main() {
	args := getArgs()
	validateArgs(args)

	// Prints benchmaker analysis for a given operation
	switch args.Operation {
	case "QuickSort":
		benchmarker := benchmarkers.NewQuickSortBenchmarker(args.InputFile)
		benchmarkers.PrintBenchmarkAnalysis(benchmarker, uint(args.Count), args.Verify)
	default:
		utils.Fatalf("Error: The operation '%s' is not supported.", args.Operation)
	}
}
