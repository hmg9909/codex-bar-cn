#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
UPSTREAM_DIR="${ROOT_DIR}/upstream/CodexBar"
UPSTREAM_URL="${UPSTREAM_URL:-https://github.com/steipete/CodexBar.git}"
UPSTREAM_REF="${UPSTREAM_REF:-main}"

if [[ ! -d "${UPSTREAM_DIR}/.git" ]]; then
  mkdir -p "$(dirname "${UPSTREAM_DIR}")"
  git clone "${UPSTREAM_URL}" "${UPSTREAM_DIR}"
fi

if ! git -C "${UPSTREAM_DIR}" diff --quiet || ! git -C "${UPSTREAM_DIR}" diff --cached --quiet; then
  echo "ERROR: upstream/CodexBar has local changes. Commit, stash, or reset them before syncing." >&2
  exit 1
fi

git -C "${UPSTREAM_DIR}" fetch origin
git -C "${UPSTREAM_DIR}" checkout "${UPSTREAM_REF}"
git -C "${UPSTREAM_DIR}" pull --ff-only origin "${UPSTREAM_REF}"
git -C "${UPSTREAM_DIR}" rev-parse HEAD
