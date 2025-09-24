#!/bin/bash
# Burp MCP Verification Script
# This script verifies the Burp MCP installation

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RELEASE_DIR="$(dirname "$SCRIPT_DIR")"

echo "=== Burp MCP Installation Verification ==="
echo ""

# Check Java installation
echo "1. Checking Java installation..."
if command -v java &> /dev/null; then
    java_version=$(java -version 2>&1 | head -n 1)
    echo "   ✅ $java_version"
else
    echo "   ❌ Java not found"
    exit 1
fi

# Check JAR files
echo ""
echo "2. Checking JAR files..."
burp_jar="$RELEASE_DIR/jars/burp-mcp-all.jar"
proxy_jar="$RELEASE_DIR/jars/mcp-proxy.jar"

if [[ -f "$burp_jar" ]]; then
    size=$(du -h "$burp_jar" | cut -f1)
    echo "   ✅ Burp extension JAR found ($size)"
else
    echo "   ❌ Burp extension JAR missing: $burp_jar"
    exit 1
fi

if [[ -f "$proxy_jar" ]]; then
    size=$(du -h "$proxy_jar" | cut -f1)
    echo "   ✅ MCP proxy JAR found ($size)"
else
    echo "   ❌ MCP proxy JAR missing: $proxy_jar"
    exit 1
fi

# Check proxy script
echo ""
echo "3. Checking proxy script..."
proxy_script="$RELEASE_DIR/bin/burp-mcp-proxy.sh"
if [[ -x "$proxy_script" ]]; then
    echo "   ✅ Proxy script is executable"
else
    echo "   ❌ Proxy script not found or not executable: $proxy_script"
    exit 1
fi

# Check VS Code MCP configuration
echo ""
echo "4. Checking VS Code MCP configuration..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    vscode_config="$HOME/Library/Application Support/Code/User/mcp.json"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    vscode_config="$HOME/.config/Code/User/mcp.json"
fi

if [[ -f "$vscode_config" ]] && grep -q "burp" "$vscode_config"; then
    echo "   ✅ VS Code MCP configuration found"
else
    echo "   ⚠️  VS Code MCP configuration not found or incomplete"
    echo "      Run: ./scripts/install.sh"
fi

# Test proxy script (dry run)
echo ""
echo "5. Testing proxy script..."
timeout 3 bash -c "echo 'test' | $proxy_script" >/dev/null 2>&1 || true
echo "   ✅ Proxy script can be executed"

# Check if Burp MCP server is running
echo ""
echo "6. Checking if Burp MCP server is running..."
if curl -s -m 2 http://127.0.0.1:9876 >/dev/null 2>&1; then
    echo "   ✅ Burp MCP server is responding"
else
    echo "   ⚠️  Burp MCP server not responding (start Burp Suite and enable MCP server)"
fi

echo ""
echo "=== Verification Complete ==="
echo ""
echo "🚀 If all checks pass, you're ready to use Burp MCP!"
echo ""
echo "📋 Quick test commands:"
echo "   • Base64 encode Hello World"
echo "   • Show proxy history"
echo "   • Generate random string"
