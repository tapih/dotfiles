# dotfiles

## Windows

#### Install with winget

- Enpass
- PowerToys
- VSCode
- Slack
- Mozc Japanese Input
- Notion
- AutoHotKey v2
- Everything

#### Install from GitHub

- [win32yank](https://github.com/equalsraf/win32yank) (Put the binary in C:Tools)
- [PowerToys Everything plugin](https://github.com/lin-ycv/EverythingPowerToys)
- [PowerToys Edge favorite plugin](https://github.com/davidegiacometti/PowerToys-Run-EdgeFavorite) (Use @@)
- [PowerToys Clipboard plugin](https://github.com/CoreyHayward/PowerToys-Run-ClipboardManager)
- [Hack Nerd Font](https://www.nerdfonts.com/font-downloads) (Extract zip and install via righ click menu)

#### Taskbar

- Update Taskbar not to show default icons.
- Hide automatically.
- Use the Dark theme.

#### Input

- Swap ctrl and caps lock with PowerToys.
- [Enable Unicode UTF-8](https://togeonet.co.jp/post-13850).
- [Increase key repeat speed](https://www.pasoble.jp/windows/10/keyboard-sokudo-settei.html).
- Update the setting of Mozc to use Ctrl+Space to toggle IME.
- Download autohotkey.ahk and place it in the startup folder.

#### Appearance

- Show accent color on window borders via Personalization > Colors > Show accent color on title bars and windows borders.
- Disable the window animation of the Windows system via Settings > Accesibility > Animation effects.

### WSL

- Install WSL2 with `wsl --install`.
- Windows Terminal
  - Theme: Dark
  - Console: Use One Half Dark
  - Font: Hack Nerd Font

### Edge

- Make the panel as simple as possible.
- Search Engine: DuckDuckGo
  - Center Alignment: on

## WSL2

### Settings for Ubuntu

```console
$ sudo apt-get update
$ sudo apt-get install -y curl zsh
$ chsh -s /usr/bin/zsh
$ export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

$ sudo dpkg-reconfigure locales
```

### Settings for GitHub

```console
$ mkdir -p -m 700 ~/.ssh
$ cat << EOF > ~/.ssh/config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github
EOF
$ ssh-keygen -t ed25519 -P "" -f ~/.ssh/github
$ gpg --quick-gen-key "Hiroshi Muraoka <h.muraoka714@gmail.com>" ed25519 default 0
$ KEY_ID=$(gpg -k | grep -oE "[0-9A-F]{40}")
$ cat << EOF > ~/.gitconfig.local
[commit]
  gpgsign = true

[user]
  signingkey = ${KEY_ID}
EOF
```

Then, register both the ssh pub key and gpg pub key to [GitHub](https://github.com/settings/keys).

Finally, run the install script.

```Console
$ mkdir -p ~/src/github.com/tapih && cd $_
$ git clone https://github.com/tapih/dotfiles

$ cd dotfiles
$ ./install.sh
```

#### Settings for WSL

```console
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

#### Docker

See [the official document](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

