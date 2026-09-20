# EEW 配信・推定震度の残課題

数値は元の優先度。実機確認と backend の現行挙動は未検証。

## 800: 予想最大震度不明の全国配信

- 対象: `backend/service/notification-resolver/src/handlers/earthquake/device-matcher.ts`、`repository/device.ts` の `findEewMatchedSettings`。
- 旧記録では地域0件かつ `eventMaxIntensity` 未取得で早期returnし、全国slotも `maxIntensityForAllRegion !== undefined` に依存する。現行実装を照合する。
- 「すべて」（震度0）設定の全国slotに限り震度不明EEWも配信するか、文面、仮定震源/PLUM初期報の対象を決定する。
- 完了条件: 配信/非配信契約を電文種別・全国/地域slot・閾値別テストで固定する。震度を仮値で補って配信条件を満たさない。

## 500: EEW 再取得中の表示継続

- 対象: `app/lib/feature/eew/` の起動・復帰・REST再取得経路。Loading/Errorによる表示消失の修正と自動テストは既存実装を参照する。
- 完了条件: EEW活性中の起動/foreground復帰を実機で再現し、resumed・ready・REST開始/完了の順序、card/map/警報表示とログを記録する。過去に見えた約2回の点滅の発火順序は未確認。

## 450: 不完全な震源の除外テスト

- 対象: `app/lib/core/provider/estimated_intensity/provider/estimated_intensity_provider.dart` の `_targetHypocenters` / `_toHypocenterInput` と関連test。
- 完了条件: magnitude/depth/latitude/longitudeを個別に欠損させたEEWで例外が出ず、その地震だけ計算対象から除外され、完全な地震は残る。値を捏造せず、未知震度の表示契約も維持する。
