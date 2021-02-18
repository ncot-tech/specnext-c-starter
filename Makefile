# This is the name of your final .nex file without the .nex extension
EXEC_OUTPUT=build/test

# List all your source files here
SOURCES = test.c

# Maybe you'll need to edit this
CRT=31

# You don't need to edit below here, have a nice day.

MKDIR = mkdir -p
CC=zcc
AS=zcc
TARGET=+zxn -subtype=nex
VERBOSITY=-vn
OUT_DIR=build bin
PRAGMA_FILE=zpragma.inc

OBJECTS=$(SOURCES:.*=.o)
OBJS=$(patsubst %, src/%, $(OBJECTS))

C_OPT_FLAGS=-SO3 --max-allocs-per-node200000 --opt-code-size

CFLAGS=$(TARGET) $(VERBOSITY) -c $(C_OPT_FLAGS) -compiler sdcc -clib=sdcc_iy -pragma-include:$(PRAGMA_FILE)
LDFLAGS=$(TARGET) $(VERBOSITY) --list -m -s -clib=sdcc_iy -pragma-include:$(PRAGMA_FILE)
ASFLAGS=$(TARGET) $(VERBOSITY) -c --list -m -s

EXEC=$(EXEC_OUTPUT).nex

%.o: %.c $(PRAGMA_FILE)
	$(CC) $(CFLAGS) -o $@ $<

%.o: %.asm
	$(AS) $(ASFLAGS) -o $@ $<

all : dirs $(EXEC)

$(EXEC) : $(OBJS)
	$(CC) $(LDFLAGS) -startup=$(CRT) $(OBJS) -o $(EXEC_OUTPUT) -create-app

.PHONY: clean dirs install

install: all
	mv $(EXEC) bin

clean:
	rm -rf $(OUT_DIR) /tmp/tmpXX*
	rm -f src/*.lis src/*.sym src/*.o

dirs: $(OUT_DIR)

$(OUT_DIR):
	$(MKDIR) $(OUT_DIR)