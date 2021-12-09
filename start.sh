#!/bin/bash

echo Iniciando a infraestrutura do projeto ocr cupom

docker network create ocr-network

docker compose -f ./redis/docker-compose.yml up -d

docker compose -f ./dynamodb/docker-compose.yml up -d