#! /bin/sh
# https://zenn.dev/masakura/articles/8d05c70c35b0d7
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

apt-get update; \
  apt-get install -y apt-transport-https && \
  apt-get update && \
  apt-get install -y aspnetcore-runtime-5.0 daemonize dbus gawk libc6 libstdc++6 policykit-1 systemd systemd-container

wget -O /etc/apt/trusted.gpg.d/wsl-transdebian.gpg https://arkane-systems.github.io/wsl-transdebian/apt/wsl-transdebian.gpg

chmod a+r /etc/apt/trusted.gpg.d/wsl-transdebian.gpg

cat << EOF > /etc/apt/sources.list.d/wsl-transdebian.list
deb https://arkane-systems.github.io/wsl-transdebian/apt/ $(lsb_release -cs) main
deb-src https://arkane-systems.github.io/wsl-transdebian/apt/ $(lsb_release -cs) main
EOF

apt update
apt install -y systemd-genie

