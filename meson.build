project('libFoo', 'c', version: '1.1.0')

# Solaris 11.4 ld supports --version-script only when you also specify
# -z gnu-version-script-compat
if meson.get_compiler('c').get_linker_id() == 'ld.solaris'
  add_project_link_arguments('-Wl,-z,gnu-version-script-compat', language: 'c')
endif

# Version script map file
mapfile = 'libFoo.map'
vflag = '-Wl,--version-script,@0@/@1@'.format(meson.current_source_dir(), mapfile)

# Build shared library with version info
libFoo = shared_library('Foo',
  'foo.c',
  version: '1.1.0',
  soversion: '1',
  link_args: vflag,
  link_depends: mapfile,
  install: true
)
