# Pigeon生成時のanalyzer依存を隔離する

## 症状

ワークスペースで次を実行すると、Pigeon内の`NamedExpression`等で
コンパイルエラーになることがある。

```shell
cd packages/background_location_tracker
mise exec -- dart run pigeon --input pigeons/background_location.dart
```

EQMonitorのoverrideは`analyzer 13.x`を選択するが、`pigeon 26.3.4`は
`analyzer <13.0.0`を宣言しているため、ワークスペースの依存解決と互換性がない。

## 回避手順

リポジトリ外の一時packageでPigeonだけを解決し、その
`package_config.json`を明示して同じバージョンのgeneratorを実行する。

```yaml
# /tmp/eqmonitor-pigeon/pubspec.yaml
name: eqmonitor_pigeon_generator
publish_to: none
environment:
  sdk: ^3.13.0
dev_dependencies:
  pigeon: 26.3.4
```

```shell
cd /tmp/eqmonitor-pigeon
mise exec -- dart pub get --offline

cd /path/to/EQMonitor/packages/background_location_tracker
PIGEON_CACHE="${PUB_CACHE:-$HOME/.pub-cache}"
mise exec -- dart \
  --packages=/tmp/eqmonitor-pigeon/.dart_tool/package_config.json \
  "$PIGEON_CACHE/hosted/pub.dev/pigeon-26.3.4/bin/pigeon.dart" \
  --input pigeons/background_location.dart
```

`analyzer 12.x`ではprimary constructorを解釈できないため、Pigeonモデルは
通常のコンストラクタ構文で定義する。生成後はDart・Swift・Kotlinの
3生成物を必ず差分確認する。
