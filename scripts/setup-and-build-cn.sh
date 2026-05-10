#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

need() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "ERROR: missing required command: $1" >&2
    exit 1
  fi
}

need git
need swift
need xcode-select
need codesign
need ditto

if ! xcode-select -p >/dev/null 2>&1; then
  echo "ERROR: Xcode Command Line Tools are not configured." >&2
  echo "Run: xcode-select --install" >&2
  exit 1
fi

echo "==> Swift"
swift --version

echo "==> Git"
git --version

echo "==> Applying Chinese patch"
"${ROOT_DIR}/scripts/apply-cn.sh"

echo "==> Building"
"${ROOT_DIR}/scripts/build-cn.sh"

echo "==> Packaging"
"${ROOT_DIR}/scripts/package-cn.sh"

echo "Done: ${ROOT_DIR}/dist/CodexBar CN.app"
