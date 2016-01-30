#Dotfiles#

##Description##
Various dotfiles used across Linux, Mac, and Windows

Heavily based off of [bodhi5/.dotfiles](https://github.com/bodhi5/.dotfiles)

##Usage##
A linker script is provided to create symlinks between the dotfiles and the users
home directory e.g.:

```bash
./linker ls #link shared dotfiles
./linker l[m/w] #link windows or mac dotfiles
```

* [Creating NTFS symlinks in cygwin requires running the terminal with elevated privileges](http://stackoverflow.com/questions/18654162/enable-native-ntfs-symbolic-links-for-cygwin#comment38184532_18659632)

###Warning###
The script will first remove conflicting symlinks and add its own

##TODO##
* Linux dotfiles
