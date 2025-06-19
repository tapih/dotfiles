# dotfiles

## Windows

### Install with winget

- Enpass
- PowerToys
- Slack
- AutoHotKey v2

### Install from GitHub

- [win32yank](https://github.com/equalsraf/win32yank) (Put the binary in C:Tools)
- [PowerToys Edge favorite plugin](https://github.com/davidegiacometti/PowerToys-Run-EdgeFavorite) (Use @)
- [PowerToys Clipboard plugin](https://github.com/CoreyHayward/PowerToys-Run-ClipboardManager)
- [Hack Nerd Font](https://www.nerdfonts.com/font-downloads) (Extract zip and install via righ click menu)

### Taskbar

- Update the bottom panel not to show default icons.

### Input

- Swap ctrl and caps lock with PowerToys.
- [Enable Unicode UTF-8](https://togeonet.co.jp/post-13850).
- [Increase key repeat speed](https://www.pasoble.jp/windows/10/keyboard-sokudo-settei.html).
- Download autohotkey.ahk and place a shortcut it in the startup folder.
- Assign Ctrl+Space to toggling IME on/off.

### Appearance

- Use Dark theme.
- Show accent color on window borders via Personalization > Colors > Show accent color on title bars and windows borders.
- Disable the window animation of the Windows system via Settings > Accesibility > Animation effects.

### WSL

- Install WSL2 with `wsl --install`.
- Windows Terminal
  - Theme: Dark
  - Console: One Half Dark
  - Font: Hack Nerd Font

### Edge

- Make the panel as simple as possible.
- Show only one window when Alt+Tab.

## WSL2

```console
$ sudo apt-get update
$ sudo apt-get install -y curl zsh chromium-browser
$ chsh -s /usr/bin/zsh
$ export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
$ sudo dpkg-reconfigure locales

$ brew install gh
$ gh auth login
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
```

Install Docker with [the official document](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).
