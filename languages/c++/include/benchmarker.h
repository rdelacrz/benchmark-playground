#ifndef BENCHMARKER_H
#define BENCHMARKER_H

#include <iostream>
#include <chrono>
#include <iomanip>
#include <numeric>
#include <string>
#include <vector>

using namespace std;
using namespace std::chrono;

namespace benchmarker {
    static const long NANO_TO_MILLI = 1e6;

    class Benchmarker {
        private:
            string operationName;

            long getOperationExecutionTime() {
                void* inputContext = getOperationInput();
                
                auto start = high_resolution_clock::now();
                performOperation(inputContext);
                auto stop = high_resolution_clock::now();

                cleanUpInputContext(inputContext);

                auto elapsed = stop - start;
                return duration_cast<nanoseconds>(elapsed).count();
            }

        protected:
            virtual void* getOperationInput() = 0;

            virtual void performOperation(void* inputContext) = 0;

            virtual void cleanUpInputContext(void* inputContext) = 0;

        public:
            Benchmarker (string name): operationName(name) { }

            virtual void consumeInputFile(const char* inputFilePath) = 0;

            string getOperationName() {
                return operationName;
            }

            vector<long> getOperationExecutionResults(int executionCount) {
                vector<long> executionTimes;
                for (int i = 0; i < executionCount; i++) {
                    executionTimes.push_back(getOperationExecutionTime());
                }
                return executionTimes;
            }

            void printExecutionResults(int executionCount) {
                vector<long> executionTimes = getOperationExecutionResults(executionCount);
                long totalDuration = accumulate(executionTimes.begin(), executionTimes.end(), 0);
                double elapsedMilliseconds = static_cast<double>(totalDuration) / NANO_TO_MILLI;
                cout << "C++'s " << operationName << " execution time (over " << executionCount << " loops) = " 
                    << fixed << setprecision(6) << elapsedMilliseconds << " ms" << endl;
            }

            virtual void cleanUpBenchmarker() = 0;
    };
}

#endif