# dotfiles

⚡⚡⚡

## Install

### On Windows side

Install
- Mozc(+Swap Ctrl and Caps)
- VSCode
- Enpass
- Slack
- Notion
- PowerToys
- [win32yank](https://github.com/equalsraf/win32yank)
- [FiraCode NF](https://www.nerdfonts.com/font-downloads)

Configure
- Enable [Unicode UTF-8](https://togeonet.co.jp/post-13850).
- Show accent color on window borders.
- [Increase key repeat speed](https://www.pasoble.jp/windows/10/keyboard-sokudo-settei.html).
- Register hotkeys for some FancyZone layouts.
- Disable window animation.

### On WSL2 side

```sh
$ sudo apt-get update
$ sudo apt-get install -y curl zsh
$ chsh -s /usr/bin/zsh
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
$ export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin

$ mkdir -p -m 700 ~/.ssh
$ cat << EOF > ~/.ssh/config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_rsa
EOF
$ ssh-keygen -t ed25519 -P "" -f ~/.ssh/github_rsa
$ mkdir -p ~/src/github.com/tapih && cd $_
$ git clone https://github.com/tapih/dotfiles
$ cd dotfiles
$ ./install.sh
$ sudo ln -s $(which MicrosoftEdge.exe) /usr/local/bin/xdg-open

$ sudo sh -c "cat << EOF > /etc/wsl.conf
[boot]
systemd=true
localhostForwarding=true

[wsl2]
memory=24GB
processors=8
EOF"
```

Then, install [Docker](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

