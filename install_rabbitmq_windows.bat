@echo off
SETLOCAL

echo Installing RabbitMQ on Windows...

:: 1. Download and install Chocolatey if not present
where choco >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    echo Installing Chocolatey...
    powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command ^
    "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
) ELSE (
    echo Chocolatey already installed
)

:: 2. Install Erlang
echo Installing Erlang...
choco install erlang -y

:: 3. Install RabbitMQ
echo Installing RabbitMQ...
choco install rabbitmq -y

:: 4. Set RabbitMQ environment variables (optional)
echo Setting RabbitMQ environment variables...
setx RABBITMQ_HOME "C:\Program Files\RabbitMQ Server\rabbitmq_server-*"
setx PATH "%PATH%;C:\Program Files\RabbitMQ Server\rabbitmq_server-*\sbin"

:: 5. Enable RabbitMQ Management Plugin
echo Enabling RabbitMQ Management Plugin...
rabbitmq-plugins.bat enable rabbitmq_management

:: 6. Start RabbitMQ Service
echo Starting RabbitMQ Service...
net start RabbitMQ

echo RabbitMQ installation completed!
pause
ENDLOCAL
