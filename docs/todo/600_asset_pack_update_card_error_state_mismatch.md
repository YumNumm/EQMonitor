# AssetPackUpdateError の表示条件が widget と test で食い違っている

## 事象

`app/test/feature/asset_pack/asset_pack_update_card_test.dart` の
`shows a bounded retry message after a check failure` が失敗する。

```bash
cd app
mise exec -- flutter test --no-pub \
  test/feature/asset_pack/asset_pack_update_card_test.dart
```

## 原因

`AssetPackUpdateCard` は `isUpdating` が true のときだけエラーカードを描く。

```dart
AssetPackUpdateError(:final message, :final isUpdating) when isUpdating =>
  _AssetPackErrorCard(message: message),
AssetPackUpdateError() => const SizedBox.shrink(),
```

一方 test は `isUpdating: false` の状態で
「Asset Pack の更新確認に失敗しました」と再試行ボタンが出ることを期待する。
どちらも `9cb19ea77 update AssetPack周りの整理` で同時に変更されており、
assets_util 削除より前から食い違っている。

## 判断が必要な点

「ユーザー操作を伴わない自動更新チェックの失敗を、ホームに常時出すか」
という仕様判断。決めたうえで widget か test の片方を直す。
自動チェックの失敗を黙って握り潰す形になっていないか、あわせて確認する。
