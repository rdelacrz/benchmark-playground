# python_benchmark_runner

The following subpackage runs benchmarks using code written in **Python**. Assuming that the operating system hosting this application is Ubuntu, [Python](https://www.python.org/downloads/) should already come preinstalled in it.

## Prerequisites

Several software must be installed in order to run **python_benchmark_runner**. The following instructions will assume that the operating system hosting this application is Ubuntu.

Install `venv` via this command (note that you can replace the version number for Python with whatever is applicable for your Python installation):
```
sudo apt install python3.12-venv
```

Create a [venv](https://docs.python.org/3/library/venv.html) virtual environment in your local package:
```
python3 -m venv .venv
```

### Setting up venv environment
The following command should be run every time you open a new shell to run CLI commands (in order to ensure that third party libraries are installed only for this package):
```
. .venv/bin/activate
```

### Install Third-Party dependencies
You can install the following third party dependencies associated with this Python application with the following command (assuming your `venv` environment is already active):
```
pip install -r requirements.txt
```

Alternatively, if you are updating the third party dependencies to install in this package, you can run the following command in the root Python directory to ensure that the `requirements.txt` file is up to date with the latest libraries to install in this package's environment:
```
pip freeze > requirements.txt
```

## Building python_benchmark_runner



## Running python_benchmark_runner

This command will run the Python main.py, passing any CLI parameters directly to the executable.
```
./run.sh -o <operation_name> -i <input_file> -c <execution_count>
```

Example: `./run.sh -i ../../inputs/random.json -o QuickSort -c 1000 -v`