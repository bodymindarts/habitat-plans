# pkg_description="Some description."
# pkg_upstream_url="http://example.com/project-name"
pkg_name=tezos
pkg_origin=bodymindarts
pkg_version="0.1.0"
# pkg_license=('Apache-2.0')
pkg_source="https://github.com/vbmithr/tezos/archive/alphanet.zip"
pkg_shasum="64724557a2b8069053788852b48e65c529e3afc146dd556cc3d4eb2a0028dc19"
pkg_dirname="tezos-alphanet"
pkg_deps=(core/libsodium bodymindarts/leveldb bodymindarts/snappy core/openssl core/glibc core/libev core/gmp/6.1.0/20170513202112 core/zlib core/gcc-libs)
pkg_build_deps=(core/coreutils core/diffutils bodymindarts/opam core/camlp4 core/perl)
pkg_bin_dirs=(bin)

do_prepare() {
  opam init --no-setup --root=${HAB_CACHE_SRC_PATH}/opam/${pkg_name}
  eval `opam config env --root=${HAB_CACHE_SRC_PATH}/opam/${pkg_name}`

  CPATH="$(pkg_path_for zlib)/include:$(pkg_path_for libev)/include:$(pkg_path_for libsodium)/include:$(pkg_path_for leveldb)/include:$(pkg_path_for snappy)/include"
  export CPATH
  build_line "Setting CPATH=$CPATH"

  LIBRARY_PATH="$(pkg_path_for zlib)/lib:$(pkg_path_for libev)/lib:$(pkg_path_for libsodium)/lib:$(pkg_path_for leveldb)/lib:$(pkg_path_for snappy)/lib"
  export LIBRARY_PATH
  build_line "Setting LIBRARY_PATH=$LIBRARY_PATH"

  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
  fi

  opam install --yes ocamlfind 
  if [[ ! -r $(ocamlfind query -format %d camlp4) ]]; then
    ln -s $(pkg_path_for camlp4)/lib/camlp4 $(ocamlfind query -format %d camlp4)
  fi

  sed -i'' 's/opam install tezos-deps/opam install --yes tezos-deps/' scripts/install_build_deps.sh
  sed -i'' 's/opam pin add typerex-build/opam pin --yes add typerex-build/' scripts/install_build_deps.sh
  sed -i'' '/opam pin --yes add typerex-build/a opam pin --yes add ezjsonm 0.4.3' scripts/install_build_deps.sh
}

do_build() {
  make build-deps
  make
}

do_install() {
  cp ./tezos-{client,node,protocol-compiler} ${pkg_prefix}/bin
}

do_strip() {
  return 0
}
