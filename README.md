# dotfiles

⚡⚡⚡

## OS

Ubuntu 20.04 on WSL2

## Install

```bash
sudo visudo
# tapih ALL=NOPASSWD: ALL

mkdir -m 700 ~/.ssh
cd ~/.ssh
ssh-keygen -t rsa -b 4096 -f github_rsa
# register the generated public key to GitHub

cat << EOF > config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_rsa
EOF

mkdir ~/src
cd ~/src
git clone git@github.com:tapih/dotfiles
cd dotfiles

sudo apt-get install make
make -f install/links.mk clean
make setup install
```

Windows Terminal requires to disable `<C-v>` to work with `nvim`.
