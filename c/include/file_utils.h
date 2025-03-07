#ifndef FILE_UTILS_H
#define FILE_UTILS_H

#include <stdio.h>
#include <stdlib.h>

#include "cJSON.h"

typedef struct StringListData {
    char *list;
    int size;
} StringListData;

char* reads_file_data(const char *input_file_path);
cJSON* convert_json_str_to_cJSON_array(char* json_str);
StringListData extract_str_list_from_json_str(char* json_str);

#endif