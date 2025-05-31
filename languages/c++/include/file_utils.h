#ifndef FILE_UTILS_H
#define FILE_UTILS_H

#include <string>
#include <vector>

using namespace std;

namespace utils {
    vector<string> getStringArrayFromJSONFile(const char* jsonFilePath);
}

#endif