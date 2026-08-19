---
globs: app/lib/feature/permission/**/*.dart,app/lib/feature/onboarding/**/*.dart
---

# 権限状態とオンボーディングの責務

- `PermissionState` は OS から取得した権限状態だけを保持する。
- Model は Freezed で定義し、完了判定・状態遷移・OS 型からの変換などのロジックを持たせない。
- 「スキップ」は OS の権限状態ではない。オンボーディング表示中だけ必要なため、Widget 内の `useState` で管理する。
- OS 権限の取得・再取得と Model への変換は Notifier が担当する。
- 設定アプリからフォアグラウンドへ復帰したときは、OS の権限状態を再取得する。
- Riverpod Provider は手書きの `Provider(...)` ではなく `@riverpod` / `@Riverpod` と Generator を使用する。

生成:

```bash
cd app
mise exec -- dart run build_runner build
```
