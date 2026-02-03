@echo off
rem activate_venv.bat - ativa o ambiente virtual localizado em .venv
rem Uso: execute este arquivo a partir da raiz do projeto (duplo-clique no Explorer não persiste a sessão)

set "VENV_DIR=%~dp0.venv"

if exist "%VENV_DIR%\Scripts\activate.bat" (
    call "%VENV_DIR%\Scripts\activate.bat"
    goto :eof
)

if exist "%VENV_DIR%\Scripts\Activate.ps1" (
    echo "activate.bat" nao encontrado; abrindo PowerShell para ativar o venv...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-Location -LiteralPath '%~dp0'; . '%VENV_DIR%\\Scripts\\Activate.ps1'"
    goto :eof
)

rem Fallback: ajustar PATH e VIRTUAL_ENV para simular ativacao num CMD
set "ACTIVATE_OLDPATH=%PATH%"
set "PATH=%VENV_DIR%\Scripts;%PATH%"
set "VIRTUAL_ENV=%VENV_DIR%"
echo Virtualenv ativado por fallback. PATH atualizado e VIRTUAL_ENV definido.
echo Para desativar nesta sessao, execute: %~nx0 deactivate
goto :eof

:deactivate
if defined ACTIVATE_OLDPATH (
    set "PATH=%ACTIVATE_OLDPATH%"
    set "VIRTUAL_ENV="
    set "ACTIVATE_OLDPATH="
    echo Virtualenv desativado.
) else (
    echo Nenhuma informacao de ativacao encontrada.
)
goto :eof
