# CodexBar CN

CodexBar CN 是基于开源项目 [steipete/CodexBar](https://github.com/steipete/CodexBar) 维护的中文界面补丁包。

维护方式是 **官方源码副本 + 中文 patch + 一键脚本**：

- 不修改官方已安装的 App。
- 不做二进制 patch。
- 不破坏 macOS 签名；打包出的 CN App 使用本地 ad-hoc 签名。
- 只覆盖菜单栏弹窗主界面和 Settings -> Providers -> Codex 的主要文案。

## 直接下载

下载最新版：

https://github.com/hmg9909/codex-bar-cn/releases/latest/download/CodexBar-CN.zip

命令行下载：

```bash
curl -L -o CodexBar-CN.zip https://github.com/hmg9909/codex-bar-cn/releases/latest/download/CodexBar-CN.zip
unzip CodexBar-CN.zip
open "CodexBar CN.app"
```

也可以运行：

```bash
./scripts/download-cn.sh
```

## 本地构建环境

需要：

- macOS 14+
- Xcode 或 Command Line Tools
- Swift 6 工具链
- `git`
- 可访问 GitHub 和 SwiftPM 依赖源

检查环境：

```bash
xcode-select -p
swift --version
git --version
```

## 一键构建

```bash
./scripts/setup-and-build-cn.sh
```

脚本会：

1. 检查基础环境。
2. 应用 `patches/codexbar-zh-Hans.patch`。
3. 使用 SwiftPM 构建 CodexBar。
4. 调用官方 `Scripts/package_app.sh`。
5. 生成 `dist/CodexBar CN.app`。

## 单步操作

同步官方源码：

```bash
./scripts/sync-upstream.sh
```

应用中文补丁：

```bash
./scripts/apply-cn.sh
```

构建：

```bash
./scripts/build-cn.sh
```

打包：

```bash
./scripts/package-cn.sh
```

## 目录说明

- `upstream/CodexBar/`：当前已打好中文补丁的 CodexBar 源码副本。
- `patches/codexbar-zh-Hans.patch`：可重放中文补丁。
- `scripts/`：同步、应用补丁、构建、打包、下载脚本。
- `docs/STRINGS_AUDIT.md`：文案覆盖审计。
- `docs/MAINTENANCE.md`：长期维护流程。

## 维护原则

- 只改展示层文案。
- 菜单栏弹窗里直接展示给用户的 Codex 错误提示也属于展示层文案，需要翻译。
- 不改额度读取、账号切换、OAuth、Keychain、cookie、网络请求、CLI RPC、PTY fallback 等核心逻辑。
- 不提交 token、cookie、auth.json、Keychain 数据、缓存文件或构建缓存。
- 上游更新后，重新应用 patch，冲突只在展示层解决。

当前基线 upstream commit：

```text
82bbcde911b3493a99f4c1a12df6cfccf7322519
```
