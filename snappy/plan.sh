pkg_name=snappy
pkg_origin=bodymindarts
pkg_description="A fast compressor/decompressor"
pkg_upstream_url="https://github.com/google/snappy"
pkg_version="1.1.4"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD 3')
pkg_source="https://github.com/google/snappy/releases/download/${pkg_version}/snappy-${pkg_version}.tar.gz"
pkg_shasum="134bfe122fd25599bb807bb8130e7ba6d9bdb851e0b16efcb83ac4f5d0b70057"
pkg_deps=(core/glibc)
pkg_build_deps=(core/autoconf core/make core/gcc)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_build() {
  autoconf
  ./configure --prefix ${pkg_prefix}
  make
}

do_install() {
  make install
}

