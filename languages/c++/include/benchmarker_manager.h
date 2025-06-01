#ifndef BENCHMARKER_MANAGER_H
#define BENCHMARKER_MANAGER_H

#include <memory>

#include "benchmarker.h"

using namespace std;

namespace benchmarker {
    unique_ptr<Benchmarker> getBenchmarker(const char* operationName);
}

#endif