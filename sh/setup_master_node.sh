#!/bin/bash

# Отключение swap, так как Kubernetes не работает со swap
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Обновление системы
sudo apt-get update -y

# Установка Docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Включение и запуск Docker
sudo systemctl enable docker
sudo systemctl start docker

# Добавление ключа для Kubernetes
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Добавление репозитория Kubernetes
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Установка Kubernetes компонентов
sudo apt-get update -y
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Инициализация Kubernetes на мастер-ноде
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

# Настройка kubectl для текущего пользователя
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# shellcheck disable=SC2046
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Установка сетевого плагина для Pod'ов (например, Calico)
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

echo "Мастер-нода Kubernetes успешно развернута!"
