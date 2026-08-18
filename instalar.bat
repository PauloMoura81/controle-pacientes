@echo off
chcp 65001 >nul
title Controle de Pacientes - Instalação
echo.
echo  ========================================
echo   Controle de Pacientes - Instalação
echo  ========================================
echo.

:: Verificar se Python está instalado
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo  [ERRO] Python não encontrado!
    echo.
    echo  Você precisa instalar o Python primeiro:
    echo  1. Acesse: https://www.python.org/downloads/
    echo  2. Clique em "Download Python 3.x.x"
    echo  3. IMPORTANTE: Marque a opção "Add Python to PATH" na instalação
    echo  4. Após instalar, execute este arquivo novamente
    echo.
    pause
    exit /b 1
)

echo  [OK] Python encontrado.
python --version
echo.

:: Ir para a pasta do script
cd /d "%~dp0"

:: Criar ambiente virtual
echo  Criando ambiente virtual...
if not exist "venv" (
    python -m venv venv
    if %errorlevel% neq 0 (
        echo  [ERRO] Falha ao criar ambiente virtual.
        pause
        exit /b 1
    )
)
echo  [OK] Ambiente virtual pronto.
echo.

:: Ativar e instalar dependências
echo  Instalando dependências...
call venv\Scripts\activate.bat
pip install -r requirements.txt --quiet
if %errorlevel% neq 0 (
    echo  [ERRO] Falha ao instalar dependências.
    pause
    exit /b 1
)
echo  [OK] Dependências instaladas.
echo.

:: Criar banco de dados
echo  Preparando banco de dados...
python -c "from app import app, db; app.app_context().push(); db.create_all()"
echo  [OK] Banco de dados pronto.
echo.

echo  ========================================
echo   Instalação concluída com sucesso!
echo  ========================================
echo.
echo  Para iniciar o programa, clique duas vezes em:
echo    IniciarApp.bat
echo.
pause
