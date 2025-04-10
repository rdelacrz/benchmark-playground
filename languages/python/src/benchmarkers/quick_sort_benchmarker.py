import json

from benchmarkers._base_benchmarker import BaseBenchmarker
from operations.quick_sort import quick_sort

class QuickSortBenchmarker(BaseBenchmarker):
    def __init__(self, input_file_path: str):
        self.operation_name = "QuickSort"

        # Reads JSON list from input file
        with open(input_file_path, 'r') as file:
            self.unsorted_list: list[str] = json.load(file)

            # Gets valid sorted list for verification purposes
            self.valid_sorted_list = self.unsorted_list.copy()
            self.valid_sorted_list.sort()

    def _get_input_data_args(self):
        return [self.unsorted_list.copy(), 0, len(self.unsorted_list) - 1]

    def _perform_operation(self, *args):
        return quick_sort(*args)