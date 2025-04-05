# python_benchmark_runner

The following subpackage runs benchmarks using code written in **Python**. Assuming that the operating system hosting this application is Ubuntu, [Python](https://www.python.org/downloads/) should already come preinstalled in it.

## Running python_benchmark_runner

This command will run the Python main.py, passing any CLI parameters directly to the executable.
```
./run.sh -o <operation_name> -i <input_file> -c <execution_count>
```

Example: `./run.sh -i ../../inputs/random.json -o QuickSort -c 1000 -v`