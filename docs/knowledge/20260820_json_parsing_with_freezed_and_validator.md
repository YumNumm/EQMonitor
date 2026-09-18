# 外部 JSON は freezed + json_serializable で解析し、値の検証は Validator に分離する

Asset Pack 配信マニフェスト（`app/lib/feature/asset_pack/data/model/asset_pack_distribution_manifest.dart`）
を手書き `fromJson` から freezed へ移した際の前提と手順。

## 原則

- JSON の**構造・型・必須フィールド**の解析は json_serializable の生成コードに任せる。手書き `fromJson` を書かない。
- **値の制約**（SemVer / SHA-256 / 固定パス / 並び順など、backend の Valibot スキーマ相当）は
  `*Validator` クラスに分離し、`FormatException` で失敗させる。Repository は Validator の
  `parse(json)` だけを呼ぶ。
- モデルにメソッドを足したくなったら extension で書く。freezed 4 の生成クラスは
  `class _X implements X` なので、抽象クラス本体に実装済みメソッドを置くと未実装扱いになる。

## `app/build.yaml` の既定値（重要）

```yaml
json_serializable:
  options:
    field_rename: snake
    checked: true
```

- `field_rename: snake` が全体に効くため、`schemaVersion` ↔ `schema_version` は
  `@JsonKey(name: ...)` を書かずに対応する。逆に camelCase の JSON を扱うときだけ個別指定が必要。
- `checked: true` のため、型不一致やキー欠落は `FormatException` ではなく
  `CheckedFromJsonException` になる。`FormatException` を期待する呼び出し側・テストがあるなら
  Validator 側で必ず変換する。

```dart
AssetPackDistributionManifest parse(Map<String, dynamic> json) {
  final AssetPackDistributionManifest manifest;
  try {
    manifest = AssetPackDistributionManifest.fromJson(json);
  } on FormatException {
    rethrow;
  } on Object catch (error) {
    throw FormatException('Invalid distribution manifest: $error');
  }
  validate(manifest);
  return manifest;
}
```

## 固定キーの Map は専用モデルにする

`localizations: { ja: ..., en: ... }` のように配信元が必ず両方を返す契約なら、
`Map<String, T>` ではなく `ja` / `en` を必須フィールドに持つ freezed モデルにする。
欠落が解析時点で失敗し、UI 側のフォールバックで `throw` する必要がなくなる。

## 生成・確認コマンド

```bash
cd app
mise exec -- dart run build_runner build --build-filter="lib/feature/asset_pack/**"
mise exec -- dart analyze lib/feature/asset_pack test/feature/asset_pack
mise exec -- flutter test test/feature/asset_pack
```
