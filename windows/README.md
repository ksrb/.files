# Windows

## Cygwin
* Install
  * ncures - for [clear](http://stackoverflow.com/a/11249071)
  * python - Ultisnips dependency
  * curl
  * git
  * vim
  * emacs
  * make - git-extras dependency
  * tmux

## Zsh
* [Set as default shell](https://cygwin.com/cygwin-ug-net/ntsec.html#ntsec-mapping-nsswitch)
  * /etc/nsswitch.conf << echo "db_shell: /bin/zsh"
* Set user folder as root
  * /etc/nsswitch.conf << echo "db_home: windows"


## [git-extras](https://github.com/tj/git-extras)
* Install make

## Vim
* Cygwin
  * Some plugins fail to work because of cygwin will send incorrect paths to
    windows programs and vice versa
    * [vim-easytags](https://github.com/xolox/vim-easytags)
    * [tern_for_vim](https://github.com/ternjs/tern_for_vim)
  * Plugins that work with some hacks
    * [vim-plug](https://github.com/junegunn/vim-plug)
      * PlugInstall works however PlugUpdate doesn't simply remove the
        ~/.vim/plugged folder and rerun PlugInstall
          ```bash
          rm -r ~/.vimrc/plugged
          vim -c PlugInstall
          ```
  * [tagbar](https://github.com/majutsushi/tagbar)
    * [From Windows cmd run](https://github.com/majutsushi/tagbar/issues/260#issuecomment-135898610)
        ```bash
        mklink /j c:\tmp c:\cygwin64\tmp
        ```

## GVim
* [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
  * Compile via cmd
  * Can be compiled and work on windows using the instruction in the
    [README](https://github.com/Valloric/YouCompleteMe#windows-installation)
  * Python 2.7.9 is
    [suggested](http://stackoverflow.com/questions/32025090/vim-for-windows-python-doesnt-load-properly-crashes)
  * Remove cygwin64/bin from the path
      ```cmd
      set path=%path:C:\cygwin64\bin;=%
      ```

## Git
* Committing shows
    ```bash
    Vim: Warning: Output is not to a terminal
    Vim: Warning: Input is not from a terminal
    ```
* Set path to cygwin git as the first path in PATH (see zshrc.oss)

### Gitk and Git Gui
* Gitk and Git Gui needs a X11 server to render
  * Options 1 - install cygwin X11 packages and server see this [link](http://stackoverflow.com/questions/9393462/cannot-launch-git-gui-using-cygwin-on-windows/9418800#9418800)
  * Options 2 - use [MsysGit](https://git-for-windows.github.io/)
* Gitk showing incorrect diff
  * Set MsysGit as the first path in PATH (see zshrc.oss)

## Docker
* Cannot enable tty mode on non tty input
  * [ssh into docker-machine](https://github.com/docker/docker/issues/12469#issuecomment-138426213)
      ```bash
      docker-machine ssh default
      ```
* Docker machine not failing to create machine
  * Uninstall virtualbox and remove ~/.VirtualBox folder and then reinstall

## [Node-gyp](https://github.com/nodejs/node-gyp)
Node-gyp is a native build tool but has a extensive installation process for windows:
* Install dependencies that require node-gyp using cmd
* Remove cygwin64/bin from windows environment variables
* Install python 2.7 from [online](https://www.python.org/downloads/)
* Install [Microsoft Visual C++ Build Tools 2015 Technical Preview](http://www.microsoft.com/en-us/download/details.aspx?id=49983)
* npm config set msvs_version 2015 --global
* npm config set python python2.7
* Additional information [here](https://github.com/nodejs/node-gyp/issues/629#issuecomment-153196245)
