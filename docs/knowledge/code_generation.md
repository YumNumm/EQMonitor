# コード生成と依存互換性

## 通常の生成と確認

依存解決・submodule の準備は [development_environment.md](development_environment.md) を参照。
生成元を変更した package 内で実行する。

```sh
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

- workspace 全体は root で `mise exec -- dart run melos run rebuild`。
  `melos run generate` は未定義の `generate:dart` / `generate:flutter` を参照するため使わない。
- 新版 build_runner では `--delete-conflicting-outputs` が無視される警告が出る場合がある。
- `.g.dart` / `.freezed.dart` / 特殊 `.*.dart` は手編集しない。
  生成差分はソースとの整合を確認して残す。対象外の生成差分もユーザー確認なしに戻さない。
  詳細は `.cursor/rules/generated-file-editing-rules.mdc`。
- 生成器の更新だけではコミット済みの生成物は直らない。対象 package を再生成し、
  `git --no-pager diff`、解析、関連テストで確認する。

## analyzer と generator を一緒に解決する

`NamedExpression` / `NamedArgument` 不明や AOT kernel 生成失敗は、
生成元のエラーだけでなく analyzer AST と generator の版の不整合でも起こる。
現在の正本は `app/pubspec.yaml` の analyzer・dart_style・Freezed・Mockito override と root lockfile。
版の一覧を別管理せず、Riverpod generator も含めて互換制約を確認してから更新する。
古い analyzer 12 / Freezed 3 の override 一式へ戻す対処は使わない。
Primary Constructor 対応 SDK では通常引数の `final` がエラーになるため、
古い Freezed 出力が残る場合も generator を修正・更新して再生成する。

## Freezed の末尾空白

`// dart format off` 内の末尾空白は、再生成で戻り formatter で消えないことがある。
意味を変える手編集や repository 全体の空白除去は行わない。
過去の作業には限定的な後処理の記録があるが、現行の生成ファイル編集禁止ルールを上書きする一般手順ではない。
再現する場合は generator 側の修正・更新で対処し、再生成後の差分と `git diff --check` の結果を記録する。
検証が失敗したまま手編集で成功に見せない。

## Pigeon の analyzer 隔離

確認日 2026-09-21 の `packages/background_location_tracker` は Pigeon `^28.1.0`。
旧 Pigeon 26.3.4 と analyzer 13 の不整合を理由に、古いキャッシュ内の generator を実行しない。
通常は対象 package 内で現在の lockfile に従って生成する。

```sh
mise exec -- dart run pigeon --input pigeons/background_location.dart
```

現行版で互換性問題を再現した場合だけ、workspace override を変えず、一時 package へ同じ Pigeon 版を隔離する方法を検討する。
その analyzer が読める Dart 構文で Pigeon モデルを定義し、生成後は Dart・Swift・Kotlin の3出力を確認する。

## OpenAPI クライアント

- `packages/eqmonitor_api/bin/generate.dart` は backend の `api/api/openapi.json` を読み、
  `lib/src` を全消し再生成する。必要な backend checkout とその指示を先に確認する。
  通常の API package の単体テストには backend は不要。
- package 内で `mise exec -- dart run bin/generate.dart`、続けて `mise exec -- dart test`。
  追加型だけでなく既存 API・モデル・export の削除差分も確認し、app 全体の解析も行う。
  過去には別機能の再生成で Live Activity 契約が欠落した。旧 endpoint を無条件に復元せず、
  現在の backend 契約と利用側の双方で意図した変更か確認する。
- generator は廃止済み Parameters API の互換型を `legacy_generated_contract.dart` で保全する。
  生成後の型衝突・短い schema 名の上書き・互換型の消失にも注意する。
- discriminator のない `oneOf` / `anyOf` は `fromJson` が `UnimplementedError` になることがある。
  契約上の判別 field を確認して `_patchUnionFromJson` に再現可能な補正を追加し、全 variant をテストする。
  例: hypocenter の `datasource` は `JMA_DISASTER_INFORMATION_XML` / `JMA_INTENSITY_DATABASE`。
- enum エラー文字列の `$unknown` は出力 Dart 上で `\$unknown` にする。
  補間・二重エスケープの修正は生成済み enum ではなく generator に入れる。
  現行 generator の `_patchGeneratedFiles` にこの処理がある。
- backend の OpenAPI 生成は、先に backend 側の指示と現行 script を確認する。過去の `generate:openapi` は stdout 出力のみだったため、スキーマを変えただけで `api/api/openapi.json` が更新されたとみなさない。
- 生成後は追加プロパティが OpenAPI と Dart/Swift の利用側に揃うことを確認する。backend がない環境でその現行仕様を検証済みとしない。
- API の api-stub 結合テスト、契約 drift テスト、生成 fixture のコピーは廃止済み。通常の `dart test` に stub 起動や integration タグ除外は不要。OpenAPI の取り込み・クライアント生成は継続する。
