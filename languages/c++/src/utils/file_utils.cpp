#include <iostream>
#include <format>
#include <vector>

#include "rapidjson/document.h"
#include "rapidjson/filereadstream.h"

#include "file_utils.h"

using namespace rapidjson;
using namespace std;

namespace utils {
    vector<string> getStringArrayFromJSONFile(const char* jsonFilePath) {
        FILE* fp = fopen(jsonFilePath, "r");
        if (!fp) {
            cerr << format("Failed to open file: '{}'\n", jsonFilePath) << endl;
            exit(EXIT_FAILURE);
        }

        // Gets file size using stream positioning
        fseek(fp, 0, SEEK_END);
        long file_size = ftell(fp);
        fseek(fp, 0, SEEK_SET);

        // Reads file into stream
        char* readBuffer = new char[file_size + 1];     // +1 for null terminator
        fread(readBuffer, 1, file_size, fp);
        readBuffer[file_size] = '\0'; // Null-terminate the buffer
        fclose(fp);

        // Parse the JSON data
        Document doc;
        doc.Parse(readBuffer);
        delete[] readBuffer;    // Clean up the read buffer

        // Check for parse errors
        if (doc.HasParseError()) {
            cerr << "Error parsing JSON: " << doc.GetParseError() << endl;
            exit(EXIT_FAILURE);
        }
        if (!doc.IsArray()) {
            cerr << "JSON is not an array" << endl;
            exit(EXIT_FAILURE);
        }

        // Extract strings from JSON array
        vector<string> stringList;
        for (const auto& value : doc.GetArray()) {
            if (value.IsString()) {
                stringList.push_back(value.GetString());
            } else {
                cerr << "Non-string element in array" << endl;
                exit(EXIT_FAILURE);
            }
        }

        return stringList;
    }
}
