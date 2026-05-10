# CodexBar Chinese Patch Maintenance

This repository keeps the Chinese UI patch as a replayable source patch. It does not modify the installed official app and does not patch binaries.

## Layout

- `upstream/CodexBar/`: official source checkout.
- `patches/codexbar-zh-Hans.patch`: replayable Chinese patch.
- `scripts/sync-upstream.sh`: update the upstream checkout.
- `scripts/apply-cn.sh`: apply the Chinese patch to a clean upstream checkout.
- `scripts/build-cn.sh`: apply the patch and build the SwiftPM `CodexBar` product.
- `scripts/package-cn.sh`: package `dist/CodexBar CN.app` from the patched source build.
- `docs/STRINGS_AUDIT.md`: current string coverage audit.

## Sync Official Upstream

From this directory:

```bash
./scripts/sync-upstream.sh
```

The script refuses to sync if `upstream/CodexBar` has local changes. Commit, stash, or reset intentionally before syncing.

## Reapply Chinese Patch

```bash
./scripts/apply-cn.sh
```

If the patch is already applied, the script exits without changing files. If upstream changed the edited Swift files, resolve `git apply --check` conflicts inside `upstream/CodexBar`, regenerate the patch, and update `docs/STRINGS_AUDIT.md`.

## Regenerate Patch

After editing only scoped display strings in `upstream/CodexBar`:

```bash
git -C upstream/CodexBar diff --output=patches/codexbar-zh-Hans.patch -- Sources/CodexBar Sources/CodexBarCore
```

Keep auth, Keychain, cookie, network, OAuth, CLI RPC, PTY fallback, and quota-fetching logic out of the patch.

## Build

```bash
./scripts/build-cn.sh
```

This calls SwiftPM from the official source checkout. The first build may fetch SwiftPM dependencies.

## Package CodexBar CN.app

```bash
./scripts/package-cn.sh
```

The script calls the official `Scripts/package_app.sh`, copies the result to `dist/CodexBar CN.app`, changes the local bundle id to `com.local.codexbar.cn` by default, disables Sparkle auto checks for the CN copy, and ad-hoc signs the copied app.

Override the local id if needed:

```bash
CN_BUNDLE_ID=com.example.codexbar.cn ./scripts/package-cn.sh
```

## Manual Verification

1. Launch `dist/CodexBar CN.app`.
2. Open the menu bar popup.
3. Open Settings -> Providers -> Codex.
4. Verify the scoped Chinese strings listed in `docs/STRINGS_AUDIT.md`.
5. Confirm current Codex quota still displays.
6. Confirm refresh, account switching, add account, re-auth, and remove controls still trigger the same upstream actions.
