# Release Please のバージョン・タグ運用

日付: 2026-08-14

## タグ規約

- リリースタグは `vX.Y.Z` 固定（例: `v3.0.0`）。コンポーネント名を付けない
  - `release-please-config.json` の `include-component-in-tag: false` で担保する
  - `deploy-app.yaml` は `v*-beta.*`、`create-beta-release.yaml` は `v${VERSION}-beta.N` を前提にしている
  - `eqmonitor_workspace-v3.0.0` のような名前になると既存タグ・CHANGELOG の compare リンクと不整合になる
- Release PR のブランチ名 (`release-please--branches--develop--components--eqmonitor_workspace`) は
  `include-component-in-tag` の影響を受けない（release-please の `getBranchComponent` はコンポーネント名を常に使う）

## バージョンを任意の値に固定する

conventional commits から計算される値と異なるバージョンを出したい場合は、
develop に入るコミットの footer に `Release-As` を書く。

```text
chore: 次のリリースを3.0.0に固定する

Release-As: 3.0.0
```

- 1回だけ効き、リリース後は自動的に無効になる（後片付け不要）
- `release-please-config.json` の `release-as` は残り続けるため、**使ったらリリース後に必ず削除する**必要がある。
  忘れると次回以降も同じバージョンを提案し続けるので、原則 footer 方式を使う
- squash merge するとメッセージから footer が落ちる可能性がある。merge commit で develop に入れる

## Release PR ブランチを手で編集しないこと

`release-please` は develop への push ごとに実行され、Release PR のブランチを force push で作り直す。
Release PR 側に手でコミットしても次の push で消えるため、設定変更・バージョン指定は必ず develop 側へ入れる。

## app/pubspec.yaml のコメントを壊さない

`extra-files` に文字列で `app/pubspec.yaml` を指定すると YAML updater が全体を再シリアライズし、
コメントが全部消える。`app/pubspec.yaml` には次の運用上必須の記述がコメントで書かれているため致命的。

- `flutter.config.enable-native-assets: true`: `package:sqlite3` v3 が build hook で `libsqlite3` を同梱する。
  無効だと `.so` が同梱されず drift が起動時にクラッシュする
- `flutter.config.enable-dart-data-assets: true`: `eqmonitor_map` の `hook/build.dart` が生成する `.fmat` を
  同梱するために必要。`flutter config --enable-dart-data-assets` はマシンごとの global 設定で CI に効かない

そのため `extra-files` は generic updater を使い、バージョン行に注釈を付ける。

```json
"extra-files": [{ "type": "generic", "path": "app/pubspec.yaml" }]
```

```yaml
version: 3.0.0 # x-release-please-version
```

generic updater は注釈のある行だけを書き換えるのでコメントは保持される。
`# x-release-please-version` を消すと `app/pubspec.yaml` のバージョンが更新されなくなるので消さない
（`deploy-app.yaml` は `yq .version app/pubspec.yaml` で参照しており、コメント付きでも読める）。

## 確認コマンド

```bash
python3 -c "import json; json.load(open('release-please-config.json'))"
mise exec -- yq .version app/pubspec.yaml -r
```
