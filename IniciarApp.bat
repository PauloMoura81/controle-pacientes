@echo off
chcp 65001 >nul
title Controle de Pacientes
cd /d "%~dp0"

:: Verificar se já foi instalado
if not exist "venv" (
    echo.
    echo  O programa ainda não foi instalado.
    echo  Execute primeiro o arquivo "instalar.bat"
    echo.
    pause
    exit /b 1
)

:: Ativar ambiente e iniciar
call venv\Scripts\activate.bat
echo.
echo  ========================================
echo   Controle de Pacientes
echo  ========================================
echo.
echo  O programa está rodando!
echo  Abrindo no navegador...
echo.
echo  Para PARAR o programa, feche esta janela
echo  ou pressione Ctrl+C
echo.

:: Abrir navegador automaticamente após 2 segundos
start "" http://localhost:5000

:: Iniciar o app
python app.py
