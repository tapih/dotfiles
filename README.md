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
- Docker Desktop

### On WSL2 side

```sh
$ sudo apt-get update
$ sudo apt-get install -y curl zsh
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

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

# Set startup command to "C:\Windows\system32\wsl.exe -d Ubuntu-22.04 /usr/libexec/nslogin /usr/bin/zsh"
$ sudo sh -c "cat << EOF > /etc/wsl.conf
[boot]
command = /usr/libexec/wsl-systemd
EOF"

$ cat << "EOF" > /etc/wsl.conf
[wsl2]
memory=16GB
processors=4
EOF

$ sudo gpasswd -a $USER docker
```

