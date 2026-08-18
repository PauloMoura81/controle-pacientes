#!/bin/bash
# Controle de Pacientes - Instalação (macOS)

clear
echo ""
echo "  ========================================"
echo "   Controle de Pacientes - Instalação"
echo "  ========================================"
echo ""

# Ir para a pasta do script
cd "$(dirname "$0")"

# Verificar Python
if ! command -v python3 &> /dev/null; then
    echo "  [ERRO] Python 3 não encontrado!"
    echo ""
    echo "  Você precisa instalar o Python primeiro:"
    echo "  1. Acesse: https://www.python.org/downloads/"
    echo "  2. Baixe e instale o Python 3"
    echo "  3. Após instalar, execute este arquivo novamente"
    echo ""
    read -p "  Pressione Enter para sair..."
    exit 1
fi

echo "  [OK] Python encontrado: $(python3 --version)"
echo ""

# Criar ambiente virtual
echo "  Criando ambiente virtual..."
if [ ! -d "venv" ]; then
    python3 -m venv venv
    if [ $? -ne 0 ]; then
        echo "  [ERRO] Falha ao criar ambiente virtual."
        read -p "  Pressione Enter para sair..."
        exit 1
    fi
fi
echo "  [OK] Ambiente virtual pronto."
echo ""

# Ativar e instalar dependências
echo "  Instalando dependências..."
source venv/bin/activate
pip install -r requirements.txt --quiet
if [ $? -ne 0 ]; then
    echo "  [ERRO] Falha ao instalar dependências."
    read -p "  Pressione Enter para sair..."
    exit 1
fi
echo "  [OK] Dependências instaladas."
echo ""

# Criar banco de dados
echo "  Preparando banco de dados..."
python3 -c "from app import app, db; app.app_context().push(); db.create_all()"
echo "  [OK] Banco de dados pronto."
echo ""

echo "  ========================================"
echo "   Instalação concluída com sucesso!"
echo "  ========================================"
echo ""
echo "  Para iniciar o programa, clique duas vezes em:"
echo "    IniciarApp.command"
echo ""
read -p "  Pressione Enter para sair..."
