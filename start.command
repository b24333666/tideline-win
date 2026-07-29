#!/bin/bash
# 潮位 TIDELINE — macOS 啟動器(對應 Windows 的 start.bat)
set -u
cd "$(dirname "$0")"

PORT="${1:-3000}"

# ---- 尋找 Node:本地可攜版優先,其次系統 PATH,再次 Homebrew 常見路徑 ----
NODE_BIN=""
if [ -x "runtime/node" ]; then
  NODE_BIN="./runtime/node"
elif command -v node >/dev/null 2>&1; then
  NODE_BIN="node"
elif [ -x "/opt/homebrew/bin/node" ]; then
  NODE_BIN="/opt/homebrew/bin/node"   # Apple Silicon Homebrew
elif [ -x "/usr/local/bin/node" ]; then
  NODE_BIN="/usr/local/bin/node"      # Intel Homebrew
fi

# ---- 沒有 Node:自動下載可攜版(依晶片選 arm64 / x64,只需一次) ----
if [ -z "$NODE_BIN" ]; then
  ARCH="$(uname -m)"
  case "$ARCH" in
    arm64)  PKG="node-v20.18.1-darwin-arm64" ;;
    x86_64) PKG="node-v20.18.1-darwin-x64" ;;
    *) echo "無法辨識的架構:$ARCH;請自行安裝 Node.js LTS(https://nodejs.org)後重試。"; read -r -p "按 Enter 關閉"; exit 1 ;;
  esac
  echo "此電腦沒有 Node.js,下載可攜版(約 40MB,只需一次)…"
  curl -fL "https://nodejs.org/dist/v20.18.1/${PKG}.tar.gz" -o node_tmp.tar.gz || {
    echo "下載失敗。請安裝 Node.js LTS(https://nodejs.org)後重新執行本檔。"; read -r -p "按 Enter 關閉"; exit 1; }
  mkdir -p runtime_tmp && tar -xzf node_tmp.tar.gz -C runtime_tmp && rm -f node_tmp.tar.gz
  mkdir -p runtime && mv "runtime_tmp/${PKG}/bin/node" runtime/node && rm -rf runtime_tmp
  chmod +x runtime/node
  NODE_BIN="./runtime/node"
  echo "可攜版 Node 就緒。"
fi

echo
echo " ======================================================"
echo "  TIDELINE 啟動中:  http://localhost:${PORT}"
echo "  請保持此視窗開啟;按 Ctrl+C 停止。"
echo " ======================================================"
echo
( sleep 3; open "http://localhost:${PORT}" ) &

export PORT HOSTNAME=127.0.0.1
exec "$NODE_BIN" app/server.js
