pkg_name=clasp
pkg_origin=bodymindarts
pkg_description="Answer set solver for (extended) normal logic programs"
pkg_upstream_url="https://potassco.sourceforge.io/"
pkg_version="3.2.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
# pkg_license=('Apache-2.0')
pkg_source="https://downloads.sourceforge.net/project/potassco/clasp/${pkg_version}/clasp-${pkg_version}-source.tar.gz"
# pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="eafb050408b586d561cd828aec331b4d3b92ea7a26d249a02c4f39b1675f4e68"
pkg_deps=(core/glibc)
pkg_build_deps=(core/cmake core/make core/gcc)
pkg_bin_dirs=(bin)

do_build() {
  ./configure.sh --config=release --prefix="${PREFIX}"
}

do_install() {
  make -C build/release install
}

