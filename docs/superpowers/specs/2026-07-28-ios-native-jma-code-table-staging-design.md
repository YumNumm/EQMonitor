# iOS native `jma_code_table.json` build-time staging (slim extract)

## Problem

`develop` の `deploy-app` Build iOS が次で失敗する:

```text
lstat(.../app/assets/parameters/jma_code_table.json): No such file or directory
(in target 'WidgetExtension' / AppIntentExtension)
```

地図・パラメータは Asset Pack（Background Assets）へ移し、
`app/assets/parameters/jma_code_table.json` は git から消えた。一方で
Xcode の Copy Bundle Resources と `AppIntentExtension/JmaCodeTable.swift` は
依然として同パスのバンドルリソースを前提にしている。

Flutter / メインアプリは既に Asset Pack から読む。壊れているのは
**ネイティブ拡張（Siri / ショートカットの地域選択）向けの同梱**だけである。

関連: `docs/todo/850_ios_missing_jma_code_table_json_build_break.md`

## Decision

**Approach B:** AppIntent が使うテーブルだけを、ビルド時に backend Release の
Asset Pack から抽出し、既存パスへ配置する。

- AppIntent / Widget から `AssetPackManager` を直接読む案は採らない
  （BA の App Group はメインアプリ ↔ `AssetDownloader` 用。他拡張からの
  Managed Asset Pack 読み取りは保証されていない）
- フル JSON を丸ごと同梱する案も採らない（「必要な部分だけ」に反する）

## Goals

1. Build iOS が `jma_code_table.json` 欠落で落ちない
2. 拡張バンドルに入るのは薄い JSON のみ（pmtiles 等は入れない）
3. 正規データ源は backend Release のまま（git に大容量 JSON を戻さない）
4. 抽出失敗時はビルド前に失敗する（空テーブルを黙って同梱しない）

## Non-goals

- Flutter / Asset Pack 実行時パスの変更
- AppIntent から Background Assets を直接読むこと
- `JmaCodeTable.swift` の空配列フォールバック除去（別 TODO 可）
- `assets.gen.dart` の死参照掃除（別コミット可）
- macOS / Android の stage 挙動変更

## Data flow

```text
YumNumm/eqmonitor-backend Release
  asset-pack-vX.Y.Z.zip
    parameters/jma_code_table.json   (full)
            │
            │  stage_from_release.sh --target ios-native
            │  (jq: prefectures + cities only)
            ▼
app/assets/parameters/jma_code_table.json   (slim, gitignored)
            │
            │  existing pbxproj Copy Bundle Resources
            ▼
AppIntentExtension / WidgetExtension Bundle.main
            │
            ▼
JmaCodeTable.swift  (schema unchanged)
```

Flutter 本体は従来どおり Managed Background Assets の
`parameters/jma_code_table.json`（フル）を読む。本設計はネイティブ拡張用の
**ビルド成果物への薄いミラー**であり、ランタイムの第二ソースではない。

## Slim JSON schema

`JmaCodeTable.swift` が現在デコードするキーのみ残す:

```json
{
  "code_tables": {
    "area_information_prefecture_earthquake": [ /* unchanged entry shape */ ],
    "area_information_city": [ /* unchanged entry shape */ ]
  }
}
```

エントリ形状（`code` / `name.ja` 等）はフル JSON のままコピーする。
再マップや専用スキーマは作らない。

### Extraction failure conditions

stage は次のいずれかで **非ゼロ終了**する:

- Release / zip / `parameters/jma_code_table.json` が取れない（既存検証）
- `code_tables.area_information_prefecture_earthquake` が欠落または空配列
- `code_tables.area_information_city` が欠落または空配列
- 出力先への書き込み失敗

空の `{ "code_tables": { ...: [] } }` を書いて「成功」扱いにしない。

## Tooling

### `tool/asset_pack/stage_from_release.sh`

`--target` に `ios-native` を追加する。

| target | 挙動 |
|--------|------|
| `android` | 現行どおりフル pack を PAD モジュールへ |
| `macos` | 現行どおりフル pack を `app/assets/platform/` へ |
| `both` | android + macos |
| `ios-native`（新規） | フル pack は配置しない。jq 抽出のみ行い `app/assets/parameters/jma_code_table.json` を書く |

共通処理（Release 解決・DL・必須ファイル検証・`pack_version` 一致）は
`ios-native` でもそのまま通す。検証後の分岐だけ変える。

出力ディレクトリ:

- `IOS_NATIVE_JMA_CODE_TABLE` 環境変数で上書き可
- デフォルト: `app/assets/parameters/jma_code_table.json`
- 親ディレクトリ `app/assets/parameters/` が無ければ作成
- 既存のゴミファイル（例: `Untitled`）は stage 時に出力ファイル以外を消すか、
  少なくとも出力ファイルを上書きする。ディレクトリ全体をフル pack で
  埋めないこと

### `.gitignore`

次を追加（Android / macOS stage と同様、成果物はコミットしない）:

```gitignore
app/assets/parameters/jma_code_table.json
```

必要なら `app/assets/parameters/.gitkeep` を残してディレクトリだけ追跡する。

### CI

`.github/workflows/deploy-app.yaml` の `build-ios` ジョブで、
`flutter build` / `flutter build ios --config-only` より前に:

```bash
tool/asset_pack/stage_from_release.sh --target ios-native
```

Android と同様に private Release 用の `GH_TOKEN`（または既存の同等トークン）を渡す。
トークン手段は `build-android` の stage ステップに揃える。

### Local

ローカルで iOS をビルドする前にも同じコマンドが必要。
`docs/ios-background-assets.md` または `docs/asset-pack-cd.md` に一行追記する。

## Xcode / Swift

- `project.pbxproj` の `../assets/parameters/jma_code_table.json` 参照は**維持**
- `JmaCodeTable.swift` のデコードロジックは**変更しない**（今回のスコープ外）
- `share_intents_with_widget.rb` / `add_design_resources.rb` のパス前提も維持

## Testing

1. 単体: 抽出用の小さな fixture JSON に対し、jq 式（またはラッパースクリプト）が
   2 テーブルだけ残し、空配列で失敗することを検証するテストを
   `tool/asset_pack/` に置く（既存 `test_*.py` / shell テストの流儀に合わせる）
2. 手動 / CI: `stage_from_release.sh --target ios-native` 後に
   `test -s app/assets/parameters/jma_code_table.json` と
   `jq` で都道府県・市区町村件数が 0 でないことを確認
3. 回帰: `deploy-app` の Build iOS が Copy Bundle Resources で落ちないこと

## Success criteria

- [ ] `develop` の Build iOS が `jma_code_table.json` 欠落で失敗しない
- [ ] 拡張に同梱される JSON に prefecture / city 以外の巨大テーブルや map が無い
- [ ] `jma_code_table.json` が git 追跡されない
- [ ] 抽出元に必須キーが無いとき stage が失敗する

## Out of scope follow-ups

- `JmaCodeTable.load()` がデコード失敗時に空配列を返す挙動の是正
- `assets.gen.dart` / FlutterGen の死んだ `assets/parameters/jma_code_table.json` 参照掃除
- AppIntent を App Group ミラーや `ForegroundContinuableIntent` 経由で
  Asset Pack から読む将来案
