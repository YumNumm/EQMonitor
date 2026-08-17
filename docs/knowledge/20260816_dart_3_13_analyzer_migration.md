# Dart 3.13 lint 有効化時の既存コード移行

## 背景

Dart 3.13 向け lint をルートの `analysis_options.yaml` で有効化すると、
workspace 配下の既存コードすべてが直ちに CI の `fatal-infos` 対象になる。
EQMonitor では次の3ルールだけで 1,726 件の info が発生した。

- `unnecessary_type_name_in_constructor`
- `unnecessary_const_in_enum_constructor`
- `empty_container_bodies`

lint の無効化や ignore 追加ではなく、Dart SDK の fix producer で構文移行する。

## 移行手順

新規 worktree では、依存解決前に submodule を固定 SHA へ初期化する。

```bash
git submodule update --init --recursive
mise exec -- dart pub get --enforce-lockfile
```

まず CI と同じ条件で件数を記録し、公式修正の対象件数を dry-run で照合する。

```bash
mise exec -- flutter analyze --no-pub --fatal-infos app
mise exec -- dart fix --dry-run app
```

適用する diagnostic code を明示し、意図しない fix producer を実行しない。

```bash
mise exec -- dart fix --apply --code=unnecessary_type_name_in_constructor app
mise exec -- dart fix --apply --code=unnecessary_const_in_enum_constructor app
mise exec -- dart fix --apply --code=empty_container_bodies app
```

`dart format app/lib app/test` は、移行対象外の既存コードや生成ファイルまで
現行 formatter で再整形する可能性がある。上記の1語単位の公式 fix に対して
全ディレクトリ format は実行せず、必要な場合だけ変更ファイルを限定する。

最後に app と workspace の両方を検証する。

```bash
mise exec -- flutter analyze --no-pub --fatal-infos app
DASH__SUPPRESS_ANALYTICS=true mise exec -- dart run melos run analyze
```

`DART_SUPPRESS_ANALYTICS` では analysis server の telemetry は停止しない。
ネットワーク制限のある CI では `DASH__SUPPRESS_ANALYTICS=true` を指定し、
`unified_analytics` による送信失敗で解析自体が終了するのを防ぐ。

## Flutter test と native assets

pub workspace root から `flutter test app/test/...` を実行すると、root の
`pubspec.yaml` が基準になり、`app/pubspec.yaml` にある
`flutter.config.enable-native-assets: true` が反映されない。この状態では
`package:sqlite3` v3 の `sqlite3_initialize` を解決できない。

app のテストは Melos と同じく `app` を working directory にして実行する。

```bash
cd app
mise exec -- flutter test test/core/api/http_cache_migrator_test.dart
mise exec -- flutter test
```

複数worktreeのFlutterコマンドは同一SDKのstartup lockを共有する。同時実行で
loadが長時間停止する場合は、他の実行を破壊せず、対象テストの単独実行と
`--concurrency=1` で製品コード失敗か環境競合かを切り分ける。
