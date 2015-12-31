set(){
  # Remove mouse acceleration
  defaults write .GlobalPreferences com.apple.mouse.scaling -1
  # Show full path in finder
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
  # Remove hide/show animation
  defaults write com.apple.dock autohide-time-modifier -int 0 && killall Dock
  # Disable dashboard/widgets/F12
  defaults write com.apple.dashboard mcx-disabled -boolean YES && killall Dock
  # Disable window animation
  defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
}

# TODO
reset(){
}

# Add Dock Spacer
ads(){
  defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'; killall Dock
}

"$@"
