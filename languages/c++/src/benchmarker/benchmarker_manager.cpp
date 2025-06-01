#include <cstring>
#include <memory>
#include <vector>

#include "benchmarker.h"
#include "quick_sort_benchmarker.h"

namespace benchmarker {
    shared_ptr<Benchmarker> getBenchmarker(const char* operationName) {
        vector<Benchmarker*> benchmarkers = {
            new QuickSortBenchmarker()
        };
        for (Benchmarker* benchmarker : benchmarkers) {
            if (strcmp(benchmarker->getOperationName().c_str(), operationName) == 0) {
                return shared_ptr<Benchmarker>(benchmarker);
            }
        }

        return nullptr;
    }
}
