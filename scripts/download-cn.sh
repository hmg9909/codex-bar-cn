#!/usr/bin/env bash
set -euo pipefail

REPO="${REPO:-hmg9909/codex-bar-cn}"
ASSET_URL="https://github.com/${REPO}/releases/latest/download/CodexBar-CN.zip"
OUT_DIR="${OUT_DIR:-$PWD}"
ZIP_PATH="${OUT_DIR}/CodexBar-CN.zip"

command -v curl >/dev/null 2>&1 || {
  echo "ERROR: curl is required." >&2
  exit 1
}

command -v unzip >/dev/null 2>&1 || {
  echo "ERROR: unzip is required." >&2
  exit 1
}

mkdir -p "${OUT_DIR}"
curl -L -o "${ZIP_PATH}" "${ASSET_URL}"
unzip -o "${ZIP_PATH}" -d "${OUT_DIR}"

echo "Downloaded and extracted: ${OUT_DIR}/CodexBar CN.app"
echo "Launch with: open \"${OUT_DIR}/CodexBar CN.app\""
