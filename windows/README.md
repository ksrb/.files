#Windows

##Cygwin
* Install
	* ncures - for [clear](http://stackoverflow.com/a/11249071)
	* python - Ultisnips dependency
	* curl
	* git - git msys has problems
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
