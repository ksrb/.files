#!/usr/bin/env bash

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

laptop='Laptop'
profiles=('Legacy' 'External Keyboard' "$laptop")

#Export all profiles to individual sh files
export(){
  for profile in "${profiles[@]}"; do
    $cli select_by_name "$profile"
    $cli export "$profile" > "$profile".sh
  done
  $cli select_by_name "$laptop"
}

clean(){
  for profile in "${profiles[@]}"; do
    rm "$profile".sh
  done
}

#Shortcut karabiner cli
cli(){
  $cli "$@"
}

"$@"
