#include "unity.h"

#include "quick_sort.h"

void setUp(void) {
    // set stuff up here
}

void tearDown(void) {
    // clean stuff up here
}

void test_quickSort_zeroElements(void) {
    // Arrange
    char *unsorted[] = { };
    char *expected_result[] = { };

    // Act
    char **actual_result = quick_sort(unsorted, 0);

    // Assert
    TEST_ASSERT_EQUAL_STRING_LEN(expected_result, actual_result, 0);
}

void test_quickSort_singleElement(void) {
    // Arrange
    char *unsorted[] = { "badger" };
    char *expected_result[] = { "badger" };

    // Act
    char **actual_result = quick_sort(unsorted, 1);

    // Assert
    TEST_ASSERT_EQUAL_STRING_ARRAY(expected_result, actual_result, 1);
}

void test_quickSort_multipleOddElements(void) {
    // Arrange
    char *unsorted[] = { "zinc", "trap", "tree", "trait", "badger", "apple", "chemistry", "pig", "zoo" };
    char *expected_result[] = { "apple", "badger", "chemistry", "pig", "trait", "trap", "tree", "zinc", "zoo" };

    // Act
    char **actual_result = quick_sort(unsorted, 9);

    // Assert
    TEST_ASSERT_EQUAL_STRING_ARRAY(expected_result, actual_result, 9);
}

void test_quickSort_multipleEvenElements(void) {
    // Arrange
    char *unsorted[] = { "trap", "apple", "chemistry", "pig", "zoo", "tree", "trait", "badger", "zinc", "crack" };
    char *expected_result[] = { "apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo" };

    // Act
    char **actual_result = quick_sort(unsorted, 10);

    // Assert
    TEST_ASSERT_EQUAL_STRING_ARRAY(expected_result, actual_result, 10);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_quickSort_zeroElements);
    RUN_TEST(test_quickSort_singleElement);
    RUN_TEST(test_quickSort_multipleOddElements);
    RUN_TEST(test_quickSort_multipleEvenElements);
    return UNITY_END();
}