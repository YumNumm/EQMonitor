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

## 400: EEW 履歴の取消表示の実機確認

- 対象: 緊急地震速報の履歴一覧と詳細の報一覧。実機での表示確認は未実施。
- 完了条件: 取消報で取消表示と発表時刻を確認する。警報の強調色や震度・震源情報が表示されず、詳細から取消前の各報を選択できることを確認する。
- ライト・ダークテーマ、文字サイズ拡大、縦・横画面で表示崩れがないことを確認する。

## 400: EEW 予想震度の塗り潰し色の実機確認

- 対象: ホーム・ライブモニタの予想震度塗り潰し。実機での表示確認は未実施。
- 完了条件: 震度3の地域がテーマの震度3の色で表示され、EEW詳細画面の配色と一致することを確認する。震度0〜2・4以上、ライト・ダークテーマ、カスタム震度色、表示中のテーマ変更も確認する。
