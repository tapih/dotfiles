#! /bin/sh

if [ -e ~/.ssh/github_rsa ]; then
  echo "file already exists"
  exit 0
fi

mkdir -p -m 700 ~/.ssh
cat << EOF > ~/.ssh/config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_rsa
EOF
ssh-keygen -t ed25519 -P "" -f ~/.ssh/github_rsa

