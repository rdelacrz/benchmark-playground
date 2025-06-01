#define DOCTEST_CONFIG_IMPLEMENT
#include <doctest/doctest.h>
#include <cstring> // for strcmp

#include "operations.h"

using namespace operations;

// Helper function to compare two char** arrays
bool arraysEqual(char** a, char** b, int size) {
    for (int i = 0; i < size; ++i) {
        if (strcmp(a[i], b[i]) != 0) {
            return false;
        }
    }
    return true;
}

TEST_CASE("QuickSort zero elements") {
    char *unsorted[] = { };
    char *expected_result[] = { };

    char **actual_result = quickSort(unsorted, 0);

    CHECK(arraysEqual(actual_result, expected_result, 0));
}

TEST_CASE("QuickSort single element") {
    char *unsorted[] = { "badger" };
    char *expected_result[] = { "badger" };

    char **actual_result = quickSort(unsorted, 1);

    CHECK(arraysEqual(actual_result, expected_result, 1));
}

TEST_CASE("QuickSort multiple odd elements") {
    char *unsorted[] = { "zinc", "trap", "tree", "trait", "badger", "apple", "chemistry", "pig", "zoo" };
    char *expected_result[] = { "apple", "badger", "chemistry", "pig", "trait", "trap", "tree", "zinc", "zoo" };

    char **actual_result = quickSort(unsorted, 9);

    CHECK(arraysEqual(actual_result, expected_result, 9));
}

TEST_CASE("QuickSort multiple even elements") {
    char *unsorted[] = { "trap", "apple", "chemistry", "pig", "zoo", "tree", "trait", "badger", "zinc", "crack" };
    char *expected_result[] = { "apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo" };

    char **actual_result = quickSort(unsorted, 10);

    CHECK(arraysEqual(actual_result, expected_result, 10));
}

TEST_CASE("QuickSort already sorted elements") {
    char *unsorted[] = { "apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo" };
    char *expected_result[] = { "apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo" };

    char **actual_result = quickSort(unsorted, 10);

    CHECK(arraysEqual(actual_result, expected_result, 10));
}

int main(int argc, char* argv[]) {
    doctest::Context context;

    // defaults
    context.setOption("order-by", "file");            // sort the test cases by file and line

    // overrides
    context.setOption("no-breaks", true);               // don't break in the debugger when assertions fail

    int res = context.run();    // run queries, or run tests unless --no-run is specified

    if (context.shouldExit())   // important - query flags (and --exit) rely on the user doing this
        return res;             // propagate the result of the tests

    context.clearFilters();     // removes all filters added up to this point

    return res; // the result from doctest is propagated here as well
}
