# Go Benchmark Runner

The following subpackage runs benchmarks using code written in **Go**.

## Prerequisites

Install **Go** by following the installation instructions [here](https://go.dev/doc/install).

## Building Go Benchmark Runner

This command will build **Go Benchmark Runner** using **Go**'s `build` command. If the optional `-d` flag is passed as well (i.e. `./build.sh -d`), it will generate the debug version of the build.
```
./build.sh
```

## Running Go Benchmark Runner

This command will run the executable generated by the build step, passing any CLI parameters directly to the executable.
```
./run.sh -o <operation_name> -i <input_file> -c <execution_count>
```

Example: `./run.sh -i ../../inputs/random_string_list.json -o QuickSort -c 1000`