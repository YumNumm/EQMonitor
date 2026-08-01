# JSONデシリアライズは生成型を使用する

## ルール

- 手書きコードで `json['key']` のように `Map`へキーアクセスしない。
- アプリ固有のJSONは、Freezedモデルに`fromJson`を定義し、`json_serializable`が生成した処理を使用する。
- APIレスポンスは、OpenAPIから生成されたFreezed型の`fromJson`を使用する。
- APIの型が衝突する場合は、OpenAPIの生成元スキーマでcomponent名を明示する。クライアント側でJSONをMapとして加工しない。

## 生成と検証

```sh
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- flutter test --no-pub test/feature/parameter/parameter_repository_test.dart

cd ..
mise exec -- dart run packages/eqmonitor_api/bin/generate.dart

cd packages/eqmonitor_api
mise exec -- dart analyze
mise exec -- dart test
```
