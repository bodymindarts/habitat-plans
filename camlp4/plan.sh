pkg_name=camlp4
pkg_origin=bodymindarts

# Required.
# Sets the version of the package.
pkg_version="4.04"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="https://github.com/ocaml/camlp4/archive/${pkg_version}+1.tar.gz"
# pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_dirname="${pkg_name}-${pkg_version}-1"
pkg_shasum="6044f24a44053684d1260f19387e59359f59b0605cdbf7295e1de42783e48ff1"
pkg_deps=(core/glibc)
pkg_build_deps=(core/which bodymindarts/ocamlbuild bodymindarts/ocaml core/make core/gcc)
pkg_bin_dirs=(bin)

do_build() {
  ./configure --bindir=${pkg_prefix}/bin --libdir=${pkg_prefix}/lib --pkgdir=${pkg_prefix}
  make all
}

do_install() {
  make install
}

do_strip() {
  return 0
}
