@echo off
SETLOCAL

echo Installing RabbitMQ and MongoDB with all essential tools on Windows...

:: --------- Check Chocolatey ---------
where choco >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    echo Installing Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
) ELSE (
    echo Chocolatey already installed
)

:: --------- Install Erlang & RabbitMQ ---------
echo Installing Erlang...
choco install erlang -y

echo Installing RabbitMQ...
choco install rabbitmq -y

echo Enabling RabbitMQ management plugin...
rabbitmq-plugins.bat enable rabbitmq_management

echo Starting RabbitMQ service...
net start RabbitMQ

:: --------- Install MongoDB ---------
echo Installing MongoDB Server...
choco install mongodb -y

echo Installing MongoDB Shell (mongosh)...
choco install mongodb-shell -y

echo Installing MongoDB Database Tools...
choco install mongodb-database-tools -y

echo Installing MongoDB Compass...
choco install mongodb-compass -y

:: --------- Configure MongoDB ---------
echo Creating MongoDB data directory...
mkdir "C:\data\db"

echo Installing MongoDB as a Windows service...
"C:\Program Files\MongoDB\Server\6.0\bin\mongod.exe" --config "C:\Program Files\MongoDB\Server\6.0\mongod.cfg" --install
net start MongoDB

echo.
echo Installation completed!
echo RabbitMQ and MongoDB with all tools are installed and running.
pause
ENDLOCAL
