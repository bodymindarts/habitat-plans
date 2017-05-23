pkg_name=cohttp-test
pkg_origin=bodymindarts
pkg_version="0.1.0"
pkg_maintainer="Vincent Bernardoff <vb@luminar.eu.org>"
pkg_license=('ISC')
pkg_source=nofile.tgz
pkg_shasum="NOTHING"
pkg_deps=(core/glibc core/libev)
pkg_build_deps=(core/make core/gcc core/opam)
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
cohttp-test
do_prepare() {
   mkdir -p "${HAB_CACHE_SRC_PATH}/cohttp-test"
  cp -r ${PLAN_CONTEXT}/src/* "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/"

  opam init --no-setup --root=${HAB_CACHE_SRC_PATH}/opam/${pkg_name}
  eval `opam config env --root=${HAB_CACHE_SRC_PATH}/opam/${pkg_name}`

  CPATH="$(pkg_path_for libev)/include"
  export CPATH
  build_line "Setting CPATH=$CPATH"
  LIBRARY_PATH="$(pkg_path_for libev)/lib"
  export LIBRARY_PATH
  build_line "Setting LIBRARY_PATH=$LIBRARY_PATH"
  # if [[ ! -r /usr/bin/env ]]; then
  #   ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
  # fi
  opam install --yes ocamlfind lwt cohttp
  # ocamlfind ocamlopt -linkpkg cohttp_test.ml
}

do_build() {
  ocamlfind ocamlopt -linkpkg -package cohttp.lwt cohttp_test.ml
}

do_install() {
  cp ./a.out ${pkg_prefix}/bin/cohttp-test
}

do_strip() {
  return 0
}
