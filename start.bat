@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"
title TIDELINE - iShares Cycle Analysis

rem ---- Port (default 3000, or pass as first argument) ----
set PORT=3000
if not "%~1"=="" set PORT=%~1

rem ---- Locate Node.js: local portable runtime first, then system PATH ----
set NODE_EXE=
if exist "runtime\node.exe" set NODE_EXE=runtime\node.exe
if "%NODE_EXE%"=="" (
  where node >nul 2>nul && set NODE_EXE=node
)

rem ---- Auto-download portable Node runtime if none found ----
if "%NODE_EXE%"=="" (
  echo Node.js not found on this computer.
  echo Downloading portable Node runtime (about 30 MB, one time only^)...
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; Invoke-WebRequest -Uri 'https://nodejs.org/dist/v20.18.1/node-v20.18.1-win-x64.zip' -OutFile 'node_tmp.zip'; Expand-Archive -Path 'node_tmp.zip' -DestinationPath 'runtime_tmp' -Force; Remove-Item 'node_tmp.zip'"
  if not exist "runtime_tmp\node-v20.18.1-win-x64\node.exe" goto :dlfail
  if not exist "runtime" mkdir runtime
  move /y "runtime_tmp\node-v20.18.1-win-x64\node.exe" "runtime\node.exe" >nul
  rmdir /s /q runtime_tmp
  set NODE_EXE=runtime\node.exe
  echo Portable Node runtime ready.
)

rem ---- Launch browser after a short delay, then start the server ----
echo.
echo  ======================================================
echo   TIDELINE starting at:  http://localhost:%PORT%
echo   Keep this window open. Press Ctrl+C to stop.
echo  ======================================================
echo.
start "" cmd /c "timeout /t 3 >nul & start http://localhost:%PORT%"
set HOSTNAME=127.0.0.1
"%NODE_EXE%" "app\server.js"
goto :eof

:dlfail
echo.
echo Could not download the Node runtime automatically.
echo Please install Node.js LTS from https://nodejs.org and run this file again.
echo.
pause
