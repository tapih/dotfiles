# dotfiles

⚡⚡⚡

## OS

- Ubuntu 20.04
- macOS Big Sur v11.3+

## Install

### Ubuntu 20.04

```sh
# Update /etc/sudoers like "tapih ALL=NOPASSWD: ALL"
sudo visudo

# Use closest mirror
sudo sed -i.org -e "s/\/\/archive\.ubuntu\.com/\/\/jp\.archive\.ubuntu\.com/g" /etc/apt/sources.list
sudo apt-get install -y make

# Register key on GitHub
mkdir -m 700 ~/.ssh && cd ~/.ssh
cat << EOF > config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_rsa
EOF
ssh-keygen -t rsa -b 4096 -f github_rsa

# Clone this repository
mkdir ~/src && cd ~/src
git clone git@github.com:tapih/dotfiles
cd dotfiles
make postinst OS=ubuntu
sudo sh -c "echo /home/linuxbrew/.linuxbrew/bin/zsh >> /etc/shells"
chsh -s /home/linuxbrew/.linuxbrew/bin/zsh

# Exit shell once and run the following
make install OS=ubuntu

# (optional)
make wsl WINDOWS_USER=<your name>
```

Windows Terminal requires to disable `<C-v>` to work with `nvim`.

On Windows side, these tools should be installed manually.

- Chrome
- Mozc(+Swap Ctrl and Caps)
- Enpass
- Windows Terminal
- VcXsrv
- Powershell
- Android Studio
- Slack
- Notion
- Kindle
- Adobe XD
- Zoom
- Git
- Rapid Environment Editor

### macOS

```sh
# Register key on GitHub
mkdir -m 700 ~/.ssh && cd ~/.ssh
cat << EOF > config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_rsa
EOF
ssh-keygen -t rsa -b 4096 -f github_rsa

# Clone this repository
mkdir ~/src && cd ~/src
git clone git@github.com:tapih/dotfiles
cd dotfiles
make postinst OS=darwin

# Exit shell once and run the following command
make install OS=darwin

# After installing Xcode
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
sudo xcodebuild -license
arch -x86_64 sudo gem install ffi
sudo gem install cocoapods
arch -x86_64 open -a /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/
```

Install the following applications.

- Enpass
- Chrome
- Slack
- Notion
- iTerm2
- VSCode
- Xcode
- Android Studio (for flutter)
- Kindle
- Docker
- Alfred
- ShiftIt
- Contexts
- Lens
- CotEditor

Set iTerm2 font as `Nerd Hack Font`.

