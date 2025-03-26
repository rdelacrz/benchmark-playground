#include "string_utils.h"

int compare_strings(const void *a, const void *b) {
    // Cast the void pointers to char pointers
    const char *str_a = *(const char **)a;
    const char *str_b = *(const char **)b;

    // Use strcmp to compare the strings
    return strcmp(str_a, str_b);
}