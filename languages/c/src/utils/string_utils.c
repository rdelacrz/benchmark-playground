#include "string_utils.h"

int compare_strings(const void *a, const void *b) {
    // Cast the void pointers to char pointers
    const char *str_a = *(const char **)a;
    const char *str_b = *(const char **)b;

    // Use strcmp to compare the strings
    return strcmp(str_a, str_b);
}

cJSON* convert_json_str_to_cJSON_array(char* json_str) {
    // Parses the JSON data from raw file data
    cJSON *json_array = cJSON_Parse(json_str);
    if (!json_array) {
        fprintf(stderr, "Error parsing JSON: %s\n", cJSON_GetErrorPtr());
        free(json_str);
        exit(EXIT_FAILURE);
    }

    if (!cJSON_IsArray(json_array)) {
        fprintf(stderr, "Provided JSON is not an array\n");
        free(json_str);
        exit(EXIT_FAILURE);
    }

    free(json_str);

    return json_array;
}

StringListData extract_str_list_from_json_str(char* json_str) {
    int string_count = 0;   // Count of strings read

    // Parses the JSON data from raw file data
    cJSON *json_array = convert_json_str_to_cJSON_array(json_str);

    // First pass: Count the number of valid strings
    cJSON *string_item;
    cJSON_ArrayForEach(string_item, json_array) {
        if (cJSON_IsString(string_item) && (string_item->valuestring != NULL)) {
            string_count++;
        }
    }
    
    // Allocate memory for the string list based on the number of strings
    char** list_str = malloc(string_count * sizeof(char *));
    if (!list_str) {
        fprintf(stderr, "Failed to allocate memory for string list\n");
        cJSON_Delete(json_array);
        exit(EXIT_FAILURE);
    }

    // Second pass: Store the strings in the allocated array
    int index = 0;
    cJSON_ArrayForEach(string_item, json_array) {
        if (cJSON_IsString(string_item) && (string_item->valuestring != NULL)) {
            list_str[index] = strdup(string_item->valuestring);
            if (!list_str[index]) {
                fprintf(stderr, "Failed to allocate memory for string in list_str at index %d\n", index);

                // Free previously allocated strings and string size pointer
                for (int i = 0; i < index; i++) {
                    free(list_str[i]);
                }
                free(list_str);
                cJSON_Delete(json_array);
                exit(EXIT_FAILURE);
            }
            index++;
        }
    }
    
    cJSON_Delete(json_array);   // Clean up the JSON object

    return (StringListData) {.list = list_str, .size = string_count};
}