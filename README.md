# dotfiles

⚡⚡⚡

## OS

- Ubuntu 20.04
- macOS Big Sur v11.3+

## Install

### Ubuntu 20.04

```sh
sudo visudo
# tapih ALL=NOPASSWD: ALL

# Use mirror in Japan if you are in Japan
sudo sed -i.org -e "s/\/\/archive\.ubuntu\.com/\/\/jp\.archive\.ubuntu\.com/g" /etc/apt/sources.list
sudo apt-get install -y make

mkdir -m 700 ~/.ssh && cd ~/.ssh
cat << EOF > config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_rsa
EOF
# register the generated public key to GitHub
ssh-keygen -t rsa -b 4096 -f github_rsa

mkdir ~/src && cd ~/src
git clone git@github.com:tapih/dotfiles
cd dotfiles
make postinst OS=ubuntu
sudo sh -c "echo /home/linuxbrew/.linuxbrew/bin/zsh >> /etc/shells"
chsh -s /home/linuxbrew/.linuxbrew/bin/zsh
# exit shell once

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
mkdir -m 700 ~/.ssh && cd ~/.ssh
cat << EOF > config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_rsa
EOF
# register the generated public key to GitHub
ssh-keygen -t rsa -b 4096 -f github_rsa

mkdir ~/src && cd ~/src
git clone git@github.com:tapih/dotfiles
cd dotfiles
make postinst OS=darwin
# exit shell once

make install OS=darwin

# after installing Xcode
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
sudo xcodebuild -license
arch -x86_64 sudo gem install ffi
sudo gem install cocoapods
arch -x86_64 open -a /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/
```

Install the following applications manually. These may be installed with cask, but
not tried yet.

- Enpass
- Chrome
- Slack
- Notion
- Xcode
- iTerm2
- Android Studio
- Kindle
- Docker
- Alfred
- ShiftIt
- Contexts

Set `Nerd Hack Font` to iTerm2.

