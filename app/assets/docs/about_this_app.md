#### **緊急地震速報のP, S波到達予想円について**

[JMA2001走時表]に対し、線形補間を行い、揺れの到達予想円を算出しています。
走時表の仕様により、以下の場合到達予想円が表示されない場合があります。

- P, S波の到達範囲が半径2,001km以上
- 震源の深さが701km以上

強震モニタで表示される揺れ・実際の揺れ・到達予想円はそれぞれ差異が生じる場合があります。

#### **地震情報(緊急地震速報を含む)について**

[Project DM(Disaster Mitigation)-Data Send Service] (以降 Project DM-D.S.S)を利用し、各種地震情報の取得を行っています。
Project DM-D.S.Sから受信したデータを、EQMonitor用に開発者が用意したプライベートAPI(HTTP, WebSocket)で再配信しています。

- 緊急地震速報の再配信については、Project DM-D.S.Sの[再配信ポリシー](https://dmdata.jp/docs/eew#%E5%86%8D%E9%85%8D%E4%BF%A1%E3%83%9D%E3%83%AA%E3%82%B7%E3%83%BC)に基づき、事前の許可を得ています。(2022年12月3日承認済み)
  - ※本アプリケーションの開発に、Project DM-D.S.Sの運営者は一切関係がありません。したがって、本アプリケーションに関するお問い合わせをProject DM-D.S.Sの運営者にすることはお控えください。

[JMA2001走時表]: https://www.data.jma.go.jp/eqev/data/bulletin/catalog/appendix/trtime/trt_j.html
[Project DM(Disaster Mitigation)-Data Send Service]: https://dmdata.jp/

#### **著作権関連**

- 地図データ
  - 日本: 国土数値情報 行政区域
  - 日本以外: Natural Earth
- 強震モニタの観測点データ
  - 防災科学技術研究所(NIED)
- 各種地震情報
  - 気象庁

#### **Special Thanks**

- [JQuake(フランソワ) 様]
  - 強震モニタ画像解析手法 [多項式補間を使用して強震モニタ画像から数値データを決定する](https://qiita.com/NoneType1/items/a4d2cf932e20b56ca444)
- [ingen084 様]
  - 各種処理の参考 [KyoshinEewViewerIngen]
  - 強震モニタの観測点データ [KyoshinMonitorLib]
  - 強震モニタ画像解析手法 [強震モニタの画像から震度と地点を特定するまで](https://qiita.com/ingen084/items/7e91f8da2996972ac586)
- [Laddge 様] ウェブサイトの制作
- [ともりん 様] 通知音・効果音の制作

[JQuake(フランソワ) 様]: https://twitter.com/NoneType1
[KyoshinEewViewerIngen]: https://github.com/ingen084/KyoshinEewViewerIngen
[ingen084 様]: https://twitter.com/ingen084
[KyoshinMonitorLib]: https://github.com/ingen084/KyoshinMonitorLib
[Laddge 様]: https://twitter.com/laddge_
[ともりん 様]: https://twitter.com/tomorin1223

#### **本アプリの開発者**

EQMonitorは、もぐもぐ (Ryotaro Onoue)によって開発されました。
MIT License に基づき、ソースコードを公開しています。(GitHub: [YumNumm/EQMonitor](https://github.com/YumNumm/EQMonitor))

- Twitter: [@YumNumm](https://twitter.com/YumNumm), [@EQMonitorApp](https://twitter.com/EQMonitorApp)
- GitHub: [@YumNumm](https://github.com/YumNumm)
- Mail: [admin@yumnumm.dev](admin@yumnumm.dev) もしくは [contacts@eqmonitor.app](contacts@eqmonitor.app)
