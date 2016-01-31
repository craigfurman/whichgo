WHICHGO_HOME=~/.whichgo
mkdir -p $WHICHGO_HOME
GOOGLE_GO_REPO=https://go.googlesource.com/go

whichgo() {
  if [ -z "$1" ]; then
    echo "usage: whichgo list / install / use"
    return 0
  fi

  subcommand=$1
  shift

  case $subcommand in
    list)
      whichgo_list "$1"
      ;;

    install)
      whichgo_install "$1"
      ;;

    use)
      whichgo_use "$1"
      ;;

    *)
      echo "invalid subcommand $subcommand" >&2
      return 1
  esac
}

whichgo_list() {
  if [ -n "$1" ]; then
    if [ "$1" != "--all" ]; then
      echo "usage: whichgo list [--all]" >&2
      return 1
    fi

    git ls-remote -t $GOOGLE_GO_REPO | grep refs/tags/go | awk -F/ '{ print $NF }'
    return 0
  fi

  ls $WHICHGO_HOME
}

whichgo_install() {
  if [ -z "$1" ]; then
    echo "usage: whichgo install go1.4.3" >&2
    return 1
  fi

  local version="$1"
  shift

  pushd $WHICHGO_HOME
  git clone $GOOGLE_GO_REPO $version
  pushd $WHICHGO_HOME/$version
  git checkout $version
  pushd src
  ./make.bash
  popd
  popd
  popd
}

whichgo_use() {
  if [ -z "$1" ]; then
    echo "usage: whichgo use go1.4.3" >&2
    return 1
  fi

  local version="$1"
  shift

  export GOROOT=$WHICHGO_HOME/$version
  export PATH=$GOROOT/bin:$(echo $PATH | tr ':' '\n' | grep -v $WHICHGO_HOME | tr '\n' ':' | sed 's/:*$//')
}
