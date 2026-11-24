#include <memory>

#include "benchmarker.h"
#include "quick_sort_benchmarker.h"
#include "file_utils.h"
#include "operations.h"

using namespace operations;
using namespace utils;

namespace benchmarker {

    void* QuickSortBenchmarker::getOperationInput() {
        auto input = make_unique<QuickSortInputContext>();
        input->reserve(unsortedList.size());
        for (const string& value : unsortedList) {
            input->push_back(value.c_str());
        }
        return input.release();
    }

    void QuickSortBenchmarker::performOperation(void* inputContext) {
        auto& input = *static_cast<QuickSortInputContext*>(inputContext);
        quickSort(input.data(), input.size());
    }

    void QuickSortBenchmarker::cleanUpInputContext(void* inputContext) {
        delete static_cast<QuickSortInputContext*>(inputContext);
    }

    void QuickSortBenchmarker::consumeInputFile(const char* inputFilePath) {
        unsortedList = getStringArrayFromJSONFile(inputFilePath);
    }

    void QuickSortBenchmarker::cleanUpBenchmarker() {
        unsortedList.clear();
        unsortedList.shrink_to_fit();
    }
}