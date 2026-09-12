# 統合 Live Activity の配信前提を解消する

Issue: [EQMonitor #1800](https://github.com/YumNumm/EQMonitor/issues/1800)
調査日: 2026-09-12。計画作成のみで、以下は未修正・未検証。

## OS 対応判定

- `packages/live_activity_util/ios/live_activity_util/Sources/live_activity_util/EQMLiveActivityUtil.swift` の `guard #available(iOS 26.1, *), !ProcessInfo.processInfo.isiOSAppOnVision else { return false }` は、通常のiPhoneでも26.1未満を除外する。
- Dart の `PushTokenPlatformCapabilities` は18以上をpush-to-start対応とするため不一致がある。
- availability とデバイス除外を分離し、17.6 / 18 / 26.0 / 26.1 / Mac / Vision の境界をテストする。token取得を実機でも確認する。

## 新形式の配信検証

- 現行の `apnsEnvironmentProvider` と Runner.entitlements は production で一致している。これ自体をバグとして development に変更しない。
- sandbox用署名ビルドでは登録環境もdevelopmentにする。最終署名とrequestの一致を確認する検証入口を用意する。
- 2026-09-12のユーザー指示で破壊変更を採用。旧形式の互換・移行・普及率待ちは検証前提から除外する。新形式の実配信を検証する。
- backend #1203 はマージ済みだが調査中に Go Build / Format の失敗を確認した。リリース時に失敗原因・後続修正・最終CIを再確認する。
- backend DB適用済みは既存記録による。サービス配備、prefix一致、実 token / Broadcast の Start→Update→End は別途検証する。

完了条件は [実装計画の Task 6–7 と配信検証](../superpowers/plans/2026-09-12-unified-live-activity-ios.md)に従う。解消した項目に実施結果を追記し、契約・実機検証・本番有効化を区別する。
