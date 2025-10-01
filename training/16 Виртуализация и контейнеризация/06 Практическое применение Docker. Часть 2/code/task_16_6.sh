#!/bin/bash
set -e

REPO_URL="https://github.com/AlkoHead/shvirtd-example-python.git"
DOWNLOAD_DIR="/opt/task_16"

echo "Запуск развертывания..."

# Создаем директорию и клонируем
sudo mkdir -p "$DOWNLOAD_DIR"
cd "$DOWNLOAD_DIR"
sudo git clone "$REPO_URL" . 2>/dev/null || (echo "Обновляем репозиторий..." && sudo git pull)

# Запускаем проект
sudo docker compose down 2>/dev/null || true
sudo docker compose up -d --build

echo "Ожидаем запуск сервисов..."
sleep 60

echo "Развертывание завершено!"
echo "URL: http://127.0.0.1:8090/"