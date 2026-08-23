#!/bin/bash
# Controle de Pacientes - Iniciar (macOS)

cd "$(dirname "$0")"

# Verificar instalação
if [ ! -d "venv" ]; then
    echo ""
    echo "  O programa ainda não foi instalado."
    echo "  Execute primeiro o arquivo \"instalar.command\""
    echo ""
    read -p "  Pressione Enter para sair..."
    exit 1
fi

source venv/bin/activate

echo ""
echo "  ========================================"
echo "   Controle de Pacientes"
echo "  ========================================"
echo ""
echo "  O programa está rodando!"
echo "  Abrindo no navegador..."
echo ""
echo "  Para PARAR o programa, feche esta janela"
echo "  ou pressione Ctrl+C"
echo ""

# Abrir navegador automaticamente (força Safari, evita erros no Chrome)
sleep 1 && open -a Safari http://127.0.0.1:8642 &

# Iniciar o app
python3 app.py
