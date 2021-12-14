#!/bin/bash

echo Iniciando a infraestrutura do projeto ocr cupom

cp -R ./localstack/lambda/libs/query/ /Users/lucaseliel/Documents/projects/grupoj-ocrcupomquery

cp -R ./localstack/lambda/libs/command/ /Users/lucaseliel/Documents/projects/grupoj-ocrcupomcommand

docker network create ocr-network

docker compose -f ./redis/docker-compose.yml up -d

docker compose -f ./dynamodb/docker-compose.yml up -d

docker compose -f ./localstack/docker-compose.yml up -d


