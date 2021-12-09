FROM node:12-alpine

RUN npm install -g dynamodb-admin

EXPOSE 8001
ENV DYNAMO_ENDPOINT=http://dynamodb:4569/
ENV AWS_REGION=sa-east-1
ENV AWS_ACCESS_KEY_ID=admin
ENV AWS_SECRET_ACCESS_KEY=admin

ENTRYPOINT dynamodb-admin