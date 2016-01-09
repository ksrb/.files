#Windows

##Cygwin
* Install
	* ncures - for [clear](http://stackoverflow.com/a/11249071)
	* python - Ultisnips dependency
	* curl
	* git - [msysgit](https://git-for-windows.github.io/) has some compatibility issues cygwin
	* vim
	* emacs
	* make - git-extras dependency
	* tmux

##Zsh
* [Set as default shell](https://cygwin.com/cygwin-ug-net/ntsec.html#ntsec-mapping-nsswitch)
	* /etc/nsswitch.conf << echo "db_shell: /bin/zsh"
* Set user folder as root
	* /etc/nsswitch.conf << echo "db_home: windows"


##[git-extras](https://github.com/tj/git-extras)
* Install make

##Vim
* Some plugins fail to work because of cygwin will send incorrect paths to windows programs and vice versa
	* [vim-easytags](https://github.com/xolox/vim-easytags)
	* [tern_for_vim](https://github.com/ternjs/tern_for_vim)
* Plugins that work with some hacks
	* [vim-plug](https://github.com/junegunn/vim-plug)
		* PlugInstall works however PlugUpdate doesn't simply remove the ~/.vim/plugged folder and rerun PlugInstall
```
	rm -r ~/.vimr/plugged
	vim -c PlugInstall
```
	* [tagbar](https://github.com/majutsushi/tagbar) 
		* [From Windows cmd run](https://github.com/majutsushi/tagbar/issues/260#issuecomment-135898610)
```cmd
mklink /j c:\tmp c:\cygwin64\tmp
```

##Docker
* Cannot enable tty mode on non tty input
	* [ssh into docker-machine](https://github.com/docker/docker/issues/12469#issuecomment-138426213)
```bash
docker-machine ssh default
```
* Docker machine not failing to create machine
	* Uninstall virtualbox and remove ~/.VirtualBox folder and then reinstall

##Node-gyp
* Install python 2.7 from [online](https://www.python.org/downloads/)
* Install [Microsoft Visual C++ Build Tools 2015 Technical Preview](http://www.microsoft.com/en-us/download/details.aspx?id=49983)
* npm config set msvs_version 2015 --global
* npm config set python python2.7
* Remove cygwin64/bin from windows environment variables
* Additional information [here](https://github.com/nodejs/node-gyp/issues/629#issuecomment-153196245)
