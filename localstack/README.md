# Invocando Lambda Function localmente usando o Localstack

## Requisitos necessários

- Docker

## Passo a passo
Em um terminal do git bash, realize o comando abaixo:

```sh
./start.sh
```

Logo após a execução deste comando, será gerada a pasta `output`. Dentro desta pasta, será criado um arquivo chamado `endpoint.txt`, neste arquivo existe a rota gerada pelo API Gateway para realizar a requisição na Lambda.

Em seguida, basta fazer a requisição para a Lambda como no exemplo abaixo:
````bash
curl --location --request GET 'http://localhost:4566/restapis/${API_GATEWAY_ID}/test/_user_request_/tipo_cobranca' \
--header 'x-itau-correlationID: BATATINHA'
````