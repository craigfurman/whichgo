GOGO_HOME=~/.gogo
mkdir -p $GOGO_HOME
GOOGLE_GO_REPO=https://go.googlesource.com/go

gogo() {
  if [ -z "$1" ]; then
    echo "TODO usage message"
    return 0
  fi

  subcommand=$1
  shift

  case $subcommand in
    list)
      gogo_list "$1"
      ;;

    install)
      gogo_install "$1"
      ;;

    use)
      ;;

    *)
      echo "invalid subcommand $subcommand" >&2
      return 1
  esac
}

gogo_list() {
  if [ -n "$1" ]; then
    if [ "$1" != "--all" ]; then
      echo "usage: gogo list [--all]" >&2
      return 1
    fi

    git ls-remote -t $GOOGLE_GO_REPO | grep refs/tags/go | awk -F/ '{ print $NF }'
    return 0
  fi

  ls $GOGO_HOME
}

gogo_install() {
  if [ -z "$1" ]; then
    echo "usage: gogo install go1.4.3" >&2
    return 1
  fi

  local version="$1"
  shift

  pushd $GOGO_HOME
  git clone $GOOGLE_GO_REPO $version
  pushd $GOGO_HOME/$version
  git checkout $version
  pushd src
  ./make.bash
  popd
  popd
  popd
}
