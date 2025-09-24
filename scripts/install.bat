@echo off
REM Burp MCP Installation Script for Windows
REM This script installs the Burp MCP integration for VS Code

setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"
set "RELEASE_DIR=%SCRIPT_DIR%..\"
set "VSCODE_CONFIG_DIR=%APPDATA%\Code\User"
set "MCP_CONFIG_FILE=%VSCODE_CONFIG_DIR%\mcp.json"
set "BURP_PROXY_SCRIPT=%RELEASE_DIR%bin\burp-mcp-proxy.bat"
set "JARS_DIR=%RELEASE_DIR%jars"

rem GitHub repository information
set GITHUB_USER=x00byte
set GITHUB_REPO=burpsuite-mcp-vscode
set GITHUB_RELEASE_TAG=v1.0.0

echo 🚀 Installing Burp MCP Integration for VS Code...
echo.

REM Create directories
if not exist "%VSCODE_CONFIG_DIR%" mkdir "%VSCODE_CONFIG_DIR%"
if not exist "%JARS_DIR%" mkdir "%JARS_DIR%"

REM Download JAR files if they don't exist
if not exist "%JARS_DIR%\burp-mcp-all.jar" (
    echo 📥 Downloading JAR files from GitHub releases...
    echo    Please download the following files manually and place them in %JARS_DIR%:
    echo    - burp-mcp-all.jar
    echo    - mcp-proxy.jar  
    echo    from: https://github.com/%GITHUB_USER%/%GITHUB_REPO%/releases/latest
    echo.
    echo    Press any key to continue after downloading the JAR files...
    pause >nul
) else (
    echo ✅ JAR files already exist, skipping download
)

REM Check if mcp.json exists
if exist "%MCP_CONFIG_FILE%" (
    echo 📝 Backing up existing MCP configuration...
    for /f "tokens=2-4 delims=/ " %%a in ('date /t') do set mydate=%%c%%a%%b
    for /f "tokens=1-2 delims=/: " %%a in ('time /t') do set mytime=%%a%%b
    copy "%MCP_CONFIG_FILE%" "%MCP_CONFIG_FILE%.backup.!mydate!_!mytime!"
)

REM Create or update MCP configuration
echo 🔧 Configuring MCP servers...
(
echo {
echo     "servers": {
echo         "burp": {
echo             "type": "stdio",
echo             "command": "%BURP_PROXY_SCRIPT:\=\\%",
echo             "args": [],
echo             "env": {
echo                 "BURP_MCP_URL": "http://127.0.0.1:9876"
echo             }
echo         }
echo     },
echo     "inputs": []
echo }
) > "%MCP_CONFIG_FILE%"

echo ✅ Installation complete!
echo.
echo 📋 Next steps:
echo 1. Start Burp Suite
echo 2. Install the Burp extension: %RELEASE_DIR%jars\burp-mcp-all.jar
echo 3. Enable MCP server in Burp ^(MCP tab^)
echo 4. Restart VS Code
echo 5. Test with: 'Base64 encode Hello World'
echo.
echo 📄 Configuration saved to: %MCP_CONFIG_FILE%
pause
