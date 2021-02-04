# dotfiles

⚡

## OS

Ubuntu 20.04

## Install

```bash
$ mkdir -m 700 ~/.ssh
$ ssh-keygen -t rsa -b 4096 -f github_rsa
# register the public key to GitHub

$ cat << EOF > config
HostName github.com
Host github.com
User git
IdentityFile ~/.ssh/github_rsa
EOF

$ sudo apt install make curl

$ mkdir ~/src
$ cd ~/src
$ git clone ssh://github.com/tapih/dotfiles
$ cd dotfiles
$ make
```
