#ifndef QUICK_SORT_BENCHMARKER_H
#define QUICK_SORT_BENCHMARKER_H

#include <string>
#include <vector>

#include "benchmarker.h"

using namespace std;

namespace benchmarker {
    using QuickSortInputContext = vector<const char*>;

    class QuickSortBenchmarker : public Benchmarker {
        private:
            // Owns the characters; never modified while an operation context is live.
            vector<string> unsortedList;

        protected:
            void* getOperationInput();

            void performOperation(void* inputContext);

            void cleanUpInputContext(void* inputContext);

        public:
            QuickSortBenchmarker() : Benchmarker("QuickSort") {}

            void consumeInputFile(const char* inputFilePath);

            void cleanUpBenchmarker();
    };
}

#endif