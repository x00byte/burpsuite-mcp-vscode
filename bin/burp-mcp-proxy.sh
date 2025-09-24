#!/bin/bash
# Burp MCP Proxy Server Launcher
# This script starts the MCP proxy server that connects VS Code to Burp Suite
# 
# Usage: ./burp-mcp-proxy.sh
# Environment Variables:
#   BURP_MCP_URL - URL of the Burp MCP server (default: http://127.0.0.1:9876)

set -euo pipefail

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RELEASE_DIR="$(dirname "$SCRIPT_DIR")"

# Configuration
BURP_MCP_URL="${BURP_MCP_URL:-http://127.0.0.1:9876}"
JAR_PATH="$RELEASE_DIR/jars/mcp-proxy.jar"

# Validation
if [ ! -f "$JAR_PATH" ]; then
    echo "❌ Error: Burp MCP Proxy JAR not found at: $JAR_PATH" >&2
    echo "   Please ensure the JAR file is in the correct location." >&2
    exit 1
fi

if ! command -v java &> /dev/null; then
    echo "❌ Error: Java is not installed or not in PATH" >&2
    echo "   Please install Java 11 or later." >&2
    exit 1
fi

# Check Java version
java_version=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d. -f1)
if [ "$java_version" -lt 11 ]; then
    echo "❌ Error: Java 11 or later is required (found Java $java_version)" >&2
    exit 1
fi

# Start the MCP proxy server
echo "🚀 Starting Burp MCP Proxy Server..." >&2
echo "📡 Connecting to Burp MCP Server: $BURP_MCP_URL" >&2
echo "📦 Using JAR: $JAR_PATH" >&2
echo "---" >&2

exec java -jar "$JAR_PATH" --sse-url "$BURP_MCP_URL" "$@"
