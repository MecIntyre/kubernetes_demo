#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

# Konfiguration der Namensauflösung
systemctl disable --now systemd-resolved
rm /etc/resolv.conf
echo "nameserver 192.168.100.2" > /etc/resolv.conf
cp /vagrant/config/hosts /etc/hosts

# Docker-Installation
apt-get -y install docker.io
cp /vagrant/config/docker-daemon.json /etc/docker/daemon.json
systemctl enable --now docker

# Kubernetes
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
cp /vagrant/config/ip-forward.conf /etc/sysctl.d/
apt-get -y install software-properties-common apt-transport-https curl jq
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
apt-add-repository "deb https://apt.kubernetes.io/ kubernetes-xenial main"
apt-get -y install kubeadm kubelet kubectl kubernetes-cni

# Benutzer vagrant zu Gruppen hinzufügen
adduser vagrant docker
