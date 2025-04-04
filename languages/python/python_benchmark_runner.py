import argparse

from benchmarkers.quick_sort_benchmarker import QuickSortBenchmarker

BENCHMARK_MAP = {
    'QuickSort': QuickSortBenchmarker,
}

def get_parsed_args():
    parser = argparse.ArgumentParser(
        prog='Benchmarker',
        description='Benchmarks Python operations by executing them a set number of times.',
    )

    parser.add_argument(
        '-o',
        '--operation',
        choices=BENCHMARK_MAP.keys(),
        help="The operation to be benchmarked."
    )

    parser.add_argument(
        '-i',
        '--input_file',
        help="The path to a file containing the input data for the benchmarked operation."
    )

    parser.add_argument(
        '-c',
        '--count',
        default=1000,
        type=int,
        help="The number of times an operation will be executed over the course of being benchmarked."
    )

    parser.add_argument(
        '-v',
        '--verify',
        action='store_true',
        default=False,
        help="Flag that determines whether or not to verify the results of the benchmarked operation."
    )

    return parser.parse_args()

# python3 main.py -i ../../inputs/random.json -o quick_sort -c 1000 -v
if __name__ == "__main__":
    args = get_parsed_args()

    if args.operation not in BENCHMARK_MAP:
        print(f"Error: The operation '{args.operation}' is not supported.")
    elif not args.input_file:
        print(f"Error: The operation '{args.operation}' requires an input file.")
    else:
        benchmarker = BENCHMARK_MAP[args.operation](args.input_file)
        benchmarker.print_benchmark_analysis(args.count, args.verify)
