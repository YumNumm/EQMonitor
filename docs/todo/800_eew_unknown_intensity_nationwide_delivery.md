# EEW の予想最大震度が不明な電文が全国スロットへ配信されない

## 現象

全国スロットの最小震度を「すべて」（震度0）に設定しても、EEW の予想最大震度が不明で地域情報も無い電文は配信されない。

## 原因

`eqmonitor-backend` の `service/notification-resolver/src/handlers/earthquake/device-matcher.ts` で、震度 `不明` の地域を除外したうえで、地域が 0 件かつ `eventMaxIntensity` が未取得の場合は対象デバイスなしとして早期 return している。

全国スロットのマッチング（`repository/device.ts` の `findEewMatchedSettings`）も `maxIntensityForAllRegion !== undefined` を分岐条件にしているため、震度が確定していない電文では全国スロットの枝が組み立てられない。

## 検討事項

- 「すべて」を選んだ端末に限り、震度不明の EEW も配信対象とするか
- 配信する場合、通知文面で震度不明をどう表現するか
- 仮定震源要素・PLUM 初期報など、震度不明が発生する電文種別ごとの妥当性

## 備考

2026-08-14 の通知プリセット再設計（`docs/superpowers/specs/2026-08-14-notification-preset-all-redesign-design.md`）の調査中に発見。同設計では新たに発生する問題ではないためスコープ外とした。
