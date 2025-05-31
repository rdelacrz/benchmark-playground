#include <numeric>
#include <sstream>
#include <vector>

#include "string_utils.h"

using namespace std;

namespace utils {
    string joinStrings(vector<string> const &strings, string delim) {
        if (strings.empty()) {
            return string();
        }
    
        return accumulate(strings.begin() + 1, strings.end(), strings[0],
            [&delim](string x, string y) {
                return x + delim + y;
            }
        );
    }
}