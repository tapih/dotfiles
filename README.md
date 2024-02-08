# dotfiles

## Windows

#### Store

- Enpass
- PowerToys
- VSCode
- Slack
- Todoist

#### Others

- [Mozc Japanese Input](https://www.google.co.jp/ime/)
- [Notion](https://www.notion.so/desktop/windows)
- [win32yank](https://github.com/equalsraf/win32yank)
- [Hack Nerd Font](https://www.nerdfonts.com/font-downloads) (Extract zip and install via righ click menu)
- [AutoHotKey v2](https://www.autohotkey.com/)

#### Configuration
- [Enable Unicode UTF-8](https://togeonet.co.jp/post-13850).
- [Increase key repeat speed](https://www.pasoble.jp/windows/10/keyboard-sokudo-settei.html).
- Update the Mozc setting to use Ctrl+Space to toggle IME.
- Show accent color on window borders via Personalization > Colors > Show accent color on title bars and windows borders.
- Disable window animation via Settings > Accesibility > Animation effects.
- Register hotkeys for some FancyZone layouts.
- Install WSL2 with `wsl --install`.
- Configure Windows Terminal.
  - Set WSL2 to a default terminal.
  - Use One Half Dark. 
  - Use Hack Nerd Font.
- Download autohotkey.ahk and place it in the startup folder.
- Update the Quick Task hotkey of Todoist to Shift+Alt+K.

## WSL2

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

$ sudo sh -c "cat << EOF > /etc/wsl.conf
[boot]
systemd=true
localhostForwarding=true

[wsl2]
memory=24GB
processors=8

[interop]
appendWindowsPath = true
EOF"

$ sudo dpkg-reconfigure locales
```

Then, install [Docker](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

