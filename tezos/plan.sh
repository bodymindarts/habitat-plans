# pkg_description="Some description."
# pkg_upstream_url="http://example.com/project-name"
pkg_name=tezos
pkg_origin=bodymindarts
pkg_version="0.1.0"
# pkg_license=('Apache-2.0')
pkg_source="https://github.com/tezos/tezos/archive/master.zip"
pkg_shasum="754b96e89b0a0fbcb6c7c80fe127cf01dbf098fc231c17ebc121e46fd372570d"
pkg_dirname="tezos-master"
pkg_deps=(core/libsodium core/openssl core/glibc core/libev core/gmp core/zlib core/git)
pkg_build_deps=(core/coreutils core/diffutils core/opam core/camlp4 core/perl)
pkg_bin_dirs=(bin)

pkg_exports=(
  [net_port]=net_port
  [rpc_port]=rpc_port
)
pkg_exposes=(net_port rpc_port)

do_prepare() {
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

  sed -i'' 's/opam install tezos-deps/opam install --yes tezos-deps/' scripts/install_build_deps.sh
  sed -i'' 's/opam pin add typerex-build/opam pin --yes add typerex-build/' scripts/install_build_deps.sh
  sed -i'' 's/opam pin --yes add --no-action --dev-repo cohttp/opam pin --yes add --no-action cohttp 0.22.0/' scripts/install_build_deps.sh
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
