#!/bin/bash

# Обновление пакетов и установка необходимых зависимостей
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Добавление ключа GPG для Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Добавление репозитория Docker
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Установка Docker
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Включение и запуск Docker
sudo systemctl enable docker
sudo systemctl start docker

# Проверка установки Docker
docker --version

echo "Docker установлен успешно."
