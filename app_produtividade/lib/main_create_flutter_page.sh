#!/bin/bash

# Verificar se o nome do projeto foi fornecido
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 [nome_do_projeto]"
    exit 1
fi

# Nome do projeto fornecido como argumento
PROJECT_NAME=$1

# Criar o diretório principal do projeto
mkdir "$PROJECT_NAME"

# Entrar no diretório do projeto
cd "$PROJECT_NAME"

# Criar subdiretórios para MVC
mkdir views models controllers wigets layout 

# Mensagem de sucesso
echo "Projeto $PROJECT_NAME criado com sucesso!"
echo "Estrutura:"
echo "- $PROJECT_NAME/"
echo "  - views/"
echo "  - models/"
echo "  - controllers/"
