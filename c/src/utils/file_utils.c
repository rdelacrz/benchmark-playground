#include "file_utils.h"

char* reads_file_data(const char *input_file_path) {
    // Reads file data
    FILE *file = fopen(input_file_path, "r");
    if (!file) {
        fprintf(stderr, "Failed to open file: '%s'\n", input_file_path);
        exit(EXIT_FAILURE);
    }

    // Gets file size using stream positioning
    fseek(file, 0, SEEK_END);
    long file_size = ftell(file);
    fseek(file, 0, SEEK_SET);
    
    // Allocates memory for JSON data, based on calculated file size
    char* file_data = malloc(file_size + 1);
    if (!file_data) {
        perror("Failed to allocate memory for file_data");
        fclose(file);
        exit(EXIT_FAILURE);
    }

    // Reads file stream into memory-allocated JSON data string
    if (fread(file_data, 1, file_size, file) != file_size) {
        fprintf(stderr, "Failed to read whole file: '%s'\n", input_file_path);
    }
    file_data[file_size] = '\0'; // Null-terminate the string
    fclose(file);

    return file_data;
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
        free(json_str);
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
                free(json_str);
                cJSON_Delete(json_array);
                exit(EXIT_FAILURE);
            }
            index++;
        }
    }

    cJSON_Delete(json_array);   // Clean up the JSON object

    return (StringListData) {.list = list_str, .size = string_count};
}