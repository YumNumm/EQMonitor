# iOS ビルドが `jma_code_table.json` 欠落で失敗する（既存不具合）

## 解決 (2026-07-28)

Approach B: `stage_from_release.sh --target ios-native` が slim JSON を
ビルド時配置。詳細は
`docs/superpowers/specs/2026-07-28-ios-native-jma-code-table-staging-design.md`。

## 症状

`mise exec -- flutter build ios --no-codesign`（`app/`）が以下で失敗する:

```
Error (Xcode): The file "jma_code_table.json" couldn't be opened because there is no such file.
```

Swift のコンパイル自体は成功し（`AssetDownloader` 拡張含む）、Copy Bundle Resources
フェーズで落ちる。Background Assets 対応（`AssetDownloader` 拡張追加）とは**無関係**。

## 原因

コミット `5b9a11d55`「feat: 地図と Parameters を Asset Pack のみから読む」で
`app/assets/parameters/jma_code_table.json` を含む同梱パラメータが削除された
（Flutter 実行時は Asset Pack から読むようになった）。しかし以下が依然として
バンドルリソースとして `jma_code_table.json` を参照している:

- `app/ios/Runner.xcodeproj/project.pbxproj`（Runner / WidgetExtension / AppIntentExtension の Copy Bundle Resources）
- `app/ios/AppIntentExtension/JmaCodeTable.swift`（`Bundle.main.url(forResource: "jma_code_table", withExtension: "json")`）
- `app/lib/core/gen/assets.gen.dart`（`assets/parameters/jma_code_table.json`）

`app/assets/parameters/` には現在 `Untitled`（7 byte のゴミファイル）しか無く、
`jma_code_table.json` は git 追跡外。`origin/develop`（ローカルより 5 コミット先行）
でも同じ状態で、pbxproj の参照だけが残っている → develop でも iOS ビルドが壊れている
可能性が高い。

## 検討事項（要判断）

AppIntentExtension（Siri / ショートカットの地域選択）はネイティブ側で
`jma_code_table.json` を必要とするため、単純に参照を消すのではなく方針決定が必要:

- 案A: ネイティブ用に `jma_code_table.json` を（生成 or コミットで）バンドルへ復活させる
- 案B: AppIntentExtension も Asset Pack / App Group 経由で読むよう変更し、
  native の同梱参照（pbxproj / JmaCodeTable.swift / assets.gen.dart）を全て除去する

いずれにせよ「生命に関わる情報を扱う」ため、固定値フォールバックは禁止。
実データの供給経路を確定させてから実装すること。

## 参考

- `app/ios/scripts/share_intents_with_widget.rb` / `add_design_resources.rb` が
  `../assets/parameters/jma_code_table.json` を AppIntentExtension / Widget に
  同梱する前提のスクリプト。
