# 揺れ検知 legacy domain field の削除

canonical active snapshot への atomic migration 中もアプリを buildable に保つため、
`ShakeDetectionEvent` は一時的に次の互換フィールド・nullable metadata を保持している。

- `isReplay`
- `mergedEewEventId`
- legacy realtime event に存在しない `serialNo` / `updatedAt` / `expiresAt` の nullable 性

Task 6 で expiry/correlation consumer を canonical snapshot に移行した後、legacy producer と
consumer を削除し、canonical metadata を `required` に戻すこと。REST repository は API に
存在しない legacy 値を生成せず、canonical metadata をすべて設定する。

確認コマンド:

```bash
mise exec -- flutter test app/test/feature/shake_detection/data
mise exec -- dart analyze app/lib/feature/shake_detection
```
