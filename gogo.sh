GOGO_HOME=~/.gogo
mkdir -p $GOGO_HOME

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
      gogo_install
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

    git ls-remote -t https://go.googlesource.com/go | grep refs/tags/go | awk -F/ '{ print $NF }'
    return 0
  fi

  ls $GOGO_HOME
}

gogo_install() {
  return 1
}
