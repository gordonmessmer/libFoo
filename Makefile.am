lib_LTLIBRARIES = libFoo.la

libFoo_la_SOURCES = foo.c foo.h

# Set library version info: current:revision:age
# This produces libFoo.so.1.1.0 with SONAME libFoo.so.1
libFoo_la_LDFLAGS = -version-info 2:0:1

# Add version script if the linker supports it
if HAVE_LD_VERSION_SCRIPT
libFoo_la_LDFLAGS += -Wl,--version-script=$(srcdir)/libFoo.map
endif
