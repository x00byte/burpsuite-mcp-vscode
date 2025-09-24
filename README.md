# 🚀 Burp Suite MCP Integration for VS Code

> **Integrate Burp Suite with VS Code using the Model Context Protocol (MCP)**

This package provides a complete, ready-to-use integration between Burp Suite and VS Code through the Model Context Protocol, enabling you to interact with Burp Suite directly from your AI assistant in VS Code.

## ✨ Features

- 🌐 **HTTP Request Tools**: Send HTTP/1.1 and HTTP/2 requests directly from VS Code
- 🔧 **Encoding/Decoding**: URL encode/decode, Base64 encode/decode, and random string generation
- 📊 **History Analysis**: Access and search Burp's proxy history and WebSocket history
- 🔄 **Burp Integration**: Create Repeater tabs, send to Intruder, control proxy intercept
- ⚙️ **Configuration Management**: Get and set Burp project/user configurations
- 🛡️ **Scanner Integration**: Access scanner issues and findings
- 💬 **AI-Powered**: Use natural language to interact with all Burp functionality

## 📦 Package Contents

**Repository Structure:**
```
burp-mcp-release/
├── bin/                    # Runtime executables
│   ├── burp-mcp-proxy.sh   # Linux/macOS proxy launcher
│   └── burp-mcp-proxy.bat  # Windows proxy launcher
├── scripts/                # Automation and utilities
│   ├── install.sh          # 🔧 Linux/macOS automated installer
│   ├── install.bat         # 🔧 Windows automated installer
│   └── verify.sh           # 🔍 Installation verification tool
├── config/                 # Configuration templates
│   └── vscode-mcp-config.json  # Sample VS Code MCP config
├── LICENSE                 # MIT License
├── CHANGELOG.md           # Version history
└── README.md              # This setup guide
```

**📥 JAR Files (Available in GitHub Releases):**
```
GitHub Releases Assets:
├── burp-mcp-all.jar       # Burp Suite extension (28MB)
└── mcp-proxy.jar          # MCP proxy server (12MB)
```

> 💡 **Note**: Due to GitHub's 25MB file size limit, the JAR files are provided as release assets rather than in the repository. The install scripts will automatically download them for you.

### 🛠️ Utility Scripts Explained

**Installation Scripts:**
- **`install.sh` / `install.bat`**: Fully automated setup that configures everything for you
- **`verify.sh`**: Comprehensive health check for your installation
- **`burp-mcp-proxy.sh/.bat`**: Runtime proxy launchers (auto-configured by install scripts)

**Why use the install scripts?**
- ✅ **Automatically downloads JAR files** from GitHub releases
- ✅ Handles all file copying and path configuration
- ✅ Creates VS Code MCP configuration automatically
- ✅ Sets proper permissions on Unix systems
- ✅ Validates your Java and Burp installation
- ✅ Runs end-to-end tests to ensure everything works

## 🚀 Quick Start

### Prerequisites

- ✅ **Java 11+** (OpenJDK recommended)
- ✅ **Burp Suite** (Community or Pro)
- ✅ **VS Code** with AI assistant (GitHub Copilot, Claude, etc.)

### Installation

#### 🔧 Option 1: Automated Installation (Recommended)

We provide convenient installation scripts that handle the entire setup process automatically:

**Linux/macOS:**
```bash
# Make the script executable and run
chmod +x scripts/install.sh
./scripts/install.sh
```

**Windows:**
```cmd
# Run the installation script
scripts\install.bat
```

**What the install scripts do:**
- ✅ Verify Java installation
- ✅ Check Burp Suite installation
- ✅ **Download JAR files** from GitHub releases automatically
- ✅ Copy JAR files to appropriate locations
- ✅ Configure VS Code MCP settings
- ✅ Set up proxy scripts with correct paths
- ✅ Run verification tests

#### 📋 Option 2: Manual Installation

1. **Download JAR Files:**
   - Go to the [GitHub Releases](../../releases) page
   - Download `burp-mcp-all.jar` (Burp Suite extension)
   - Download `mcp-proxy.jar` (MCP proxy server)

2. **Install Burp Extension:**
   - Open Burp Suite → Extensions → Add
   - Select the downloaded `burp-mcp-all.jar`
   - Enable the extension

3. **Configure VS Code MCP:**
   - Copy `config/vscode-mcp-config.json` to your VS Code user settings
   - Update paths to point to your downloaded JARs

4. **Start MCP Server:**
   - In Burp Suite, go to MCP tab
   - Enable MCP server (default: `http://127.0.0.1:9876`)

4. **Test Integration:**
   - Restart VS Code
   - Ask your AI assistant: *"Base64 encode Hello World"*

### 🔍 Verification

After installation, use our verification script to ensure everything is working correctly:

**Linux/macOS:**
```bash
chmod +x scripts/verify.sh
./scripts/verify.sh
```

**Windows:**
```cmd
scripts\verify.bat
```

**The verification script checks:**
- ✅ Java installation and version
- ✅ Burp MCP JAR files presence
- ✅ MCP proxy script functionality
- ✅ VS Code MCP configuration
- ✅ Connection to Burp MCP server
- ✅ End-to-end MCP communication

**Expected output:**
```
=== Burp MCP Setup Verification ===
1. Checking Java installation...          ✅ Java found
2. Checking Burp MCP JAR files...          ✅ JARs found
3. Checking MCP proxy script...            ✅ Proxy ready
4. Checking VS Code MCP configuration...   ✅ Config valid
5. Testing MCP connection...               ✅ Connection OK
6. Verifying Burp MCP server...           ✅ Server responding

=== All checks passed! Ready to use ===
```

## 🛠️ Available Tools

### 🌐 HTTP Request Tools
- `mcp_burp_send_http1_request` - Send HTTP/1.1 requests
- `mcp_burp_send_http2_request` - Send HTTP/2 requests

### 🔄 Burp Integration
- `mcp_burp_create_repeater_tab` - Create new Repeater tabs
- `mcp_burp_send_to_intruder` - Send requests to Intruder

### 🔧 Encoding/Decoding
- `mcp_burp_base64_encode` / `mcp_burp_base64_decode`
- `mcp_burp_url_encode` / `mcp_burp_url_decode`
- `mcp_burp_generate_random_string`

### 📊 History & Analysis
- `mcp_burp_get_proxy_http_history` - Get proxy history
- `mcp_burp_get_proxy_http_history_regex` - Search proxy history
- `mcp_burp_get_proxy_websocket_history` - Get WebSocket history
- `mcp_burp_get_scanner_issues` - Get scanner findings

### ⚙️ Configuration & Control
- `mcp_burp_set_proxy_intercept_state` - Control proxy intercept
- `mcp_burp_set_task_execution_engine_state` - Control task execution
- `mcp_burp_output_project_options` - Export project config
- `mcp_burp_set_project_options` - Update project config

## 💡 Usage Examples

### Encoding/Decoding
```
🤖 "Base64 encode admin:password"
→ YWRtaW46cGFzc3dvcmQ=

🤖 "URL decode Hello%20World"
→ Hello World
```

### HTTP Requests
```
🤖 "Send a GET request to https://httpbin.org/get"
→ [Returns HTTP response with headers and body]

🤖 "Create a repeater tab with POST to /login"
→ [Creates new Repeater tab in Burp]
```

### History Analysis
```
🤖 "Show me the last 10 proxy history entries"
→ [Displays recent HTTP requests from proxy history]

🤖 "Search proxy history for 'login'"
→ [Shows all requests containing 'login']
```

### Configuration
```
🤖 "Enable proxy intercept"
→ [Enables Burp proxy intercept]

🤖 "Get current project configuration"
→ [Returns Burp project settings]
```

## 🔧 Configuration

### Environment Variables

- `BURP_MCP_URL`: Burp MCP server URL (default: `http://127.0.0.1:9876`)

### VS Code MCP Configuration

```json
{
    "servers": {
        "burp": {
            "type": "stdio",
            "command": "/path/to/burp-mcp-proxy.sh",
            "args": [],
            "env": {
                "BURP_MCP_URL": "http://127.0.0.1:9876"
            }
        }
    }
}
```

## 🛡️ Security Considerations

- **HTTP Request Permission**: The MCP server requires explicit permission for HTTP requests
- **History Access**: Proxy history access can be controlled in Burp MCP settings
- **Configuration Changes**: Project configuration changes require permission
- **Local Network Only**: MCP server runs on localhost by default

## 🐛 Troubleshooting

### First Steps: Use the Verification Script

If you encounter any issues, **always run the verification script first**:

**Linux/macOS:**
```bash
./scripts/verify.sh
```

**Windows:**
```cmd
scripts\verify.bat
```

This will identify most common configuration problems automatically.

### Common Issues

**❌ "Installation failed" or "Setup incomplete"**
- ✅ **Try the automated installer**: `./scripts/install.sh` (Linux/macOS) or `scripts\install.bat` (Windows)
- ✅ The install scripts handle JAR downloads and configuration automatically
- ✅ Run `./scripts/verify.sh` after installation to confirm everything is working

**❌ "JAR files not found"**
- ✅ JAR files are in [GitHub Releases](../../releases), not the repository
- ✅ **Use the install script** - it downloads them automatically
- ✅ Manual download: Get `burp-mcp-all.jar` and `mcp-proxy.jar` from releases

**❌ "Java not found"**
- Install Java 11+ and ensure it's in your PATH
- Verify with: `java -version`

**❌ "Burp MCP server not responding"**
- Start Burp Suite
- Load the extension: `burp-mcp-all.jar` (downloaded from releases)
- Enable MCP server in Burp MCP tab

**❌ "Tools not showing in VS Code"**
- Restart VS Code after configuration changes
- Check MCP configuration file location
- Verify proxy script is executable
- **Quick fix**: Re-run the install script to reconfigure everything

**❌ "Permission denied errors"**
- **Linux/macOS**: The install script automatically sets correct permissions
- Enable necessary permissions in Burp MCP extension settings
- Check "Enable tools that can edit your config" if needed

### Debug Mode

Enable verbose logging by setting environment variable:
```bash
export BURP_MCP_DEBUG=true
./bin/burp-mcp-proxy.sh
```

## 🏗️ Architecture

```
VS Code (AI Assistant)
    ↕ MCP Protocol (stdio)
burp-mcp-proxy.sh
    ↕ HTTP/SSE
Burp Suite (MCP Extension)
    ↕ Montoya API
Burp Suite Core
```

1. **VS Code** communicates with the proxy via MCP stdio protocol
2. **Proxy Server** (`mcp-proxy.jar`) translates stdio ↔ Server-Sent Events (SSE)
3. **Burp Extension** (`burp-mcp-all.jar`) provides MCP server via SSE
4. **Burp Core** executes the actual operations via Montoya API

## 📚 Technical Details

### Built From
- **Base Repository**: [PortSwigger/mcp-server](https://github.com/PortSwigger/mcp-server)
- **Proxy Repository**: [PortSwigger/mcp-proxy](https://github.com/PortSwigger/mcp-proxy)
- **Build Tool**: Gradle 8.10
- **Language**: Kotlin + Java
- **MCP Version**: 1.0

### Build Information
- **Burp Extension**: 28MB (includes embedded proxy server)
- **Proxy Server**: 12MB standalone JAR
- **Java Version**: Compiled with OpenJDK 21, compatible with Java 11+
- **Burp API**: Montoya API (Burp Suite Extensions API)

## 🤝 Contributing

This package is built from the official PortSwigger repositories. For bugs and feature requests:

- **Burp Extension Issues**: [PortSwigger/mcp-server](https://github.com/PortSwigger/mcp-server/issues)
- **Proxy Issues**: [PortSwigger/mcp-proxy](https://github.com/PortSwigger/mcp-proxy/issues)
- **Package Issues**: Open an issue in this repository

## 📄 License

This package contains software from:
- **PortSwigger MCP Server**: [License](https://github.com/PortSwigger/mcp-server/blob/main/LICENSE)
- **PortSwigger MCP Proxy**: [License](https://github.com/PortSwigger/mcp-proxy/blob/main/LICENSE)

## 🙏 Acknowledgments

- **PortSwigger** for creating the excellent Burp Suite MCP integration
- **Model Context Protocol** team for the MCP specification
- **Anthropic** for pioneering AI-tool integration patterns

---

## 🎯 Quick Test

After installation, try these commands with your AI assistant in VS Code:

1. **"Base64 encode Hello World"** → Should return: `SGVsbG8gV29ybGQ=`
2. **"Generate a random 10-character string"** → Should return a random string
3. **"Show me the proxy history"** → Should display recent Burp proxy traffic
4. **"Create a repeater tab with GET https://example.com"** → Should create a new tab in Burp

If these work, your integration is fully functional! 🎉

---

**Made with ❤️ for the penetration testing community**
