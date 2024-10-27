# Переменные
MAIN_NODE = rabbitmq-main
NODE2 = rabbitmq-node2
NODE3 = rabbitmq-node-3
RABBIT_USER = rabbitmqctl
DOCKER_COMPOSE_FILE = docker-compose.rabbitmq.yml

# Команда для старта всех сервисов
buildup:
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build


# Команда для старта всех сервисов
up:
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d

# Команда для остановки всех сервисов
down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down -v

# Команда для присоединения второго нода к кластеру
join-node2:
	docker compose -f $(DOCKER_COMPOSE_FILE) exec $(NODE2) $(RABBIT_USER) --longnames stop_app
	docker compose -f $(DOCKER_COMPOSE_FILE) exec $(NODE2) $(RABBIT_USER) --longnames join_cluster rabbit@$(MAIN_NODE)
	docker compose -f $(DOCKER_COMPOSE_FILE) exec $(NODE2) $(RABBIT_USER) --longnames start_app

# Команда для присоединения третьего нода к кластеру
join-node3:
	docker compose -f $(DOCKER_COMPOSE_FILE) exec $(NODE3) $(RABBIT_USER) --longnames stop_app
	docker compose -f $(DOCKER_COMPOSE_FILE) exec $(NODE3) $(RABBIT_USER) --longnames join_cluster rabbit@$(MAIN_NODE)
	docker compose -f $(DOCKER_COMPOSE_FILE) exec $(NODE3) $(RABBIT_USER) --longnames start_app

# Команда для присоединения всех нод
join-cluster: join-node2 join-node3

# Команда для проверки состояния кластера
status:
	docker compose -f $(DOCKER_COMPOSE_FILE) exec $(MAIN_NODE) $(RABBIT_USER) cluster_status

# Команда для перезапуска всех контейнеров
restart:
	docker compose -f $(DOCKER_COMPOSE_FILE) down -v && docker compose -f $(DOCKER_COMPOSE_FILE) up --build -d
