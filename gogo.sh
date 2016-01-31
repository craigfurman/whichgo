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
      gogo_list
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
  ls $GOGO_HOME
}

gogo_install() {
  return 1
}
