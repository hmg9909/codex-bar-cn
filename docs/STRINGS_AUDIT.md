# CodexBar Chinese Patch String Audit

Upstream commit: `82bbcde911b3493a99f4c1a12df6cfccf7322519`

Scope: menu bar popup main UI and Settings -> Providers -> Codex. No auth, Keychain, OAuth, cookie, network, CLI RPC, PTY fallback, or quota-fetching logic is changed.

## Source Locations

- Menu popup: `Sources/CodexBar/MenuDescriptor.swift`
- Menu card: `Sources/CodexBar/MenuCardView.swift`
- Menu history/extras: `Sources/CodexBar/StatusItemController+Menu.swift`, `Sources/CodexBar/StatusItemController+UsageHistoryMenu.swift`
- Shared display formatting: `Sources/CodexBarCore/UsageFormatter.swift`, `Sources/CodexBar/UsagePaceText.swift`
- Codex labels: `Sources/CodexBarCore/Providers/Codex/CodexProviderDescriptor.swift`
- Settings tabs/detail: `Sources/CodexBar/PreferencesView.swift`, `Sources/CodexBar/PreferencesProviderDetailView.swift`
- Codex settings: `Sources/CodexBar/PreferencesProvidersPane.swift`, `Sources/CodexBar/PreferencesCodexAccountsSection.swift`, `Sources/CodexBar/Providers/Codex/CodexProviderImplementation.swift`

## Covered Strings

| English | Chinese | Status |
| --- | --- | --- |
| Updated just now | 刚刚更新 | covered |
| Session | 5 小时额度 | covered for Codex |
| Weekly | 每周额度 | covered for Codex |
| left | 剩余 | covered |
| Resets in | 后重置 | covered |
| Runs out in | 预计后用尽 | covered |
| in deficit | 已超额 | covered |
| Credits | 余额 | covered |
| Buy Credits... | 购买余额... | covered |
| Cost | 消耗 | covered |
| Today | 今天 | covered |
| Last 30 days | 最近 30 天 | covered |
| Subscription Utilization | 订阅使用情况 | covered |
| Add Account... | 添加账号... | covered for Codex |
| System Account | 系统账号 | covered |
| Usage Dashboard | 使用仪表盘 | covered |
| Status Page | 状态页 | covered |
| Partial System Degradation | 部分服务降级 | covered |
| Refresh | 刷新 | covered |
| Settings... | 设置... | covered |
| About CodexBar | 关于 CodexBar | covered |
| Quit | 退出 | covered |
| Providers | 提供商 | covered |
| Display | 显示 | covered |
| Advanced | 高级 | covered |
| About | 关于 | covered |
| State | 状态 | covered |
| Enabled | 已启用 | covered |
| Source | 来源 | covered |
| Version | 版本 | covered |
| Updated | 更新时间 | covered |
| Status | 状态 | covered |
| Account | 账号 | covered |
| Plan | 订阅 | covered |
| Usage | 使用情况 | covered |
| Settings | 设置 | covered |
| Menu bar metric | 菜单栏指标 | covered |
| Automatic | 自动 | covered |
| Choose which window drives the menu bar percent. | 选择菜单栏百分比使用哪个额度窗口。 | covered |
| Usage source | 用量来源 | covered |
| Auto | 自动 | covered |
| Auto falls back to the next source if the preferred one fails. | 首选来源失败时，自动切换到下一个来源。 | covered |
| Accounts | 账号 | covered |
| Active | 当前使用 | covered |
| Choose which Codex account CodexBar should follow. | 选择 CodexBar 跟随的 Codex 账号。 | covered |
| System | 系统 | covered |
| The default Codex account on this Mac. | 此 Mac 上的默认 Codex 账号。 | covered |
| Re-auth | 重新认证 | covered |
| Remove | 移除 | covered for Codex account controls |
| Add Account | 添加账号 | covered |
| Options | 选项 | covered |
| Historical tracking | 历史跟踪 | covered |
| Stores local Codex usage history (8 weeks) to personalize Pace predictions. | 保存本地 Codex 使用历史（8 周），用于个性化预测用尽时间。 | covered |
| OpenAI web extras | OpenAI 网页增强 | covered |
| Optional. Turn this on to show code review, usage breakdown, and credits history via chatgpt.com. | 可选。开启后通过 chatgpt.com 显示代码审查额度、用量明细和余额历史。 | covered |

## Not Covered

- Same generic words in unrelated panes/providers, tests, docs, CLI output, parser literals, logs, widgets, and accessibility labels are intentionally left English unless they are part of the scoped menu popup or Settings -> Providers -> Codex path.
- Dynamic service incident text other than the known `Partial System Degradation` phrase is left as returned by the upstream status provider.
