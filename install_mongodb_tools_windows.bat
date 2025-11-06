@echo off
SETLOCAL

echo Installing MongoDB with all essential tools on Windows...



:: --------- Install MongoDB ---------
echo Installing MongoDB Server...
choco install mongodb -y

echo Installing MongoDB Shell (mongosh)...
choco install mongodb-shell -y

echo Installing MongoDB Database Tools...
choco install mongodb-database-tools -y

echo Installing MongoDB Compass...
choco install mongodb-compass -y


echo.
echo Installation completed!
echo MongoDB with all tools are installed and running.
pause
ENDLOCAL
