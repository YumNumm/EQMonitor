# Codex ローカル環境セットアップでは Flutter ワークスペースを flutter pub get で解決する

EQMonitor のルート `pubspec.yaml` は `environment.flutter` を要求する Flutter ワークスペースである。

Codex のローカル環境セットアップで素の `dart pub get` を実行すると、mise 管理外の Dart が使われる場合に次のエラーで失敗する。

```text
Because eqmonitor_workspace requires the Flutter SDK, version solving failed.

Flutter users should use `flutter pub` instead of `dart pub`.
```

セットアップでは Flutter/Dart コマンドを mise 経由にし、依存解決は `flutter pub get` で行う。

```bash
mise trust
mise install
mise exec -- flutter pub get
```
