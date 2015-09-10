#!/usr/bin/env bash

keysFile=~/Library/Preferences/org.pqrs.Karabiner.plist
axFile=~/Library/Preferences/org.pqrs.Karabiner-AXNotifier.plist

convert(){
  if [ "$1" = "xml1" ]; then
    case "$2" in
      "keys" )
        plutil -convert "$1" "$keysFile" -o "$keysFile".xml;;
      "ax" )
        plutil -convert "$1" "$axFile" -o "$axFile".xml;;
      * )
        plutil -convert "$1" "$2" -o "$2".xml;;
    esac
  elif [ "$1" = "binary1" ]; then
    case "$2" in
      "keys" )
        plutil -convert "$1" "$keysFile".xml -o "$keysFile";;
      "ax" )
        plutil -convert "$1" "$axFile".xml -o "$axFile";;
      * )
        plutil -convert "$1" "$2".xml -o "$2";;
    esac
  fi
}

toXML(){
  convert "xml1" "$1"
} 

toBin(){
  convert "binary1" "$1"
}

"$@"
