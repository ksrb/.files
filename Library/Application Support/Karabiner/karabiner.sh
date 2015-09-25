#!/usr/bin/env bash

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

laptop='Laptop'
profiles=('Legacy' 'External Keyboard' "$laptop")

#Export all profiles to individual sh files
export(){
  echo 'Exporting:'
  for profile in "${profiles[@]}"; do
    echo "$profile"
    $cli select_by_name "$profile"
    $cli export "$profile" > "$profile".sh
  done
  $cli select_by_name "$laptop"
}

clean(){
  echo 'Removing:'
  for profile in "${profiles[@]}"; do
    echo "$profile"
    rm "$profile".sh
  done
}

#Shortcut karabiner cli
cli(){
  $cli "$@"
}

#Process commands
process(){
  case "$@" in
    "export" )
      export;;
    "clean" )
      clean;;
    "-h" )
      echo "exports - ${profiles[@]} profiles changes active profile to $laptop"
      echo "clean - remove ${profiles[@]} profiles"
      echo "other commands are sent to karabiner cli see:"
      echo "(https://pqrs.org/osx/karabiner/document.html.en#commandlineinterface)";;
    "*" )
      $cli "$@";;
  esac
}

process "$@"
