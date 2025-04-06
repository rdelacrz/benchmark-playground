#ifndef STRING_UTILS_H
#define STRING_UTILS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "cJSON.h"

typedef struct StringListData {
    char **list;
    int size;
} StringListData;

int compare_strings(const void *a, const void *b);
cJSON* convert_json_str_to_cJSON_array(char* json_str);
StringListData extract_str_list_from_json_str(char* json_str);

#endif