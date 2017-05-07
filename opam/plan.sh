pkg_name=opam
pkg_origin=bodymindarts
pkg_version="1.2.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="https://github.com/ocaml/opam/releases/download/${pkg_version}/opam-full-${pkg_version}.tar.gz"
# pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="15e617179251041f4bf3910257bbb8398db987d863dd3cfc288bdd958de58f00"
pkg_dirname="opam-full-${pkg_version}"
pkg_deps=(core/diffutils core/glibc core/which core/pkg-config core/m4 core/rsync core/git core/gcc core/patch core/make bodymindarts/ocaml bodymindarts/ocamlbuild bodymindarts/camlp4)
pkg_bin_dirs=(bin)

do_build() {
  ./configure --prefix ${pkg_prefix}
  make lib-ext
  make
}
do_install() {
  make install
}

do_strip() {
  return 0
}
