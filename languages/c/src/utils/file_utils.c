#include "file_utils.h"

char* read_file_data(const char *input_file_path) {
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
