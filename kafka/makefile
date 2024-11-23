KAFKA_CONTAINER=kafka
TOPIC_NAME=question.created
NEW_PARTITIONS=4

# Команда для добавления партиций в существующий топик
add-partitions:
	@docker compose exec $(KAFKA_CONTAINER) \
	/bin/kafka-topics --alter \
	--topic $(TOPIC_NAME) \
	--partitions $(NEW_PARTITIONS) \
	--bootstrap-server localhost:9092
