#!/bin/bash

API_NAME=api
STAGE=test

echo -----------------------------------------------------------------
echo ---------Criando a lambda do grupoj-ocrcupomcommand--------------
echo -----------------------------------------------------------------

awslocal lambda create-function --function-name ocrcupomcommandfunction \
    --code S3Bucket="__local__",S3Key="/lambda_folder_ocrcupomcommand" \
    --handler lambda_function.lambda_handler \
    --runtime python3.8 \
    --role All

echo -----------------------------------------------------------------
echo ---------Criando a lambda do grupoj-ocrcupomquery----------------
echo -----------------------------------------------------------------

awslocal lambda create-function --function-name ocrcupomqueryfunction \
    --code S3Bucket="__local__",S3Key="/lambda_folder_ocrcupomquery" \
    --handler lambda_function.lambda_handler \
    --runtime python3.8 \
    --role All

[ $? == 0 ] || fail 1 "Failed: AWS / lambda / create-function"

echo -----------------------------------------------------------------
echo ------Obtendo ARN da lambda do grupoj-ocrcupomcommand------------
echo -----------------------------------------------------------------

LAMBDA_OCR_CUPOM_COMMAND_ARN=$(awslocal lambda list-functions --query "Functions[?FunctionName==\`ocrcupomcommandfunction\`].FunctionArn" --output text)
echo LAMBDA_OCR_CUPOM_COMMAND_ARN ${LAMBDA_OCR_CUPOM_COMMAND_ARN}

echo -----------------------------------------------------------------
echo --------Obtendo ARN da lambda do grupoj-ocrcupomquery------------
echo -----------------------------------------------------------------

LAMBDA_OCR_CUPOM_QUERY_ARN=$(awslocal lambda list-functions --query "Functions[?FunctionName==\`ocrcupomqueryfunction\`].FunctionArn" --output text)
echo LAMBDA_OCR_CUPOM_QUERY_ARN ${LAMBDA_OCR_CUPOM_QUERY_ARN}


echo -----------------------------------------------------------------
echo ---------------------Criando o API Gateway-----------------------
echo -----------------------------------------------------------------

awslocal apigateway create-rest-api --name ${API_NAME}

[ $? == 0 ] || fail 2 "Failed: AWS / apigateway / create-rest-api"

API_ID=$(awslocal apigateway get-rest-apis --query "items[?name==\`${API_NAME}\`].id" --output text)
echo API_ID ${API_ID}

PARENT_RESOURCE_ID=$(awslocal apigateway get-resources --rest-api-id ${API_ID} --query 'items[?path==`/`].id' --output text)
echo PARENT_RESOURCE_ID ${PARENT_RESOURCE_ID}

awslocal apigateway create-resource \
    --rest-api-id ${API_ID} \
    --parent-id ${PARENT_RESOURCE_ID} \
    --path-part "processamento-ocr-cupom"

awslocal apigateway create-resource \
    --rest-api-id ${API_ID} \
    --parent-id ${PARENT_RESOURCE_ID} \
    --path-part "cupons-validos"

awslocal apigateway create-resource \
    --rest-api-id ${API_ID} \
    --parent-id ${PARENT_RESOURCE_ID} \
    --path-part "cupons-invalidos"

echo -----------------------------------------------------------------------------------------------
echo ---------------------Criando recurso do grupoj-ocrcupomcommand API Gateway---------------------
echo -----------------------------------------------------------------------------------------------

[ $? == 0 ] || fail 3 "Failed: AWS / apigateway / create-resource"

RESOURCE_ID_OCR_CUPOM_COMMAND=$(awslocal apigateway get-resources --rest-api-id ${API_ID} --query 'items[?path==`/processamento-ocr-cupom`].id' --output text)
echo RESOURCE_ID_OCR_CUPOM_COMMAND ${RESOURCE_ID_OCR_CUPOM_COMMAND}

awslocal apigateway put-method \
    --rest-api-id ${API_ID} \
    --resource-id ${RESOURCE_ID_OCR_CUPOM_COMMAND} \
    --http-method POST \
    --authorization-type "NONE" \

[ $? == 0 ] || fail 4 "Failed: AWS / apigateway / put-method"

awslocal apigateway put-integration \
    --rest-api-id ${API_ID} \
    --resource-id ${RESOURCE_ID_OCR_CUPOM_COMMAND} \
    --http-method POST \
    --type AWS_PROXY \
    --integration-http-method POST \
    --uri arn:aws:apigateway:sa-east-1:lambda:path/2015-03-31/functions/${LAMBDA_OCR_CUPOM_COMMAND_ARN}/invocations \
    --passthrough-behavior WHEN_NO_MATCH \

echo -----------------------------------------------------------------------------------------------
echo ---------------------Criando recurso do grupoj-ocrcupomquery API Gateway-----------------------
echo -----------------------------------------------------------------------------------------------

RESOURCE_ID_OCR_CUPOM_QUERY_1=$(awslocal apigateway get-resources --rest-api-id ${API_ID} --query 'items[?path==`/cupons-validos`].id' --output text)
echo RESOURCE_ID_OCR_CUPOM_QUERY_1 ${RESOURCE_ID_OCR_CUPOM_QUERY_1}

[ $? == 0 ] || fail 5 "Failed: AWS / apigateway / put-integration"

awslocal apigateway put-method \
    --rest-api-id ${API_ID} \
    --resource-id ${RESOURCE_ID_OCR_CUPOM_QUERY_1} \
    --http-method GET \
    --authorization-type "NONE" \

[ $? == 0 ] || fail 6 "Failed: AWS / apigateway / put-method"

awslocal apigateway put-integration \
    --rest-api-id ${API_ID} \
    --resource-id ${RESOURCE_ID_OCR_CUPOM_QUERY_1} \
    --http-method GET \
    --type AWS_PROXY \
    --integration-http-method POST \
    --uri arn:aws:apigateway:sa-east-1:lambda:path/2015-03-31/functions/${LAMBDA_OCR_CUPOM_QUERY_ARN}/invocations \
    --passthrough-behavior WHEN_NO_MATCH \


RESOURCE_ID_OCR_CUPOM_QUERY_2=$(awslocal apigateway get-resources --rest-api-id ${API_ID} --query 'items[?path==`/cupons-invalidos`].id' --output text)
echo RESOURCE_ID_OCR_CUPOM_QUERY_2 ${RESOURCE_ID_OCR_CUPOM_QUERY_2}

[ $? == 0 ] || fail 5 "Failed: AWS / apigateway / put-integration"

awslocal apigateway put-method \
    --rest-api-id ${API_ID} \
    --resource-id ${RESOURCE_ID_OCR_CUPOM_QUERY_2} \
    --http-method GET \
    --authorization-type "NONE" \

[ $? == 0 ] || fail 6 "Failed: AWS / apigateway / put-method"

awslocal apigateway put-integration \
    --rest-api-id ${API_ID} \
    --resource-id ${RESOURCE_ID_OCR_CUPOM_QUERY_2} \
    --http-method GET \
    --type AWS_PROXY \
    --integration-http-method POST \
    --uri arn:aws:apigateway:sa-east-1:lambda:path/2015-03-31/functions/${LAMBDA_OCR_CUPOM_QUERY_ARN}/invocations \
    --passthrough-behavior WHEN_NO_MATCH \

[ $? == 0 ] || fail 7 "Failed: AWS / apigateway / put-integration"

awslocal apigateway create-deployment \
    --rest-api-id ${API_ID} \
    --stage-name ${STAGE} \

[ $? == 0 ] || fail 6 "Failed: AWS / apigateway / create-deployment"

ENDPOINT=http://localhost:4566/restapis/${API_ID}/${STAGE}/_user_request_/processamento-ocr-cupom

echo "API available at: ${ENDPOINT}"

echo "{\"lambda_url\":\"${ENDPOINT}\"}" > /output/endpoint.json

echo Ambiente configurado com sucesso!