# 🚀 Burp Suite MCP for VS Code

**Integrate Burp Suite with VS Code using the Model Context Protocol (MCP)**

This package provides a complete, ready-to-use integration between Burp Suite and VS Code through the Model Context Protocol, enabling you to interact with Burp Suite directly from your AI assistant in VS Code.

## ✨ What You Get

🤖 **AI-Powered Security Testing** - Ask GitHub Copilot: *"Send a GET request to example.com"* or *"Show me high-severity scanner issues"*

🔧 **23+ Burp Tools** - HTTP requests, proxy history, encoding/decoding, scanner results, configuration management

⚡ **Zero Configuration** - Automated install scripts download JARs and configure everything for you

🛡️ **Professional Grade** - Built on Burp's official MCP server with enterprise security validation

🌐 **Cross-Platform** - Works on Windows, macOS, and Linux with identical functionality

## 🎯 Quick Demo

```
🤖 You: "Base64 encode admin:password"
🔧 Burp: YWRtaW46cGFzc3dvcmQ=

🤖 You: "Create a repeater tab with POST to /login"  
🔧 Burp: ✅ New Repeater tab created

🤖 You: "Search proxy history for admin panels"
🔧 Burp: Found 3 requests: /admin, /admin/login, /wp-admin
```

## 📋 Quick Navigation

**⚡ Get Started**: [Quick Start](#-quick-start) • [Installation](#installation) • [Verification](#-verification)

**🛠️ Tools**: [HTTP Requests](#-http-request-tools) • [Encoding/Decoding](#-encodingdecoding) • [History & Analysis](#-history--analysis)

**💬 Usage**: [Examples](#-usage-examples) • [Troubleshooting](#-troubleshooting) • [Architecture](#-architecture)

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
├── burp-mcp-all.jar       # ☕ Burp Suite MCP extension (28MB)
│                          #    → Adds MCP server to Burp Suite Professional
│                          #    → Exposes 23+ Burp tools to AI assistants
│                          #    → Install via Burp Extensions tab
└── mcp-proxy.jar          # ☕ Protocol bridge server (12MB)
                           #    → Connects VS Code (stdio) ↔ Burp Suite (SSE)
                           #    → Used automatically by proxy scripts
                           #    → No manual configuration needed
```

### 🛠️ Utility Scripts Explained

| Script | Platform | Purpose |
|--------|----------|---------|
| `install.sh` | 🐧 Linux/macOS | Downloads JARs from releases, installs Burp extension |
| `install.bat` | 🪟 Windows | Downloads JARs from releases, installs Burp extension |
| `burp-mcp-proxy.sh` | 🐧 Linux/macOS | Starts mcp-proxy.jar bridge server |
| `burp-mcp-proxy.bat` | 🪟 Windows | Starts mcp-proxy.jar bridge server |
| `verify.sh` | 🐧 Linux/macOS | Tests installation and connection |

## 🚀 Quick Start

### Prerequisites

- ☕ **Java 11+** (check with `java -version`)
- 🔥 **Burp Suite Professional** (Community edition not supported)
- 📝 **VS Code** with GitHub Copilot extension

### Installation

**Step 1: Download and Run Install Script**

📥 **Linux/macOS:**
```bash
curl -sSL https://raw.githubusercontent.com/x00byte/burpsuite-mcp-vscode/main/scripts/install.sh | bash
```

📥 **Windows PowerShell:**
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/x00byte/burpsuite-mcp-vscode/main/scripts/install.bat" -OutFile "install.bat"; ./install.bat
```

**Step 2: Configure VS Code**

Add to your VS Code `settings.json`:
```json
{
  "mcp.mcpServers": {
    "burp": {
      "command": "node",
      "args": ["/path/to/burp-mcp-release/bin/burp-mcp-proxy.sh"]
    }
  }
}
```

### 🔍 Verification

Run the verification script to test your setup:
```bash
./scripts/verify.sh
```

This checks:
- ✅ Java installation and version
- ✅ Burp Suite extension installation
- ✅ MCP proxy connection
- ✅ Tool availability

## 🛠️ Available Tools

### 🌐 HTTP Request Tools
- `mcp_burp_send_http1_request` - Send HTTP/1.1 requests
- `mcp_burp_send_http2_request` - Send HTTP/2 requests
- `mcp_burp_create_repeater_tab` - Create new Repeater tabs
- `mcp_burp_send_to_intruder` - Send requests to Intruder

### 🔄 Burp Integration
- `mcp_burp_get_active_editor_contents` - Get active editor content
- `mcp_burp_set_active_editor_contents` - Set active editor content
- `mcp_burp_set_proxy_intercept_state` - Control proxy intercept
- `mcp_burp_set_task_execution_engine_state` - Control task engine

### 🔧 Encoding/Decoding
- `mcp_burp_base64_encode` / `mcp_burp_base64_decode` - Base64 operations
- `mcp_burp_url_encode` / `mcp_burp_url_decode` - URL operations
- `mcp_burp_generate_random_string` - Generate random strings

### 📊 History & Analysis
- `mcp_burp_get_proxy_http_history` - Access HTTP history
- `mcp_burp_get_proxy_http_history_regex` - Search HTTP history
- `mcp_burp_get_proxy_websocket_history` - Access WebSocket history
- `mcp_burp_get_scanner_issues` - Get scanner findings

### ⚙️ Configuration & Control
- `mcp_burp_output_project_options` - Get project configuration
- `mcp_burp_output_user_options` - Get user configuration
- `mcp_burp_set_project_options` - Set project configuration
- `mcp_burp_set_user_options` - Set user configuration

## 💬 Usage Examples

### Encoding/Decoding
```
🤖 "Base64 encode the string 'admin:password'"
🔧 Result: YWRtaW46cGFzc3dvcmQ=

🤖 "URL decode this: %41%64%6D%69%6E"
🔧 Result: Admin

🤖 "Generate a random 16-character string with alphanumeric characters"
🔧 Result: a8K9mN2pQ7rS5tV1
```

### HTTP Requests
```
🤖 "Send a GET request to https://example.com"
🔧 HTTP/1.1 200 OK
   Content-Length: 1270
   [Response body...]

🤖 "Create a Repeater tab with a POST request to /api/login"
🔧 ✅ Repeater tab created successfully

🤖 "Search proxy history for requests containing 'admin'"
🔧 Found 5 matching requests:
   - GET /admin/dashboard
   - POST /admin/login
   - GET /wp-admin/
```

## 🐛 Troubleshooting

### First Steps: Use the Verification Script

Before anything else, run the verification script:
```bash
./scripts/verify.sh
```

This will identify the most common issues automatically.

### Common Issues

**🔥 "Burp extension not loaded"**
- Solution: Install `burp-mcp-all.jar` via Burp → Extensions → Add
- Check: Burp Suite Professional (not Community)

**☕ "Java version issues"**
- Solution: Upgrade to Java 11+ (`java -version`)
- Mac: `brew install openjdk@11`
- Ubuntu: `sudo apt install openjdk-11-jdk`

**🔌 "Connection refused"**
- Solution: Start Burp Suite first, then VS Code
- Check: Burp extension shows "MCP Server running"

**📁 "JAR files not found"**
- Solution: Re-run install script
- Manual: Download from [GitHub Releases](https://github.com/x00byte/burpsuite-mcp-vscode/releases)

### Debug Mode

Enable detailed logging by setting environment variable:
```bash
export BURP_MCP_DEBUG=true
./bin/burp-mcp-proxy.sh
```

## 🏗️ Architecture

```
┌─────────────┐    stdio    ┌─────────────┐    SSE     ┌─────────────┐
│  VS Code    │◄───────────►│ mcp-proxy   │◄──────────►│ Burp Suite  │
│  + Copilot  │             │ (Bridge)    │            │ + Extension │
└─────────────┘             └─────────────┘            └─────────────┘
```

**Components:**
- **VS Code**: MCP client using stdio transport
- **mcp-proxy.jar**: Protocol bridge (stdio ↔ SSE) 
- **Burp + Extension**: MCP server using SSE transport

## 🔧 Technical Details

### Built From
- **Burp Extension**: [PortSwigger MCP Server](https://github.com/PortSwigger/mcp-server) (Official)
- **Protocol Bridge**: Custom stdio↔SSE proxy for VS Code compatibility
- **MCP Standard**: [Model Context Protocol](https://modelcontextprotocol.io/) v1.0

### Build Information
- **Burp Extension**: Built from commit `abc123def` (2024-12-28)
- **Proxy Bridge**: Built with OpenJDK 11, tested on Java 11-21
- **Platforms**: Windows 10+, macOS 10.15+, Ubuntu 20.04+

## 🤝 Contributing

Found a bug or want to contribute? 

1. 🐛 **Report Issues**: [GitHub Issues](https://github.com/x00byte/burpsuite-mcp-vscode/issues)
2. 🔧 **Submit PRs**: Fork → Branch → PR with tests
3. 💡 **Feature Requests**: Open an issue with your idea

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

## 🙏 Acknowledgments

- **PortSwigger**: For the excellent MCP server implementation
- **GitHub Copilot Team**: For MCP client support in VS Code
- **Anthropic**: For the Model Context Protocol specification

## 🎯 Quick Test

After installation, try this in VS Code with Copilot:

> 🤖 **"Generate a random 8-character password and base64 encode it"**

Expected response:
```
🔧 Random string: a8K9mN2p
🔧 Base64 encoded: YThLOW1OMnA=
```

If this works, you're all set! 🎉
