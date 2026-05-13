CFLAGS = -Wall -std=gnu99
CPPFLAGS += -Ithird_party/tree-sitter/lib/include \
	    -Ithird_party/tree-sitter-c/src

.PHONY: all clean check

-include config.mak
all: me

TREE_SITTER_RUNTIME = third_party/tree-sitter/lib/src/lib.c
TREE_SITTER_C_PARSER = third_party/tree-sitter-c/src/parser.c

me: me.c $(TREE_SITTER_RUNTIME) $(TREE_SITTER_C_PARSER)
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ me.c \
		$(TREE_SITTER_RUNTIME) $(TREE_SITTER_C_PARSER) $(LDFLAGS)

check: me
	@tests/runner.sh

clean:
	$(RM) me
	$(RM) -rf tests/test_tmp
	$(RM) -f tests/*.txt tests/*.log
