# 揺れ検知に関する仕様

## 揺れ検知の仕様

- 揺れ検知は、強震モニターから取得したリアルタイム震度のデータを元に行います。
- デバイス側では、揺れ検知の判別・処理を行わず、すべてサーバ側で行います。
  - 具体的な実装は、[YumNumm/shake-detect-service](https://github.com/YumNumm/shake-detect-service) を参照ください。
  - サーバ側で実行される揺れ検知サービスから、[YumNumm/eqproxy-io(Private)](https://github.com/YumNumm/eqproxy-io)の`shake-reciever`での型変換、`telegram-proxy-server`でのWebSocketサーバを通じてデバイス側に揺れ検知のイベントが送信されます。
  - したがって、サーバ側の実装修正・パラメータ調整により、揺れ検知の一時停止・アップデートが可能です。
  - 起動直後にWebSocketの接続と既知の揺れ検知イベントの受信を行ってください。
    - WebSocketでのデータは`RealtimePostgresChangesPayloadTable<ShakeDetectionWebSocketTelegram>`に準拠します。
    - 既知の揺れ検知イベントの取得は`GET /v1/shake-detection/latest`で行えます。

## 揺れ検知イベントとEEWの結合について

緊急地震速報(EEW)と揺れ検知イベントを結合することで、UXの改善を行います。

- 揺れ検知イベントは、0または1つのEEWに属します
  - EEWに紐づかない揺れ検知イベントのみを表示します

### 走時表を用いた結合処理

- JMA2001走時表を使用して、EEWの予測震源から揺れ検知をした各観測点までのP波・S波の理論到達時間を計算します
  - 揺れ検知イベントが新規追加された場合は以下の条件をすべて満たす観測点が25%以上ある場合のみ結合を実施します
    - 震央からの距離が150km以内
    - P波・S波の理論到達時間±30秒以内に揺れ検知

## 参考資料

- [揺れ検知から震央を検出してみる](https://note.com/kotoho7/n/n59e423877b1b)
- [強震モニタの画像から揺れていることを検知する](https://qiita.com/ingen084/items/82985e8d3227c97c608d)
