#include <cstring>
#include <vector>

#include "benchmarker.h"
#include "quick_sort_benchmarker.h"
#include "file_utils.h"
#include "operations.h"

using namespace operations;
using namespace utils;

namespace benchmarker {

    void* QuickSortBenchmarker::getOperationInput() {
        size_t size = unsortedList.size();

        QuickSortInputContext* inputContext = new QuickSortInputContext();

        // Allocate memory for each string in unsortedList
        inputContext->listCopy = new char*[size];
        for (int j = 0; j < size; j++) {
            inputContext->listCopy[j] = new char[unsortedList[j].size() + 1]; // +1 for the null terminator
            strcpy(inputContext->listCopy[j], unsortedList[j].c_str());
        }
        inputContext->size = size;

        return static_cast<void*>(inputContext);
    }

    void QuickSortBenchmarker::performOperation(void* inputContext) {
        QuickSortInputContext* quickSortInputContext = static_cast<QuickSortInputContext*>(inputContext);
        quickSort(quickSortInputContext->listCopy, quickSortInputContext->size);
    }

    void QuickSortBenchmarker::cleanUpInputContext(void* inputContext) {
        QuickSortInputContext* quickSortInputContext = static_cast<QuickSortInputContext*>(inputContext);

        // Clean up each string in listCopy
        for (int i = 0; i < quickSortInputContext->size; i++) {
            delete[] quickSortInputContext->listCopy[i];
        }

        delete[] quickSortInputContext->listCopy;
        delete quickSortInputContext;
    }

    void QuickSortBenchmarker::consumeInputFile(const char* inputFilePath) {
        unsortedList = getStringArrayFromJSONFile(inputFilePath);
    }

    void QuickSortBenchmarker::cleanUpBenchmarker() {
        unsortedList.clear();
        unsortedList.shrink_to_fit();
    }
}