# EEW Live Activityの最大長周期地震動階級

バックエンド対応: https://github.com/YumNumm/eqmonitor-backend/issues/1158

Figmaのロック画面案（1628:1745）には最大長周期地震動階級があるが、
現在の`buildEewLiveActivityContentState`は該当項目を配信していない。
現在地の`forecastLpgmIntensity`を全国の最大値として流用しない。

- 配信契約に全国の最大長周期地震動階級を追加し、イベントからの変換を検証する。
- Swiftの受信モデルと旧ペイロード互換テストを追加する。
- 実値を受信した場合だけロック画面の発生時刻の下に表示する。

2026-09-07のデザイン実装ではこの行を省略している。固定値・仮値は表示していない。
