#ifndef QUICK_SORT_BENCHMARKER_H
#define QUICK_SORT_BENCHMARKER_H

#include <string>
#include <vector>

using namespace std;

namespace benchmarker {
    struct QuickSortInputContext {
        char** listCopy;
        size_t size;
    };

    class QuickSortBenchmarker : public Benchmarker {
        private:
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