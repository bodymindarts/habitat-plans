pkg_name=ocamlbuild
pkg_origin=bodymindarts
pkg_version="0.11.0"
pkg_license=('LGPL')
pkg_source="https://github.com/ocaml/ocamlbuild/archive/${pkg_version}.tar.gz"
# pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="1717edc841c9b98072e410f1b0bc8b84444b4b35ed3b4949ce2bec17c60103ee"
pkg_deps=(core/glibc bodymindarts/ocaml core/make core/gcc)
pkg_bin_dirs=(bin)

do_build() {
  make configure OCAMLBUILD_PREFIX=${pkg_prefix} OCAMLBUILD_BINDIR=${pkg_prefix}/bin OCAMLBUILD_LIBDIR=${pkg_prefix}/lib
  make
}

do_install() {
  make install
}
