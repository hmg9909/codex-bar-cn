#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
UPSTREAM_DIR="${ROOT_DIR}/upstream/CodexBar"
DIST_DIR="${ROOT_DIR}/dist"
CN_APP="${DIST_DIR}/CodexBar CN.app"
CN_BUNDLE_ID="${CN_BUNDLE_ID:-com.local.codexbar.cn}"
PLIST_BUDDY="/usr/libexec/PlistBuddy"

"${ROOT_DIR}/scripts/apply-cn.sh"

cd "${UPSTREAM_DIR}"
CODEXBAR_SIGNING="${CODEXBAR_SIGNING:-adhoc}" ./Scripts/package_app.sh release

mkdir -p "${DIST_DIR}"
if [[ -e "${CN_APP}" ]]; then
  echo "ERROR: ${CN_APP} already exists. Move it aside before packaging a new copy." >&2
  exit 1
fi
ditto "${UPSTREAM_DIR}/CodexBar.app" "${CN_APP}"

"${PLIST_BUDDY}" -c "Set :CFBundleName CodexBar CN" "${CN_APP}/Contents/Info.plist"
"${PLIST_BUDDY}" -c "Set :CFBundleDisplayName CodexBar CN" "${CN_APP}/Contents/Info.plist"
"${PLIST_BUDDY}" -c "Set :CFBundleIdentifier ${CN_BUNDLE_ID}" "${CN_APP}/Contents/Info.plist"
"${PLIST_BUDDY}" -c "Set :SUFeedURL " "${CN_APP}/Contents/Info.plist" >/dev/null 2>&1 || true
"${PLIST_BUDDY}" -c "Set :SUEnableAutomaticChecks false" "${CN_APP}/Contents/Info.plist" >/dev/null 2>&1 || true

if [[ -d "${CN_APP}/Contents/PlugIns/CodexBarWidget.appex" ]]; then
  WIDGET_PLIST="${CN_APP}/Contents/PlugIns/CodexBarWidget.appex/Contents/Info.plist"
  "${PLIST_BUDDY}" -c "Set :CFBundleIdentifier ${CN_BUNDLE_ID}.widget" "${WIDGET_PLIST}"
fi

codesign --force --deep --sign - "${CN_APP}"
echo "${CN_APP}"
