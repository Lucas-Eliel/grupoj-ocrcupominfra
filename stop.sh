#!/bin/bash

echo Encerrando a infraestrutura do projeto ocr cupom

rm -R  /Users/lucaseliel/Documents/projects/grupoj-ocrcupomquery/boto3

rm -R  /Users/lucaseliel/Documents/projects/grupoj-ocrcupomcommand/azure
rm -R  /Users/lucaseliel/Documents/projects/grupoj-ocrcupomcommand/boto3
rm -R  /Users/lucaseliel/Documents/projects/grupoj-ocrcupomcommand/isodate
rm -R  /Users/lucaseliel/Documents/projects/grupoj-ocrcupomcommand/msrest
rm -R  /Users/lucaseliel/Documents/projects/grupoj-ocrcupomcommand/requests
rm -R  /Users/lucaseliel/Documents/projects/grupoj-ocrcupomcommand/requests_oauthlib

docker compose -f ./redis/docker-compose.yml down

docker compose -f ./dynamodb/docker-compose.yml down

docker compose -f ./localstack/docker-compose.yml down

docker network rm ocr-network