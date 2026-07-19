# 揺れ検知 legacy domain field の削除

canonical active snapshot への atomic migration 中もアプリを buildable に保つため、
`ShakeDetectionEvent` は一時的に次の互換フィールド・nullable metadata を保持している。

- `isReplay`
- `mergedEewEventId`
- legacy realtime event に存在しない `serialNo` / `updatedAt` / `expiresAt` の nullable 性
- legacy `RealtimeShakeData` から domain event への互換変換

Task 6 で expiry/correlation consumer を canonical snapshot に移行した後、legacy producer と
consumer を削除し、canonical metadata を `required` に戻すこと。REST repository は API に
存在しない legacy 値を生成せず、canonical metadata をすべて設定する。

互換変換の完了条件:

- `ShakeDetectionEvent.changeReasons` が `required` のままで、全 producer が source の理由を渡す。
- legacy level 変換に `weaker` などの固定値 fallback が存在しない。
- unknown legacy level が `FormatException` になり、理由が欠落・空配列に置換されない test が通る。
- Task 6 完了後、`RealtimeShakeDataConverter` と legacy field を削除する。

確認コマンド:

```bash
mise exec -- flutter test app/test/feature/shake_detection/data
mise exec -- dart analyze app/lib/feature/shake_detection
! rg -n 'orElse:.*ShakeDetectionLevel\.weaker' app/lib
rg -n 'required List<String> changeReasons' \
  app/lib/feature/shake_detection/data/model/shake_detection_event.dart
```
