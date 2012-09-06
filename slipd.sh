# -*- sh -*-

slipd() {
  if [ $# -eq 0 ]; then
    cd ..
    return 0
  elif [ "$1" = "--complete" ]; then
    shift
    _slipd_complete $* && return 0
    return 1
  fi

  local signal=$1
  local dir

  if [ -n "$signal" ]; then
    dir=$(_slipd_complete --absolute "$signal")
    if [ -z "$dir" ]; then
      echo "$0: no matchs for upper directory: $signal"
      return 1
    fi

    cd $dir
    return 0
  fi

  echo "$0: invalid argument $signal" 1>&2
  return 1
}

_slipd_complete () {
  local ABSOLUTE

  while [ "$#" != "0" ]; do
    if [ "$1" = "--absolute" ]; then
      ABSOLUTE=t; shift
    else
      break
    fi
  done

  if [ $# -eq 0 ]; then
    echo "$0: operand not given." 1>&2
    return 1
  fi

  local signal=$1; shift
  local suffix

  if [ -z "$signal" ]; then
    return 0
  fi

  case $PWD in
    $HOME*/$signal*/*)
      suffix=${PWD#$HOME*/$signal*/}
      if [ -z "$ABSOLUTE" ]; then
        echo $(basename ${PWD%%/$suffix})
      else
        echo ${PWD%%/$suffix}
      fi

      return 0;;
    */$signal*/*)
      suffix=${PWD#*/$signal*/}
      if [ -z "$ABSOLUTE" ]; then
        echo $(basename ${PWD%%/$suffix})
      else
        echo ${PWD%%/$suffix}
      fi

      return 0
  esac
}

_slipd_enumerate () {

  local ABSOLUTE

  while [ "$#" != "0" ]; do
    if [ "$1" = "--absolute" ]; then
      ABSOLUTE=t; shift
    else
      break
    fi
  done

  local paths prefix suffix
  paths=${PWD##$HOME}
  prefix=${PWD%%$paths}
  suffix=${paths##*/}
  paths=${paths%/$suffix}
  while [ -n "$paths" ]; do
    suffix=${paths##*/}
    paths=${paths%/$suffix}
    if [ -z "$ABSOLUTE" ]; then
      echo "$suffix"
    else
      echo "$prefix$paths/$suffix"
    fi
  done
}
