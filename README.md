# OCR CUPOM INFRA

Micro serviço responsável por criar o ambiente da aws localmente em sua máquina preparando o ambiente para:

#### https://github.com/Lucas-Eliel/grupoj-ocrcupomcommand
#### https://github.com/Lucas-Eliel/grupoj-ocrcupomquery

## Arquitetura

![](Arquitetura%20OCR%20Cupom.drawio.png)


## Requisitos:

### 1 - Precisa ter o docker instalado na maquina
### 2 - Clone os projetos do git:
#### 2.1 - https://github.com/Lucas-Eliel/grupoj-ocrcupomcommand
#### 2.2 - https://github.com/Lucas-Eliel/grupoj-ocrcupomquery

## Alterações Necessárias:

### 1 - Neste projeto vá até o arquivo localstack/docker-compose.yml e altere os caminhos dos volumes das lambdas:
#### 1.1 - Para o /lambda_folder_ocrcupomcommand indique o caminho da sua máquina para o projeto baixado grupoj-ocrcupomcommand
#### 1.2 - Para o /lambda_folder_ocrcupomquery indique o caminho da sua máquina para o projeto baixado grupoj-ocrcupomquery

### 2 - Neste projeto vá até o arquivo start.sh e altere os caminhos das lambdas:
#### 2.1 - Para os comando de copia (cp -R) indique o caminho da sua máquina para o projeto baixado grupoj-ocrcupomcommand
#### 2.2 - Para os comando de copia (cp -R) indique o caminho da sua máquina para o projeto baixado grupoj-ocrcupomquery

### 3 - Neste projeto vá até o arquivo stop.sh e altere os caminhos das lambdas:
#### 3.1 - Para os comando de remoção (rm -R) indique o caminho da sua máquina para o projeto baixado grupoj-ocrcupomcommand
#### 3.2 - Para os comando de remoção (rm -R) indique o caminho da sua máquina para o projeto baixado grupoj-ocrcupomquery

## Iniciar:

#### Para executar basta clicar com o botão direito em cima do arquivo start.sh dentro da plataforma de uma IDE (pycharm ou intellij) e em seguida selecionar o run

## Parar:

#### Para encerrar basta clicar com o botão direito em cima do arquivo stop.sh dentro da plataforma de uma IDE (pycharm ou intellij) e em seguida selecionar o run


