#!/usr/bin/env bash
# ==============================================================================
# ArtCraft Suite - Automated Installer for Antigravity (macOS & Linux)
# ==============================================================================
set -e

echo -e "\033[1;35m================================================================="
echo -e "  ArtCraft Multi-Agent Suite - Automated Installer (Unix/macOS)"
echo -e "=================================================================\033[0m"

USER_HOME="${HOME}"
GEMINI_CONFIG="${USER_HOME}/.gemini/config"
SKILLS_DIR="${GEMINI_CONFIG}/skills"
MCP_CONFIG="${GEMINI_CONFIG}/mcp_config.json"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "\n\033[1;36m[ARTCRAFT] 1. Preparing directories...\033[0m"
mkdir -p "${SKILLS_DIR}"

echo -e "\n\033[1;36m[ARTCRAFT] 2. Installing Skills...\033[0m"
SKILLS=("artcraft" "artcraft-frontend" "artcraft-image" "artcraft-pitchdeck" "artcraft-sheet" "artcraft-video")

SOURCE_DIR="${SCRIPT_DIR}/skills"
if [ ! -d "${SOURCE_DIR}" ]; then
  SOURCE_DIR="${SCRIPT_DIR}"
fi

for skill in "${SKILLS[@]}"; do
  SRC="${SOURCE_DIR}/${skill}"
  if [ ! -d "${SRC}" ]; then
    SRC="${SCRIPT_DIR}/${skill}"
  fi
  if [ -d "${SRC}" ]; then
    rm -rf "${SKILLS_DIR}/${skill}"
    cp -r "${SRC}" "${SKILLS_DIR}/${skill}"
    echo -e "  \033[1;32m✔ Installed: ${skill}\033[0m"
  else
    echo -e "  \033[1;33m⚠ Skill source not found: ${skill}\033[0m"
  fi
done

echo -e "\n\033[1;36m[ARTCRAFT] 3. Configuring MCP servers in mcp_config.json...\033[0m"
if [ ! -f "${MCP_CONFIG}" ]; then
  echo '{"mcpServers": {}}' > "${MCP_CONFIG}"
fi

# Detect platform
OS_TYPE="$(uname -s)"
echo -e "  Detected OS: ${OS_TYPE}"

python3 - <<EOF || true
import json
import os

mcp_path = "${MCP_CONFIG}"
user_home = "${USER_HOME}"
os_type = "${OS_TYPE}"

try:
    with open(mcp_path, "r", encoding="utf-8") as f:
        data = json.load(f)
except Exception:
    data = {"mcpServers": {}}

servers = data.setdefault("mcpServers", {})

apps = [
    ("deckcraft", "DeckCraft", ["mcp"]),
    ("designcraft", "DesignCraft", ["mcp"]),
    ("effectcraft", "EffectCraft", ["mcp"]),
    ("figcraft", "FigCraft", ["mcp"]),
    ("filmcraft", "FilmCraft", ["mcp", "--compact"]),
    ("gridcraft", "GridCraft", ["mcp"]),
    ("lightcraft", "LightCraft", ["mcp", "--compact"]),
    ("pdfcraft", "PdfCraft", ["mcp", "--compact"]),
    ("photocraft", "PhotoCraft", ["mcp"]),
    ("vectorcraft", "VectorCraft", ["mcp", "--headless"])
]

for name, title, args in apps:
    if os_type == "Darwin":
        cmd = f"/Applications/{title}.app/Contents/MacOS/{name}-cli"
    else:
        cmd = f"{name}-cli"
    servers[name] = {
        "command": cmd,
        "args": args
    }

with open(mcp_path, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

print("  Successfully merged MCP servers into mcp_config.json")
EOF

echo -e "\n\033[1;32m================================================================="
echo -e "  INSTALLATION COMPLETE!"
echo -e "=================================================================\033[0m"
echo -e "  • Skills: ${SKILLS_DIR}"
echo -e "  • MCP Config: ${MCP_CONFIG}"
echo -e "\nRestart Antigravity or open a new conversation to begin using the suite."
