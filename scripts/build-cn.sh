#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
UPSTREAM_DIR="${ROOT_DIR}/upstream/CodexBar"

"${ROOT_DIR}/scripts/apply-cn.sh"

cd "${UPSTREAM_DIR}"
swift build -c release --product CodexBar
