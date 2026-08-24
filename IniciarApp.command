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

# Abrir navegador automaticamente somente quando o servidor já estiver
# respondendo (a primeira inicialização pode demorar mais de 1 segundo)
(
    for i in $(seq 1 30); do
        if curl -s -o /dev/null "http://127.0.0.1:8642"; then
            open -a Safari http://127.0.0.1:8642
            break
        fi
        sleep 1
    done
) &

# Iniciar o app
python3 app.py
