# Shared

## IntelliJ
* [Terminal](https://www.jetbrains.com/help/idea/2016.3/terminal.html)
  * Running tmux with zsh in IntelliJ will fail to source the ~/.zshrc file.
    IntelliJ has a default .zshrc file that is sourced first in /Applications/IntelliJ IDEA.app/Contents/plugins/terminal/ this file then sources ~/.zshrc however the sourcing of IntelliJ .zshrc file fails within tmux.
    To fix this one can stop IntelliJ from sourcing it's own .zshrc file by disabling Terminal → Tool → Terminal → Shell Integration
* vmoptions
  * Set following the advice of [article](http://tomaszdziurko.com/2015/11/1-and-the-only-one-to-customize-intellij-idea-memory-settings/)
* Plugins
  * BashSupport
  * CpuUsageIndicator
  * Docker-plugin
  * IdeaVim
  * Kotlin
  * WrapToColumn
  * fileWatcher
  * idea-multimarkdown
  * intellij-go
  * intellij-makefile
  * protobuf-jetbrains-plugin
  * relative-line-numbers.jar
  * shortcuttranslator.jar
### Ideavim
  * vim-surround emulation is available through [CI server](https://teamcity.jetbrains.com/viewType.html?buildTypeId=IdeaVim_Build&guest=1) → Artifacts → Any build above #312
