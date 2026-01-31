Run `build.sh` in both v1.0 and v1.1 to build four applications and shared libraries:

 * v1.0/Bar: Bar linked to libFoo v1.0 without versioned symbols
 * v1.0/Bar-versioned: Bar linked to libFoo v1.0 with versioned symbols
 * v1.1/Bar: Bar linked to libFoo v1.1 without versioned symbols
 * v1.1/Bar-versioned: Bar linked to libFoo v1.1 with versioned symbols

This is intended to demonstrate three things:

## Adding versioned symbols to a library is a backward compatible change

Each `Bar` is linked to a library without versioned symbols, but can be
run with the library after versioned symbols are added.

```
[root v1.1]# LD_LIBRARY_PATH=./lib-versioned/ ldd ./Bar
	linux-vdso.so.1 (0x00007fa8322de000)
	libFoo.so.1 => ./lib-versioned/libFoo.so.1 (0x00007fa8322d2000)
	libc.so.6 => /lib64/libc.so.6 (0x00007fa8320dc000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fa8322e0000)
[root v1.1]# LD_LIBRARY_PATH=./lib-versioned/ ./Bar
Usage: ./Bar <width> <height> <perimeter|area>
```

## Adding features to the library is a backward compatible change

The version of `Bar` in the v1.0 directory can be used with the libraries
in the v1.1 directory.

```
[root v1.0]# LD_LIBRARY_PATH=../v1.1/lib-versioned/ ldd ./Bar
	linux-vdso.so.1 (0x00007fc06b751000)
	libFoo.so.1 => ../v1.1/lib-versioned/libFoo.so.1 (0x00007fc06b745000)
	libc.so.6 => /lib64/libc.so.6 (0x00007fc06b54f000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fc06b753000)
[root v1.0]# LD_LIBRARY_PATH=../v1.1/lib-versioned/ ./Bar
Usage: ./Bar <width> <height> <perimeter>
```

## Libraries are not forward compatible with new binaries

The reverse of the previous arrangement does not work. The version of
`Bar` in the v1.1 directory cannot be used with the libraries in the
v1.0 directory.

```
[root v1.1]# LD_LIBRARY_PATH=../v1.0/lib-versioned/ ./Bar 5 10 area
./Bar: symbol lookup error: ./Bar: undefined symbol: rectangle_area
```
