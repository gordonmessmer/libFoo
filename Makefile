CC = gcc
CFLAGS = -Wall -fPIC
LDFLAGS = -shared

UNVERSIONED_DIR = lib-unversioned
VERSIONED_DIR = lib-versioned

LIB_NAME = libFoo.so
LIB_SONAME = libFoo.so.1
LIB_REALNAME = libFoo.so.1.0.0

.PHONY: all unversioned versioned bar bar-versioned clean

all: unversioned bar versioned bar-versioned

# Build unversioned library
unversioned: $(UNVERSIONED_DIR)/$(LIB_REALNAME) $(UNVERSIONED_DIR)/$(LIB_SONAME) $(UNVERSIONED_DIR)/$(LIB_NAME)

$(UNVERSIONED_DIR)/$(LIB_REALNAME): foo.c foo.h
	@mkdir -p $(UNVERSIONED_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-soname,$(LIB_SONAME) -o $@ foo.c

$(UNVERSIONED_DIR)/$(LIB_SONAME): $(UNVERSIONED_DIR)/$(LIB_REALNAME)
	ln -sf $(LIB_REALNAME) $@

$(UNVERSIONED_DIR)/$(LIB_NAME): $(UNVERSIONED_DIR)/$(LIB_REALNAME)
	ln -sf $(LIB_REALNAME) $@

# Build Bar program
bar: Bar
	@echo "Bar program built successfully"

Bar: bar.c unversioned
	$(CC) $(CFLAGS) -o Bar bar.c -L$(UNVERSIONED_DIR) -lFoo -Wl,-rpath,$(UNVERSIONED_DIR)

# Build Bar program with versioned library
bar-versioned: Bar-versioned
	@echo "Bar-versioned program built successfully"

Bar-versioned: bar.c versioned
	$(CC) $(CFLAGS) -o Bar-versioned bar.c -L$(VERSIONED_DIR) -lFoo -Wl,-rpath,$(VERSIONED_DIR)

# Build versioned library
versioned: $(VERSIONED_DIR)/$(LIB_REALNAME) $(VERSIONED_DIR)/$(LIB_SONAME) $(VERSIONED_DIR)/$(LIB_NAME)

$(VERSIONED_DIR)/$(LIB_REALNAME): foo.c foo.h libFoo.map
	@mkdir -p $(VERSIONED_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-soname,$(LIB_SONAME) -Wl,--version-script=libFoo.map -o $@ foo.c

$(VERSIONED_DIR)/$(LIB_SONAME): $(VERSIONED_DIR)/$(LIB_REALNAME)
	ln -sf $(LIB_REALNAME) $@

$(VERSIONED_DIR)/$(LIB_NAME): $(VERSIONED_DIR)/$(LIB_REALNAME)
	ln -sf $(LIB_REALNAME) $@

clean:
	rm -rf $(UNVERSIONED_DIR) $(VERSIONED_DIR) Bar Bar-versioned
