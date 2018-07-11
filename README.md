# Dotfiles

## Description
Various dotfiles used across Linux, Mac, and Windows

## Installation
### Windows
```bash
cd ~
git clone https://github.com/ksrb/.files
cd .files
./linker ls
./linker lw
```
### Mac
```bash
cd ~
git clone https://github.com/ksrb/.files
cd .files
./linker ls
./linker lm
```

## Linker script
Provided to create symlinks between the dotfiles and the users home directory e.g.:
```bash
./linker ls #link shared dotfiles
./linker l[m/w] #link windows or mac dotfiles
```

* [Creating NTFS symlinks in cygwin requires running the terminal with elevated privileges](http://stackoverflow.com/questions/18654162/enable-native-ntfs-symbolic-links-for-cygwin#comment38184532_18659632)

## Warning
The script will first remove conflicting symlinks and add its own

## TODO
- [ ] Linux dotfiles
