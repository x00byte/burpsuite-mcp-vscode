#!/bin/bash
# Burp MCP Installation Script for Linux/macOS
# This script installs the Burp MCP integration for VS Code

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RELEASE_DIR="$(dirname "$SCRIPT_DIR")"
VSCODE_CONFIG_DIR=""

# GitHub repository information
GITHUB_USER="x00byte"
GITHUB_REPO="burpsuite-mcp-vscode"
GITHUB_RELEASE_TAG="v1.0.0"
GITHUB_API_URL="https://api.github.com/repos/$GITHUB_USER/$GITHUB_REPO/releases/latest"

# Detect VS Code configuration directory
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    VSCODE_CONFIG_DIR="$HOME/Library/Application Support/Code/User"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    VSCODE_CONFIG_DIR="$HOME/.config/Code/User"
else
    echo "❌ Unsupported operating system: $OSTYPE"
    exit 1
fi

MCP_CONFIG_FILE="$VSCODE_CONFIG_DIR/mcp.json"
BURP_PROXY_SCRIPT="$RELEASE_DIR/bin/burp-mcp-proxy.sh"
JARS_DIR="$RELEASE_DIR/jars"

echo "🚀 Installing Burp MCP Integration for VS Code..."
echo ""

# Create directories
mkdir -p "$VSCODE_CONFIG_DIR"
mkdir -p "$JARS_DIR"

# Function to download JAR files from GitHub releases
download_jars() {
    echo "📥 Downloading JAR files from GitHub releases..."
    
    # Check if curl or wget is available
    if command -v curl &> /dev/null; then
        DOWNLOAD_CMD="curl -L -o"
    elif command -v wget &> /dev/null; then
        DOWNLOAD_CMD="wget -O"
    else
        echo "❌ Neither curl nor wget found. Please install one of them."
        echo "   sudo apt install curl    # Debian/Ubuntu"
        echo "   brew install curl        # macOS"
        return 1
    fi
    
    # Get latest release info
    echo "   Fetching latest release information..."
    if command -v curl &> /dev/null; then
        RELEASE_INFO=$(curl -s "$GITHUB_API_URL" 2>/dev/null || echo "")
    else
        RELEASE_INFO=$(wget -qO- "$GITHUB_API_URL" 2>/dev/null || echo "")
    fi
    
    if [[ -z "$RELEASE_INFO" ]]; then
        echo "⚠️  Could not fetch release info. Using manual download mode."
        echo "   Please download the following files manually:"
        echo "   - burp-mcp-all.jar"
        echo "   - mcp-proxy.jar"
        echo "   from: https://github.com/$GITHUB_USER/$GITHUB_REPO/releases/latest"
        echo "   and place them in: $JARS_DIR/"
        return 0
    fi
    
    # Extract download URLs (simple approach - could be enhanced with jq)
    BURP_JAR_URL=$(echo "$RELEASE_INFO" | grep -o '"browser_download_url":[[:space:]]*"[^"]*burp-mcp-all\.jar"' | cut -d'"' -f4 | head -1)
    PROXY_JAR_URL=$(echo "$RELEASE_INFO" | grep -o '"browser_download_url":[[:space:]]*"[^"]*mcp-proxy\.jar"' | cut -d'"' -f4 | head -1)
    
    # Download burp-mcp-all.jar
    if [[ -n "$BURP_JAR_URL" ]]; then
        echo "   Downloading burp-mcp-all.jar..."
        if command -v curl &> /dev/null; then
            curl -L -o "$JARS_DIR/burp-mcp-all.jar" "$BURP_JAR_URL"
        else
            wget -O "$JARS_DIR/burp-mcp-all.jar" "$BURP_JAR_URL"
        fi
    else
        echo "⚠️  Could not find burp-mcp-all.jar download URL"
    fi
    
    # Download mcp-proxy.jar
    if [[ -n "$PROXY_JAR_URL" ]]; then
        echo "   Downloading mcp-proxy.jar..."
        if command -v curl &> /dev/null; then
            curl -L -o "$JARS_DIR/mcp-proxy.jar" "$PROXY_JAR_URL"
        else
            wget -O "$JARS_DIR/mcp-proxy.jar" "$PROXY_JAR_URL"
        fi
    else
        echo "⚠️  Could not find mcp-proxy.jar download URL"
    fi
    
    echo "✅ JAR file download completed"
}

# Download JAR files if they don't exist
if [[ ! -f "$JARS_DIR/burp-mcp-all.jar" ]] || [[ ! -f "$JARS_DIR/mcp-proxy.jar" ]]; then
    download_jars
else
    echo "✅ JAR files already exist, skipping download"
fi

# Check if mcp.json exists
if [[ -f "$MCP_CONFIG_FILE" ]]; then
    echo "📝 Backing up existing MCP configuration..."
    cp "$MCP_CONFIG_FILE" "$MCP_CONFIG_FILE.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Create or update MCP configuration
echo "🔧 Configuring MCP servers..."
cat > "$MCP_CONFIG_FILE" << EOF
{
    "servers": {
        "burp": {
            "type": "stdio",
            "command": "$BURP_PROXY_SCRIPT",
            "args": [],
            "env": {
                "BURP_MCP_URL": "http://127.0.0.1:9876"
            }
        }
    },
    "inputs": []
}
EOF

echo "✅ Installation complete!"
echo ""
echo "📋 Next steps:"
echo "1. Start Burp Suite"
echo "2. Install the Burp extension: $RELEASE_DIR/jars/burp-mcp-all.jar"
echo "3. Enable MCP server in Burp (MCP tab)"
echo "4. Restart VS Code"
echo "5. Test with: 'Base64 encode Hello World'"
echo ""
echo "📄 Configuration saved to: $MCP_CONFIG_FILE"
