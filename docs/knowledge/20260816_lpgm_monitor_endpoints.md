# LMoni リアルタイム画像の配信経路

## 結論

LMoni のリアルタイム画像は、通常の強震モニタ互換データと長周期地震動データで配信経路が異なる。
単一のベースパスに統合せず、データ種別で明示的に振り分ける。

- 通常データ: `/img_svr/data/map_img/RealTimeImg/{type}_{layer}/...`
- 長周期データ: `/monitor/data/data/map_img/RealTimeImg/{type}_s/...`

長周期データには地中画像がなく、レイヤーは常に地表を表す `_s` とする。
保存済み設定が地中でも `_b` を組み立ててはならない。

## 確認方法

日時部分は LMoni が公開済みの日本標準時に置き換える。

```bash
curl --fail --head \
  'https://www.lmoni.bosai.go.jp/img_svr/data/map_img/RealTimeImg/jma_s/YYYYMMDD/YYYYMMDDHHMMSS.jma_s.gif'

curl --fail --head \
  'https://www.lmoni.bosai.go.jp/monitor/data/data/map_img/RealTimeImg/abrspmx_s/YYYYMMDD/YYYYMMDDHHMMSS.abrspmx_s.gif'
```

公式モニターの JavaScript も両者を別の URL として組み立てているため、配信形式の変更を疑う場合は最初に公式画面の通信とスクリプトを確認する。

- 公式モニター: <https://www.lmoni.bosai.go.jp/monitor/>
- 防災科研の利用上の注意: <https://www.kyoshin.bosai.go.jp/ja/about_lmoni/>

防災科研は配信形態を予告なく変更する場合があるとしている。取得失敗時に別レイヤーや固定値へフォールバックせず、エラーとして扱って経路を再確認する。

## 参考実装

`ingen084/KyoshinMonitorLib` の `LpgmWebApiUrlGenerator` は、通常画像と長周期画像の URL 生成を別メソッドに分け、長周期画像を地表固定としている。この責務分離を参考にする。

ただし、同ライブラリが通常画像用に使用する `smi.lmoniexp.bosai.go.jp` は現行の公式画面の経路ではない。ホストとパスは公式画面の現在の通信を優先する。

- 参考: <https://github.com/ingen084/KyoshinMonitorLib>
