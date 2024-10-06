#!/bin/bash

# Функция для запроса ввода с проверкой пустого значения
function prompt_input() {
  local prompt_message=$1
  local input_variable
  while [[ -z $input_variable ]]; do
    read -p "$prompt_message" input_variable
  done
  echo $input_variable
}

# Запрос IP адреса мастер-ноды
MASTER_IP=$(prompt_input "Введите IP адрес мастер-ноды: ")

# Запрос токена для присоединения
TOKEN=$(prompt_input "Введите токен для присоединения (вывод команды 'kubeadm token create --print-join-command' на мастер-ноде): ")

# Запрос хэша сертификата CA
HASH=$(prompt_input "Введите хэш сертификата (discovery-token-ca-cert-hash): ")

# Выполнение команды kubeadm join для подключения к кластеру
echo "Присоединение к Kubernetes кластеру..."

sudo kubeadm join $MASTER_IP:6443 --token $TOKEN --discovery-token-ca-cert-hash sha256:$HASH

if [[ $? -eq 0 ]]; then
  echo "Успешно присоединились к кластеру!"
else
  echo "Произошла ошибка при присоединении к кластеру."
fi
