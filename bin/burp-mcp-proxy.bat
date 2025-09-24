@echo off
REM Burp MCP Proxy Server Launcher (Windows)
REM This script starts the MCP proxy server that connects VS Code to Burp Suite
REM 
REM Usage: burp-mcp-proxy.bat
REM Environment Variables:
REM   BURP_MCP_URL - URL of the Burp MCP server (default: http://127.0.0.1:9876)

setlocal enabledelayedexpansion

REM Get script directory
set "SCRIPT_DIR=%~dp0"
set "RELEASE_DIR=%SCRIPT_DIR%..\"

REM Configuration
if not defined BURP_MCP_URL set "BURP_MCP_URL=http://127.0.0.1:9876"
set "JAR_PATH=%RELEASE_DIR%jars\mcp-proxy.jar"

REM Validation
if not exist "%JAR_PATH%" (
    echo ❌ Error: Burp MCP Proxy JAR not found at: %JAR_PATH%
    echo    Please ensure the JAR file is in the correct location.
    exit /b 1
)

where java >nul 2>nul
if errorlevel 1 (
    echo ❌ Error: Java is not installed or not in PATH
    echo    Please install Java 11 or later.
    exit /b 1
)

REM Start the MCP proxy server
echo 🚀 Starting Burp MCP Proxy Server...
echo 📡 Connecting to Burp MCP Server: %BURP_MCP_URL%
echo 📦 Using JAR: %JAR_PATH%
echo ---

java -jar "%JAR_PATH%" --sse-url "%BURP_MCP_URL%" %*
