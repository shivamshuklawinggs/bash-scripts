@echo off
SETLOCAL

echo Installing RabbitMQ on Windows...


:: 1. Install Erlang
echo Installing Erlang...
choco install erlang -y

:: 2. Install RabbitMQ
echo Installing RabbitMQ...
choco install rabbitmq -y

:: 3. Set RabbitMQ environment variables (optional)
echo Setting RabbitMQ environment variables...
setx RABBITMQ_HOME "C:\Program Files\RabbitMQ Server\rabbitmq_server-*"
setx PATH "%PATH%;C:\Program Files\RabbitMQ Server\rabbitmq_server-*\sbin"

:: 4. Enable RabbitMQ Management Plugin
echo Enabling RabbitMQ Management Plugin...
rabbitmq-plugins.bat enable rabbitmq_management

:: 5. Start RabbitMQ Service
echo Starting RabbitMQ Service...
net start RabbitMQ

echo RabbitMQ installation completed!
pause
ENDLOCAL

