#include <iostream>
#include <algorithm>
#include <getopt.h>
#include <filesystem>
#include <cstring>

#include "benchmarker.h"
#include "quick_sort_benchmarker.h"
#include "string_utils.h"

using namespace benchmarker;
using namespace std;
using namespace utils;

static const vector<string> validOperations = {
    "QuickSort"
};

struct Arguments {
    const char *operation = nullptr;
    const char *inputFile = nullptr;
    int count = 1000;
};

static const option CLI_OPTIONS[] = {
    {"operation", required_argument, nullptr, 'o'},
    {"inputfile", required_argument, nullptr, 'i'},
    {"count", required_argument, nullptr, 'c'},
    {nullptr, no_argument, nullptr, 0}
};

Arguments parseArgs(int argc, char* argv[]) {
    Arguments args;

    // Parses command line arguments for benchmark values
    int opt;
    while ((opt = getopt_long(argc, argv, "o:i:c:", CLI_OPTIONS, 0)) != -1) {
        switch (opt) {
            case 'o':
                args.operation = optarg;
                break;
            case 'i':
                args.inputFile = optarg;
                break;
            case 'c':
                try {
                    args.count = atoi(optarg);
                } catch (invalid_argument&) {
                    cerr << "Invalid count: " << optarg << " is not a number!" << endl;
                    exit(EXIT_FAILURE);
                }
                break;
            default:
                cerr << "Error: " << opt << " is not a valid argument!" << endl;
                exit(EXIT_FAILURE);
        }
    }

    // Check is operation is among valid set
    if (find(validOperations.begin(), validOperations.end(), args.operation) == validOperations.end()) {
        string validOperationsStr = joinStrings(validOperations, ", ");
        cerr << "Error: " << args.operation << " is not a valid operation! It should be one of the following: " << validOperationsStr << endl;
        exit(EXIT_FAILURE);
    }

    // Checks for valid file
    if (!filesystem::exists(args.inputFile)) {
        cerr << "Error: The file '" << args.inputFile << "' does not exist!" << endl;
        exit(EXIT_FAILURE);
    }

    // Checks if count is not a negative number
    if (args.count <= 0) {
        cerr << "Error: The count must be greater than 0, but was " << args.count << "!" << endl;
        exit(EXIT_FAILURE);
    }

    return args;
}

int main(int argc, char* argv[]) {
    long totalDuration = 0;

    Arguments args = parseArgs(argc, argv);

    Benchmarker* benchmarker = nullptr;

    // Gets proper benchmarker from list
    QuickSortBenchmarker quickSortBenchmarker = QuickSortBenchmarker();
    vector<Benchmarker*> benchmarkers = {
        &quickSortBenchmarker
    };
    for (Benchmarker* benchmarkerPtr : benchmarkers) {
        if (strcmp(benchmarkerPtr->getOperationName().c_str(), args.operation) == 0) {
            benchmarker = benchmarkerPtr;
        }
    }

    // Should not be reached due to prior validation checks, but just to be
    if (benchmarker != nullptr) {
        benchmarker->consumeInputFile(args.inputFile);
        benchmarker->printExecutionResults(args.count);
        benchmarker->cleanUpBenchmarker();
    } else {
        cerr << "Benchmarker could not be properly set!" << endl;
    }

    return 0;
}