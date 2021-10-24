#! /bin/sh

set -e

key=~/.ssh/github_rsa

if [ -e ${key} ]; then
  echo "file already exists"
  exit 0
fi

mkdir -p -m 700 ~/.ssh
cat << EOF > ~/.ssh/config
Host github.com
    HostName github.com
    User git
    IdentityFile ${key}
EOF
ssh-keygen -t ed25519 -P "" -f ${key}

