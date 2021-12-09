#!/bin/bash

echo Encerrando a infraestrutura do projeto ocr cupom

docker compose -f ./redis/docker-compose.yml down

docker compose -f ./dynamodb/docker-compose.yml down

docker network rm ocr-network