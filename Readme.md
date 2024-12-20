
# Service Docker

Этот проект предоставляет набор Docker-контейнеров для различных сервисов, таких как Kafka, MySQL, Nginx, PHP и RabbitMQ, а также скрипты для их управления и тестирования.

## Содержание

- [Установка](#установка)
- [Использование](#использование)
    - [Запуск всех сервисов](#запуск-всех-сервисов)
    - [Запуск отдельных сервисов](#запуск-отдельных-сервисов)
    - [Остановка сервисов](#остановка-сервисов)
    - [Загрузка тестовой нагрузки](#загрузка-тестовой-нагрузки)
- [Конфигурация](#конфигурация)
- [Структура проекта](#структура-проекта)
- [Требования](#требования)
- [Лицензия](#лицензия)

## Установка

1. **Клонируйте репозиторий:**

   ```bash
   git clone https://github.com/estev-work/service-docker.git
   ```

2. **Перейдите в каталог проекта:**

   ```bash
   cd service-docker
   ```

3. **Скопируйте пример файла окружения:**

   ```bash
   cp .env.example .env
   ```

4. **Отредактируйте файл `.env` в соответствии с вашими требованиями.**

## Использование

### Запуск всех сервисов

Для запуска всех сервисов используйте команду:

```bash
docker-compose up -d
```

### Запуск отдельных сервисов

Вы можете запустить конкретные сервисы, указав их имена:

```bash
docker-compose up -d <имя_сервиса>
```

Например, для запуска только MySQL:

```bash
docker-compose up -d mysql
```

### Остановка сервисов

Чтобы остановить все запущенные сервисы:

```bash
docker-compose down
```

### Загрузка тестовой нагрузки

Для выполнения тестовой нагрузки используйте скрипт `load-test.js`. Убедитесь, что у вас установлен Node.js.

1. **Установите зависимости:**

   ```bash
   npm install
   ```

2. **Запустите тест:**

   ```bash
   node load-test.js
   ```

## Конфигурация

Все настройки сервисов находятся в файле `.env`. Отредактируйте этот файл, чтобы изменить параметры, такие как порты, учетные данные и другие настройки.

## Структура проекта

- `kafka/` — конфигурации для Kafka.
- `mysql/` — конфигурации для MySQL.
- `nginx/` — конфигурации для Nginx.
- `php/` — конфигурации для PHP.
- `rabbitmq/` — конфигурации для RabbitMQ.
- `sh/` — скрипты для управления сервисами.
- `.env.example` — пример файла окружения.
- `docker-compose.yaml` — основной файл Docker Compose.
- `docker-compose.consumers.yml` — дополнительный файл Docker Compose для потребителей.
- `load-test.js` — скрипт для тестовой нагрузки.

## Требования

- Docker
- Docker Compose
- Node.js (для запуска `load-test.js`)

## Лицензия

Этот проект распространяется под лицензией MIT. Подробности см. в файле `LICENSE`.