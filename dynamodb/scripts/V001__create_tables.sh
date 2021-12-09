for jsonfile in `ls /app/tables/*.json`;
do
  echo "CRIANDO TABELA DO ARQUIVO: -> ${jsonfile##*/}"
  awslocal dynamodb create-table --cli-input-json file://${jsonfile}
done;
