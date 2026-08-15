# ホーム画面ウィジェット / Live Activity の残課題

Live Activity・ホーム画面ウィジェットのバグ / デザイン不備の洗い出しで見つかった項目のうち、
まだ残っているもの。解決済みの項目は履歴として末尾に残す。

## 1. Widget Extension の UI に対する回帰テストがない

`WidgetModelsTests` はモデル・表記・レイアウト件数・表示判定（`EewDisplay` /
`WidgetRegionResolver`）を検証しているが、SwiftUI View のスナップショットテストは無い。

取消報での抑止や未入電バッジの収まり、Dynamic Island 展開時の切れ具合は Xcode Preview で
目視確認する運用（`docs/knowledge/20260717_home_widget_worktree_validation.md`）。

判断ロジックはできる限り Foundation のみに依存する型へ切り出し、
`WidgetModelsTests` から検証する方針を継続する。View そのものの検証を入れるなら
`swift-snapshot-testing` の導入を検討する（macOS ランナーが必要）。

## 2. Android のホーム画面ウィジェットは未実装

`AppWidgetProvider` / Glance の実装は無い。テンプレート由来の未使用リソース
（`Widget.Android.AppWidget.*` / `Theme.Android.AppWidgetContainer` / `AppWidgetAttrs` /
`widget_margin`）は削除済み。実装する場合は iOS 側と同じ
`WidgetRegionResolver` 相当の解決規則（Pro 未加入・未設定時は全国へフォールバック）を
踏襲すること。

## 3. iOS extension の CFBundleVersion が親アプリと不一致

`docs/todo/300_ios_extension_bundle_version_mismatch.md` を参照。

---

## 解決済み

- **Widget Extension の deployment target が iOS 26.0** で、iOS 17.6〜25 の端末では
  ウィジェットも Live Activity も利用できなかった → 17.6 へ引き下げ。
  ビルド検証が残っているため `docs/todo/920_verify_widget_extension_deployment_target.md` を参照。
- **API ベース URL のプロセス内キャッシュ** → ベース URL をキーにしたキャッシュへ変更。
- **`WidgetRegionResolver` が `region` / `station` を解釈しない** → `region` を対応、
  `station` は対応 API が無いため明示的に非対応とし、テストで固定。
