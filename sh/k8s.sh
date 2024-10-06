#!/bin/bash

# Обновление пакетов
sudo apt-get update -y

# Установка kubeadm, kubelet и kubectl через snap
sudo snap install kubeadm --classic
sudo snap install kubelet --classic
sudo snap install kubectl --classic

# Включение автозапуска kubelet
sudo systemctl enable snap.kubelet.daemon
sudo systemctl start snap.kubelet.daemon

# Проверка установленных версий
kubeadm version
kubectl version --client
kubelet --version

echo "Kubernetes компоненты установлены успешно."
