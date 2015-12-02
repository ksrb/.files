#Windows

##Cygwin
* Install
	* ncures - for [clear](http://stackoverflow.com/a/11249071)
	* python - Ultisnips dependency
	* curl
	* git - [msysgit](https://git-for-windows.github.io/) has some  compatibility issues cygwin
	* vim
	* emacs
	* make - git-extras dependency
	* tmux

###Zsh
* [Set as default shell](https://cygwin.com/cygwin-ug-net/ntsec.html#ntsec-mapping-nsswitch)
	* /etc/nsswitch.conf << echo "db_shell: /bin/zsh"
* Set user folder as root
	* /etc/nsswitch.conf << echo "db_home: windows"


###[git-extras](https://github.com/tj/git-extras)
* Install make

###Vim
* Some plugins fail to work because of cygwin will send incorrect paths to windows programs and vice versa
	* [vim-easytags](https://github.com/xolox/vim-easytags)
	* [tern_for_vim](https://github.com/ternjs/tern_for_vim)
* Plugins that work with some hacks
	* [tagbar](https://github.com/majutsushi/tagbar) 
		* [From Windows cmd run](https://github.com/majutsushi/tagbar/issues/260#issuecomment-135898610)
```cmd
mklink /j c:\tmp c:\cygwin64\tmp
```

###Docker
* Cannot enable tty mode on non tty input
	* [ssh into docker-machine](https://github.com/docker/docker/issues/12469#issuecomment-138426213)
```bash
docker-machine ssh default
```
* Docker machine not failing to create machine
	* Uninstall virtualbox and remove ~/.VirtualBox folder reinstall
