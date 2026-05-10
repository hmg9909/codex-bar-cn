#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
UPSTREAM_DIR="${ROOT_DIR}/upstream/CodexBar"
PATCH_FILE="${ROOT_DIR}/patches/codexbar-zh-Hans.patch"

if [[ ! -d "${UPSTREAM_DIR}" ]]; then
  echo "ERROR: missing upstream source at ${UPSTREAM_DIR}" >&2
  exit 1
fi

if ! git -C "${UPSTREAM_DIR}" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "ERROR: ${UPSTREAM_DIR} is not inside a git worktree." >&2
  exit 1
fi

if [[ ! -f "${PATCH_FILE}" ]]; then
  echo "ERROR: missing patch file at ${PATCH_FILE}" >&2
  exit 1
fi

if git -C "${UPSTREAM_DIR}" apply --reverse --check "${PATCH_FILE}" >/dev/null 2>&1; then
  echo "Chinese patch is already applied."
  exit 0
fi

git -C "${UPSTREAM_DIR}" apply --check "${PATCH_FILE}"
git -C "${UPSTREAM_DIR}" apply "${PATCH_FILE}"
echo "Applied Chinese patch: ${PATCH_FILE}"
