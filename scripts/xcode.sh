#! /bin/sh

sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
sudo xcodebuild -license
arch -x86_64 sudo gem install ffi
sudo gem install cocoapods
arch -x86_64 open -a /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/

