# workflows

クライアントサイドの耐久ワークフローランナー。
[Cloudflare Workers Workflows の `WorkflowStep`](https://developers.cloudflare.com/workflows/build/workers-api/) の API 形状を参考に、Flutter/Dart アプリ内で「ステップ単位の冪等・再開」を実現する純粋 Dart パッケージ。

## コンセプト

- **耐久ステップ**: 一度成功したステップはその結果を永続ストアに保存し、同じインスタンスで再実行しても再実行されない。
- **再開可能**: アプリが途中でクラッシュ・再起動しても、同じ `instanceId` で再実行すれば失敗したステップの直前から再開できる。
- **Cloudflare 非依存**: Cloudflare Workers ランタイムは不要。API 形状の参考として使っているだけで、完全にクライアントサイドで動く。

## 使い方

### 1. `WorkflowPersistence` の実装を用意する

```dart
// テスト用インメモリ実装
final persistence = InMemoryWorkflowPersistence();

// 本番ではアプリ側で SharedPreferences 等にバインドする
final persistence = SharedPreferencesWorkflowPersistence(prefs);
```

### 2. `WorkflowRunner` を作って `run` を呼ぶ

```dart
final runner = WorkflowRunner(persistence: persistence);

await runner.run(
  instanceId: 'my-migration-v1',   // アプリ再起動を跨いで同じ ID を使う
  workflow: (step) async {
    // step(name, callback) — 同じ name は一度だけ実行される
    final deviceExists = await step('checkDevice', () async {
      final res = await api.getDevice(deviceId);
      return res.statusCode == 200;
    });

    if (!deviceExists) {
      await step('registerDevice', () => api.putDevice(deviceId));
    }

    await step('migrate', () => api.postMigrate(deviceId, oldId));
  },
);
```

### 3. 完了後にクリーンアップ（任意）

```dart
await runner.clear('my-migration-v1');
```

## API

### `WorkflowStep.call<T>(name, callback)`

- `name` が同一インスタンスで既に完了していれば `callback` を実行せず保存済みの結果を返す。
- `T` は JSON エンコード可能な型（プリミティブ、`Map`、`List`、`null`）に限定。

### `WorkflowRunner.run({instanceId, workflow})`

- `workflow` 関数に `WorkflowStep` を渡して実行する。
- `workflow` が途中で例外を投げた場合、完了済みのステップ結果は永続ストアに残り、次回 `run` を同じ `instanceId` で呼ぶと続きから再開する。

### `WorkflowRunner.clear(instanceId)`

- 指定した `instanceId` の永続ストアをすべて削除する。

### `WorkflowPersistence` (抽象インターフェース)

| メソッド | 説明 |
|---------|------|
| `getRaw(instanceId, stepName)` | 保存済みの JSON 文字列を返す（未保存は `null`） |
| `saveRaw(instanceId, stepName, raw)` | JSON 文字列を永続化する |
| `clearInstance(instanceId)` | インスタンスのデータをすべて削除する |

`WorkflowPersistenceX` 拡張で `getStepResult` / `saveStepResult` も利用できる。

## テスト

```bash
dart test packages/workflows/test/
```
