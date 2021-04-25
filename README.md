# dotfiles

⚡⚡⚡

## OS

Ubuntu 20.04 (on WSL2)

## Install

### Ubuntu 20.04

```sh
sudo visudo
# tapih ALL=NOPASSWD: ALL

mkdir -m 700 ~/.ssh && cd ~/.ssh
cat << EOF > config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_rsa
EOF
ssh-keygen -t rsa -b 4096 -f github_rsa
# register the generated public key to GitHub

mkdir ~/src && cd ~/src
git clone git@github.com:tapih/dotfiles
cd dotfiles
sudo apt-get install -y make
make postinst OS=ubuntu
# exit shell once, select "q"
. ~/.zshrc

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

