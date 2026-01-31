# Bar is built with an invalid rpath for demo purposes. Disable rpath check:
%global __brp_check_rpaths %{nil}
%global debug_package %{nil}

Name:           libFoo
Version:        1.1
Release:        %autorelease
Summary:        A simple library
License:        MIT
Source0:        %{name}-%{version}.tar.gz

BuildRequires: gcc
BuildRequires: make

%description
A simple example spec file for Fedora.

%prep
%setup -q

%build
%make_build

%install
%make_install PREFIX=%{_prefix} LIBDIR=%{_libdir}

%check

%files
%{_bindir}/Bar
%{_includedir}/foo.h
%{_libdir}/libFoo.so
%{_libdir}/libFoo.so.1
%{_libdir}/libFoo.so.1.1.0

%changelog
%autochangelog
