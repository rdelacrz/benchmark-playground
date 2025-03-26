# Compiler and flags
CC = clang
CFLAGS = -Iinclude -Os -march=native

# Directories
INCLUDE_DIR = include
SRC_DIR = src
BUILD_DIR = build
OBJ_DIR = $(BUILD_DIR)/obj
BIN_DIR = $(BUILD_DIR)/bin

# Source files
SRC_FILES = $(wildcard $(SRC_DIR)/*/*.c) $(SRC_DIR)/main.c
$(info    SRC_FILES are $(SRC_FILES))

# Object files
OBJ_FILES = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC_FILES))
$(info    OBJ_FILES are $(OBJ_FILES))

# Dependency files
DEP_FILES = $(wildcard $(INCLUDE_DIR)/*.h)
$(info    DEP_FILES are $(DEP_FILES))

# Executable name
TARGET = $(BIN_DIR)/main

# Default target
all: $(TARGET)

# Rule to link the final executable
$(TARGET): $(OBJ_FILES)
	$(CC) -o $@ $^ $(CFLAGS)

# Rule to compile source files into object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(DEP_FILES)
	@mkdir -p $(dir $@)
	$(CC) -c -o $@ $< $(CFLAGS)

# Clean up build artifacts
.PHONY: clean
clean:
	rm -rf $(OBJ_DIR)/**/*.o $(TARGET)

# Phony target for building everything
.PHONY: all