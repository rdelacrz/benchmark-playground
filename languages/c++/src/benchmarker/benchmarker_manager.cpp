#include <cstring>
#include <memory>
#include <vector>

#include "benchmarker.h"
#include "quick_sort_benchmarker.h"

namespace benchmarker {
    unique_ptr<Benchmarker> getBenchmarker(const char* operationName) {
        vector<Benchmarker*> benchmarkers = {
            new QuickSortBenchmarker()
        };
        for (Benchmarker* benchmarker : benchmarkers) {
            if (strcmp(benchmarker->getOperationName().c_str(), operationName) == 0) {
                return unique_ptr<Benchmarker>(benchmarker);
            }
        }

        return nullptr;
    }
}
