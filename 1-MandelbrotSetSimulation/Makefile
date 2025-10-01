CC = clang

SRC_DIR = src
SOURCES = $(wildcard $(SRC_DIR)/*.c)

IR_DIR = llvm-IR
IR_FILES = $(patsubst $(SRC_DIR)/%.c, $(IR_DIR)/%.ll, $(SOURCES))
TARGET = app

IR_FLAGS = -emit-llvm -S
OPT_FLAGS = -O1
CFLAGS = -I/usr/local/include
LDFLAGS = -L/usr/local/lib -lSDL2
SHELL_FLAGS = $(shell pkg-config --cflags sdl2)

all: $(TARGET) llvm-ir

$(TARGET): $(SOURCES)
	$(CC) $(CFLAGS) $(SOURCES) $(LDFLAGS) -o $(TARGET)

llvm-ir: $(IR_DIR) $(IR_FILES)
	@echo "LLVM IR файлы созданы в папке $(IR_DIR)/"

$(IR_DIR):
	@mkdir -p $(IR_DIR)

$(IR_DIR)/%.ll: $(SRC_DIR)/%.c
	$(CC) $< $(IR_FLAGS) $(OPT_FLAGS) -o $@ $(SHELL_FLAGS)

clean:
	rm -rf $(IR_DIR)
	rm $(TARGET)

setup:
	mkdir -p $(IR_DIR)

.PHONY: all llvm-ir clean setup