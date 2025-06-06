# Rust Benchmark Runner

The following subpackage runs benchmarks using code written in **Rust**.

## Prerequisites

Install **Rust** by following the installation instructions [here](https://www.rust-lang.org/tools/install).

## Building Rust Benchmark Runner

This command will build **Rust Benchmark Runner** using the `build` command of [Cargo](https://doc.rust-lang.org/cargo/) (the package manager of Rust). If the optional `-d` flag is passed as well (i.e. `./build.sh -d`), it will generate the debug version of the build, which when run will be slower than the release version, but displays more debug messages for troubleshooting issues.
```
./build.sh
```

## Running Rust Benchmark Runner

This command will run the executable generated by the build step, passing any CLI parameters directly to the executable.
```
./run.sh -o <operation_name> -i <input_file> -c <execution_count>
```

Example: `./run.sh -i ../../inputs/random_string_list.json -o QuickSort -c 1000`