# Flutter 変更のテスト方針

## 原則

- TDD や Widget Test をすべての変更へ一律に適用しない。
- ユーザーの指示と、誤動作時の影響・回帰可能性に応じてテスト方法を選ぶ。
- 文言や情報配置だけの軽微な変更では、関連する既存テストと静的解析による確認を選択できる。
- 緊急情報の判定、データ変換、状態遷移、通知条件、永続化、障害修正には自動テストを追加する。

## テストを追加しない場合

作業結果に理由を記載し、少なくとも変更機能の既存テストと変更対象の静的解析を実行する。

```bash
cd app
mise exec -- flutter test test/feature/<feature>
mise exec -- flutter analyze lib/feature/<feature>
```
