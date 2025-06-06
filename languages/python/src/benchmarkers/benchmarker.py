from abc import ABC, abstractmethod
import time

class Benchmarker(ABC):
    @abstractmethod
    def __init__(self, input_file_path: str):
        self.operation_name = "Unknown Operation"

    @abstractmethod
    def _get_input_data_args(self) -> list:
        """
        Gets list of input parameters that will be passed to the operation being
        performed and having its execution time measured. This getter method must
        be idempotent, so any non-primitive types should only have copies of the
        original data returned.
        """
        ...

    @abstractmethod
    def _perform_operation(self, *args):
        """
        Performs operation defined by the child class that inherits this base class.
        """
        ...

    def _get_operation_execution_time(self):
        """
        Performs the operation and returns the execution time of it.

        Args:
            verify (bool): If True, the operation's results will be verified to ensure
            that its output is correct. If it returns invalid output, an Exception will
            be raised.

        returns:
            float: The execution time of the operation in seconds.
        """

        input_data_args = self._get_input_data_args()

        # Performs operation and calculates execution time
        start_time = time.time()
        self._perform_operation(*input_data_args)
        end_time = time.time()

        return end_time - start_time

    def print_benchmark_analysis(self, execution_count=1000):
        """
        Prints the execution time of the operation being benchmarked after executing
        it the specified number of times.

        Args:
            execution_count (int): The number of times the benchmarked operation is being executed.
        """

        total_time = sum(self._get_operation_execution_time() for _ in range(execution_count))

        # Prints statistics
        print(f"Python's {self.operation_name} execution time (over {execution_count} loops): {round(total_time * 1000, 6)} ms")