# specnext-c-starter
A starter project directory for using Z88DK in Linux (or WSL2).

[Watch my YouTube video on this](https://youtu.be/HyRuLT6Io3I)

# How to use

## Requirements

1. Make sure you have Z88dk installed and working
2. Install the DeZog VS Code extension
3. Get CSpect onto your computer and running

## Edits to make

1. Clone this repo and rename it
2. Edit Makefile
3. Edit workspace.code-workspace
4. Edit .vscode/tasks.json

### Edit Makefile

The only things that you should need to change are

```Makefile
EXEC_OUTPUT=test

SOURCES = test.c

CRT=31
```

`EXEC_OUTPUT` is the name of the resulting `foo.nex` binary produced, without
`.nex` at the end.

`SOURCES` is a list of your source files, either as C files (ending in .c) or
Z80 assembly (ending in .asm).

`CRT=31` changes which CRT is needed. You'll know if you need to change this.

### Edit workspace.code-workspace

Set the name of your resulting `.nex` file (what you put in `EXEC_OUTPUT` above)

```json
"load": "bin/test.nex",
```

To control the red wigglies in VSCode I had to add this line at the bottom,
you'll need to change it appropriately. It doesn't completely fix the wigglies,
but it shuts most of them up.

```json
"C_Cpp.default.includePath": ["${default}", "/home/james/z88dk/include"]
```

### Edit .vscode/tasks.json

These lines will need adjusting to point to where your installation of CSpect is
located **relative to your WSL installation**

```json
"command": "/mnt/f/zxnext/cspect/cspect.exe",
```

```json
"cwd": "/mnt/f/zxnext/cspect"
```

# How to use

If it all worked, typing `make` in the source directory should at least compile
the code for you.

In VSCode, `Ctrl+F5` should attempt to start things up, or at least give a
meaningful error if the `.nex` file is missing.

In VSCode you should also find some new Tasks (under `Terminal->Run Task...` or
the `F6` key) which are

* CSpect - this should launch CSpect
* z88dk - this will build your .nex file and 'install' it in `bin/`
* z88dk-clean - this will delete the `bin/` and `build/` directories, use with care

You should then be able to get into a routine of writing code, pressing F6
to build it, then pressing Ctrl+F5 to execute in the emulator.

The resulting `.nex` file is available in the `build/` directory. If you do
a `make install` it will get moved into a `bin/` directory. A `make install`
is run automatically by the VS Code task.
