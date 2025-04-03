# EQMonitor 開発ガイド

## コマンド

### ビルド・実行

- ビルドランナー: `dart run build_runner build -d`
- クリーン＆再ビルド: `melos clean-all`

### テスト

- 全テスト実行: `melos run test`
- Flutterテスト実行: `melos run test:flutter`
- Dartテスト実行: `melos run test:dart`
- テストレポート: `melos run report:test`

### リント・解析

- 全体解析: `melos run analyze`
- カスタムリント: `dart run custom_lint`

## コードスタイル

- **フォーマット**: 60文字の行幅を使用（formatter.page_width設定参照）
- **インポート**: プロジェクトファイルには相対インポート、依存関係にはパッケージインポートを使用
- **命名規則**: 変数・メソッドにはキャメルケース、クラス・列挙型にはパスカルケースを使用
- **状態管理**: Riverpodをアノテーションと共に使用
- **エラーハンドリング**: 適切なエラー伝播；ログにはtalkerを使用
- **型**: freezedで不変モデルを使用した強い型付け
- **ウィジェット構造**: 可能な限り単一子ウィジェットを避ける
- **アーキテクチャ**: コードをcore、feature、pageの層に分離
