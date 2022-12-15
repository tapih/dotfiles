# dotfiles

⚡⚡⚡

## Install

### On Windows side

- Chrome
- Mozc(+Swap Ctrl and Caps)
- Enpass
- Slack
- Notion
- Kindle
- VSCode
- FiraCode
- Xming

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
$ sudo ln -s $(which wsl-open) /usr/local/bin/xdg-open

$ sudo sh -c "cat << EOF > /etc/wsl.conf
[boot]
systemd=true

[wsl2]
memory=16GB
processors=4
EOF"
```

Then, install [Docker](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

