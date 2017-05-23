pkg_name=debug
pkg_origin=bodymindarts
pkg_version="0.1.0"
pkg_source=nofile.tgz
pkg_shasum="TODO"
pkg_deps=(core/libsodium core/openssl core/glibc core/libev core/gmp core/zlib core/git)
pkg_build_deps=(core/coreutils core/diffutils core/opam core/camlp4 core/perl)
pkg_bin_dirs=(bin)

do_download() {
  return 0
}
do_verify() {
  return 0
}
do_unpack() {
  return 0
}

do_prepare() {
  mkdir ${HAB_CACHE_SRC_PATH}/debug
  cp src/* ${HAB_CACHE_SRC_PATH}/debug

  opam init --no-setup --root=${HAB_CACHE_SRC_PATH}/opam
  eval `opam config env --root=${HAB_CACHE_SRC_PATH}/opam`

  CPATH="$(pkg_path_for zlib)/include:$(pkg_path_for libev)/include:$(pkg_path_for libsodium)/include"
  export CPATH
  build_line "Setting CPATH=$CPATH"

  LIBRARY_PATH="$(pkg_path_for zlib)/lib:$(pkg_path_for libev)/lib:$(pkg_path_for libsodium)/lib"
  export LIBRARY_PATH
  build_line "Setting LIBRARY_PATH=$LIBRARY_PATH"

  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
  fi

  opam install --yes ocamlfind
  if [[ ! -r $(ocamlfind query -format %d camlp4) ]]; then
    ln -s $(pkg_path_for camlp4)/lib/camlp4 $(ocamlfind query -format %d camlp4)
  fi
}

do_build() {
  do_default_build
}

do_install() {
  cp ./tezos-{client,node,protocol-compiler} ${pkg_prefix}/bin
}

do_strip() {
  return 0
}

