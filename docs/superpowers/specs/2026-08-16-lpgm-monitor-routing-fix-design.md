# 長周期地震動モニター配信経路修正設計

## 背景

長周期地震動モニターを選択したとき、設定の組み合わせによってリアルタイム画像取得が
HTTP 404 になり、観測点レイヤーが更新されない。

2026-08-16 時点の公式サイトと実際の配信応答を確認すると、リアルタイム画像には
次の2系統がある。

- 長周期地震動データは
  `/monitor/data/data/map_img/RealTimeImg/{type}_s/...` から配信される。
- 通常の強震モニタデータは
  `/img_svr/data/map_img/RealTimeImg/{type}_{layer}/...` から配信される。

長周期地震動データに地下 (`_b`) はなく、地表 (`_s`) のみが配信される。

## 根本原因

`KyoshinMonitorNotifier` は、次のいずれかを満たすと
`LpgmKyoshinMonitorWebApiDataSource` を選ぶ。

- `monitorSource == KyoshinMonitorSource.lmoni`
- `realtimeDataType.isLpgm`

しかし現在の LMoni クライアントは、すべてのリアルタイムデータを長周期側の
`/monitor/data/data/` へ送る。このため、LMoni ソースで通常震度などを選ぶと
存在しない URL になり 404 が返る。

また、画面では長周期データ選択中も地下レイヤーを選択できる。地下設定が残った状態で
長周期データを取得すると `{type}_b` を要求し、これも 404 になる。

## 参考実装

`ingen084/KyoshinMonitorLib` の `LpgmWebApiUrlGenerator` は、通常データの
`RealtimeImg` と長周期データの `LpgmRealtimeImg` を別の URL として定義している。
長周期側はレイヤー引数を持たず、URLを常に `{type}_s` として生成する。

この責務分離と地表固定を採用する。ただし参考実装の通常データ用ホスト
`smi.lmoniexp.bosai.go.jp` は現行公式サイトの実装と異なるためコピーしない。
現行公式サイトが使い、HTTP 200 を実測した `/img_svr/data/` を正とする。

## 採用する設計

### API クライアント

`LpgmKyoshinMonitorWebApiClient` にリアルタイム画像取得メソッドを2つ定義する。

- 通常データ用メソッドは `/img_svr/data/map_img/RealTimeImg/` を使い、
  地表・地下の指定を受け取る。
- 長周期データ用メソッドは `/monitor/data/data/map_img/RealTimeImg/` を使い、
  URL のレイヤーを常に `s` とする。

既存の曖昧な `getRealtimeImageData` は、呼び分け漏れを防ぐため置き換える。

### Data 層

`LpgmKyoshinMonitorWebApiDataSource.getRealtimeImageData` は
`RealtimeDataType.isLpgm` によって2つのクライアントメソッドを選ぶ。

- 通常データでは呼び出し元の `RealtimeLayer` を保持する。
- 長周期データでは `RealtimeLayer` を URL 生成へ渡さず、地表を取得する。

固定値へのフォールバックではなく、公式配信仕様として型ごとの有効な経路を選択する。

### Presentation 層

長周期データの選択中は「リアルタイムデータのレイヤー」を表示しない。
保存済み設定が地下でも、通常データへ戻したときのユーザー設定として保持する。
取得状態の `currentRealtimeLayer` には、実際に取得した地表を記録する。

通常データを選択している場合は、LMoni ソースでも従来どおり地表・地下を選択できる。

## エラー処理

通信失敗は現在の `AsyncValue.guard` によるエラー状態を維持する。
別ソースへの自動フォールバックや古い画像の流用は行わない。生命に関わる情報で
配信元・対象時刻を曖昧にしないためである。

## テスト

外部サーバーへ依存しない記録用 `HttpClientAdapter` を使い、次を回帰テストする。

- LMoni の通常震度・地表が `/img_svr/data/.../jma_s/...` を要求する。
- LMoni の通常震度・地下が `/img_svr/data/.../jma_b/...` を要求する。
- 長周期地震動階級は地下設定を渡しても
  `/monitor/data/data/.../abrspmx_s/...` を要求する。
- 長周期データでは実効レイヤーが地表になる。
- 長周期データ選択中はレイヤー選択 UI を表示しない。

修正前に各回帰テストが誤った URL または表示状態によって失敗することを確認し、
修正後に関連パッケージテストと Flutter analyze を実行する。

## 運用上の記録

公式配信の URL 体系、長周期データが地表限定であること、配信形態が変更され得ることを
`docs/knowledge/` に記録する。将来の変更では参考ライブラリの定数ではなく、
公式サイトの現行 JavaScript と実際の HTTP 応答を再確認する。
