# Mazu Editor

Mazu Editor is a minimalist text editor with syntax highlight, copy/paste, and search.

## Usage

Command line: (`filename` is optional)
* me `<filename>`

Supported keys:
* Ctrl-S: Save
* Ctrl-Q: Quit
* Ctrl-Z: Undo
* Ctrl-R: Redo
* Ctrl-F: Find string in file
    - ESC to cancel search, Enter to exit search, arrows to navigate
* Ctrl-N: Toggle line numbers display
* Ctrl-O: Open file browser
    - Arrow keys to navigate files and directories
    - Enter to open file or enter directory
    - ESC or Ctrl-Q to cancel
* Ctrl-X: Start/stop text marking (selection mode)
    - Move cursor to select text while marking
    - ESC to cancel selection
* Ctrl-C: Copy marked text (or current line if no selection)
* Ctrl-K: Cut marked text (or cut from cursor to end of line)
* Ctrl-V: Paste copied/cut text
* PageUp, PageDown: Scroll up/down
* Up/Down/Left/Right: Move cursor
* Home/End: move cursor to the beginning/end of editing line

Mazu Editor uses fairly standard VT100 (and similar terminals) escape sequences.
It does not require any external system libraries (not even curses).

## Tree-sitter syntax highlighting

C/C++ highlighting now uses a vendored Tree-sitter parser/runtime
(`tree-sitter` v0.25.10 and `tree-sitter-c` v0.24.1):

* `third_party/tree-sitter/lib/include/tree_sitter/api.h`
* `third_party/tree-sitter/lib/src/*` (Tree-sitter C runtime, built via `lib.c`)
* `third_party/tree-sitter-c/src/parser.c`
* `third_party/tree-sitter-c/src/tree_sitter/parser.h`
* `third_party/tree-sitter-c/queries/highlights.scm` (upstream query source)

These files are copied into this repository so a normal `make` build works
without downloading dependencies.

To add another language in the future:

1. Vendor that language's generated `src/parser.c` (+ `src/scanner.c` if present)
   and `src/tree_sitter/parser.h`.
2. Vendor/update a highlights query for that language (for example
   `queries/highlights.scm`).
3. Add a new syntax DB entry in `me.c` with file extensions, language function,
   and highlight query string.
4. Extend `syntax_capture_to_highlight()` in `me.c` if the new query uses capture
   names not currently mapped.
5. Update `Makefile` to compile the new parser source file(s).

## Acknowledge

Mazu Editor was inspired by excellent tutorial [Build Your Own Text Editor](https://viewsourcecode.org/snaptoken/kilo/).

## License

Mazu Editor is freely redistributable under the BSD 2 clause license. Use of
this source code is governed by a BSD-style license that can be found in the
LICENSE file.
