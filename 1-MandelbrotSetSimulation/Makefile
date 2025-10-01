CC = clang
CFLAGS = -I/usr/local/include
LDFLAGS = -L/usr/local/lib -lSDL2
SOURCES = start.c sim.c app.c
TARGET = app

$(TARGET): $(SOURCES)
	$(CC) $(CFLAGS) $(SOURCES) $(LDFLAGS) -o $(TARGET)

clean:
	rm -f $(TARGET)

.PHONY: clean