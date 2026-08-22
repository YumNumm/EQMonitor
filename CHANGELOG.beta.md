# Changelog (Beta)

## [3.0.0-beta.12](https://github.com/YumNumm/EQMonitor/compare/v3.0.0-beta.11...v3.0.0-beta.12) (2026-08-22)


### Features

* **debug:** Device APIのロールがADMINならデバッグメニューを開けるようにする ([83a203f](https://github.com/YumNumm/EQMonitor/commit/83a203f37f61b08b3fd8f9991f18ea4f58f996e4))
* **debug:** Device APIのロールがADMINならデバッグメニューを開けるようにする ([57c5f92](https://github.com/YumNumm/EQMonitor/commit/57c5f922243ba706ea06b7808afebaf0f189f06c))
* EEWのLive Activityプレビューに報の進行を再現したStateを追加する ([be12006](https://github.com/YumNumm/EQMonitor/commit/be12006fddef1ea2a58efd3ea0371cfdd97fed60))
* **intensity-history:** 都道府県別最大震度を市区町村別最大震度に変更する ([9491cea](https://github.com/YumNumm/EQMonitor/commit/9491cea8e38173799b40e0bb89b6f85a8ce9393c))
* Live Activityのロック画面に深発地震の予想震度未発表注釈を追加する ([665ad65](https://github.com/YumNumm/EQMonitor/commit/665ad65cabdb4d30d7b63ed83b84b6db76010838))
* Widget/Live Activity のプレビュー専用ターゲットを追加する ([836367e](https://github.com/YumNumm/EQMonitor/commit/836367ea96412b43ddbd13424cd0a585f8e53e6d))
* 地図描画をfoundationのrender契約経由へ移す ([bbe6032](https://github.com/YumNumm/EQMonitor/commit/bbe603240c199402da805b37b39fcea31206f3eb))


### Bug Fixes

* Android MapLibreのPlatformView保持修正を取り込む ([839a437](https://github.com/YumNumm/EQMonitor/commit/839a437836caed3e2e53388556f835a55c45455f))
* Conflict Error ([a87a2bb](https://github.com/YumNumm/EQMonitor/commit/a87a2bb0b064335e6fb8ad090c20501357010a79))
* eew_card の到達後表示をカウントダウンと同じ2行組に揃える ([bd874d6](https://github.com/YumNumm/EQMonitor/commit/bd874d6554f3c4737152f7b859b15be43efce2d9))
* EEWカードの深発注意文を判定クラスの結果で表示する ([c23ff94](https://github.com/YumNumm/EQMonitor/commit/c23ff943936eee4c25b530a67c9604d23d6dfca3))
* EEWシミュレーション停止中の時刻進行を修正 ([b37cd18](https://github.com/YumNumm/EQMonitor/commit/b37cd18c38151e32ddffe6e38b2d989facebe510))
* EEW停止完了位置の描画を確定 ([e9cda76](https://github.com/YumNumm/EQMonitor/commit/e9cda762539a04c51af6b263534c6f9720328aee))
* EEW履歴の報切替で警報範囲を再描画する ([9adcb93](https://github.com/YumNumm/EQMonitor/commit/9adcb931a6f180c6a898bd6dae603a636b5f596a))
* EEW警報レイヤーを報切替時も維持 ([af69ca6](https://github.com/YumNumm/EQMonitor/commit/af69ca64862a73486c1fc9ce2cf9e75767bf8330))
* **home:** 導線ラベルを「市区町村別 最大観測震度」にリネームする ([98dd038](https://github.com/YumNumm/EQMonitor/commit/98dd0383708dd919601b04a7d3183850fb6c0d08))
* **home:** 市区町村別最大観測震度の導線を有効化する ([6d57901](https://github.com/YumNumm/EQMonitor/commit/6d57901555ec7e7c2b2ca82e80ef44cf4bb6464c))
* **home:** 市区町村別最大観測震度の導線を有効化する ([141427b](https://github.com/YumNumm/EQMonitor/commit/141427bc97a552378fef1479ff8a95a5f0dc0a21))
* **intensity-history:** 市区町村の塗りが不要に作り直されて消えるのを修正 ([56145b0](https://github.com/YumNumm/EQMonitor/commit/56145b027bcbf3e356e3849fa604b42b56b89745))
* **intensity-history:** 市区町村の塗りが不要に作り直されて消えるのを修正 ([7b7e6fa](https://github.com/YumNumm/EQMonitor/commit/7b7e6fa3952430138401b78a25bc8c89a29870b8))
* **map:** iOS の quick zoom 中にマップのタップが誤発火するのを修正 ([85718bc](https://github.com/YumNumm/EQMonitor/commit/85718bcb7ee7237c190014f78523a1bdbbae5e91))
* **map:** iOS の quick zoom 中にマップのタップが誤発火するのを修正 ([b32751c](https://github.com/YumNumm/EQMonitor/commit/b32751c864eda8ef85e1d114c09a5605f7c02198))
* NTP, Kmoni時刻動機 ([6e73a52](https://github.com/YumNumm/EQMonitor/commit/6e73a522c00c0d6f755bd41b315aed1108721aac))
* **NTP:** NTP周りのバグ修正 ([d7af602](https://github.com/YumNumm/EQMonitor/commit/d7af6027142c15e4c7c77ea4343119361afa8a78))
* **onboarding:** デバイス登録の失敗後もインラインで再試行できるようにする ([a3c71b4](https://github.com/YumNumm/EQMonitor/commit/a3c71b4712da95926a0c27f60a0afec7d73d5a15))
* **theme:** JMA Standard の震度色を気象庁配色に修正し、ライトの地図背景を白ベースにする ([ff76dd5](https://github.com/YumNumm/EQMonitor/commit/ff76dd5d14606676ecbdcd49e456f7b82f0e95be))
* プレビュー用の widget extension を分けてクラッシュを解消する ([b36fbe7](https://github.com/YumNumm/EQMonitor/commit/b36fbe7375adf1eea1c536ec8df6db549c4f8ef2))
* マップレイヤー設定のセクションを同時に展開できるようにする ([7964064](https://github.com/YumNumm/EQMonitor/commit/7964064ebd95230f543fb60944f131a2019bb2fc))
* マップレイヤー設定のセクションを同時に展開できるようにする ([070be33](https://github.com/YumNumm/EQMonitor/commit/070be33abebc0c93d62c990e652b2574f09b709f))
* 予想震度が未発表でも震度バッジを灰色の「-」で表示する ([66e39ea](https://github.com/YumNumm/EQMonitor/commit/66e39eae9c2f8b9a21b572c47e6048995473f1d5))
* 予想震度不明のアイコンをハイフン表示にする ([fd4ed4d](https://github.com/YumNumm/EQMonitor/commit/fd4ed4dd68004d05219dd0a9e4bb631a9df0b328))
* 到達後もカウントダウン表示を00:00のまま維持する ([dea6290](https://github.com/YumNumm/EQMonitor/commit/dea6290875db12c3128cdf8a8f368e20a7703691))
* 深発注意文の条件をJMA表記に合わせ深さ150kmより深い場合に限定する ([b000926](https://github.com/YumNumm/EQMonitor/commit/b00092606650b8a3b84a6906d3cd2f9da714a29d))
* 深発注意文の表示条件を専用クラスに切り出してテストする ([3a8a0d0](https://github.com/YumNumm/EQMonitor/commit/3a8a0d05d123260c4c1efa324290aa3c8493fc3c))
* 現在地の震度カードを測位精度に応じた粒度で表示する ([a90f242](https://github.com/YumNumm/EQMonitor/commit/a90f242e5175ad890af4d2f1b45acb6e007ad03f))
* 震度スケールの目盛り見切れを修正 ([5986689](https://github.com/YumNumm/EQMonitor/commit/598668925864edd2912982160fbe72f30c919ff2))
* 震度スケールの目盛り見切れを修正する ([3e99b8e](https://github.com/YumNumm/EQMonitor/commit/3e99b8eda515c0df50ae7a1651a15561160b3b00))


### Reverts

* eew_card の到達後表示を元の主要動到達済みに戻す ([79d1919](https://github.com/YumNumm/EQMonitor/commit/79d19198fc0c7f69fa88a00bad2647f4b9cf0e09))

## [3.0.0-beta.11](https://github.com/YumNumm/EQMonitor/compare/v3.0.0-beta.10...v3.0.0-beta.11) (2026-08-19)


### Features

* Asset Pack デバッグ画面を Dart 診断情報に合わせて更新する ([1a714c1](https://github.com/YumNumm/EQMonitor/commit/1a714c10334e5cad25b33bc11fdc9787cca3498a))
* beta 用 Release Please の config と manifest を追加 ([888c44a](https://github.com/YumNumm/EQMonitor/commit/888c44a41f3d5b9f86c8143e246b47e9ad7ff718))
* beta 用 Release Please を本番と分離する ([b5d9e52](https://github.com/YumNumm/EQMonitor/commit/b5d9e52812aa69b0d9e8af06cdc117110f5c0094))
* **device:** Device API の role を生成モデル経由で扱う ([9cc8388](https://github.com/YumNumm/EQMonitor/commit/9cc8388f4a594d3a38656c2daec79fee287107b0))
* **device:** Device API の role を生成モデル経由で扱う ([ea30e60](https://github.com/YumNumm/EQMonitor/commit/ea30e602ff357509ddd3462f903238ed83e9ad3b))
* flutter_hooks_lint_plugin を導入する ([a3fe240](https://github.com/YumNumm/EQMonitor/commit/a3fe24019b562cd48246e475e5bcb99646071cdf))
* **realtime:** WebSocket の RTT をクライアント起因 ping で計測する ([c9241fa](https://github.com/YumNumm/EQMonitor/commit/c9241faa38db9a4128c648b65d3459ef98920838))
* このアプリについて画面の最下部に選択可能なデバイスIDを表示 ([a7afd66](https://github.com/YumNumm/EQMonitor/commit/a7afd66bda99e63169c727ada92b73ca8c2f3485))
* 同梱 Asset Pack を Flutter assets から展開する ([adf5d2b](https://github.com/YumNumm/EQMonitor/commit/adf5d2b556eb36a9104fd3b4ef463358cce07b19))


### Bug Fixes

* **kyoshin-monitor:** 公開遅延の学習キーをホストからパイプラインへ変更 ([c621bf1](https://github.com/YumNumm/EQMonitor/commit/c621bf1f33ec1204ce21690b197b667b7a0fc255))
* **kyoshin-monitor:** 時刻同期をNTP基準に作り直し、長周期地震動モニタのずれを解消 ([d757371](https://github.com/YumNumm/EQMonitor/commit/d757371657159743e924cd21b60a028bae92606f))
* **kyoshin-monitor:** 時刻同期をNTP基準に作り直し、長周期地震動モニタのずれを解消 ([c460f5e](https://github.com/YumNumm/EQMonitor/commit/c460f5e0123fd05b96a611525a5aa0302cd090af))
* **theme:** テーマ編集画面へ go で遷移して設定から戻れなくなる不具合を修正 ([8f5aeb3](https://github.com/YumNumm/EQMonitor/commit/8f5aeb3c3b4089b2f7a58f6381308353590e2dab))
* **theme:** テーマ編集画面へ go で遷移して設定から戻れなくなる不具合を修正 ([62961ce](https://github.com/YumNumm/EQMonitor/commit/62961ce8a6a72c71f23d19d44154b8700c0abd36))
* 広告非表示時に広告領域の空白を詰める ([b80deab](https://github.com/YumNumm/EQMonitor/commit/b80deab301675c891c0b5d3f35116f3fbf4b5afe))

## [3.0.0-beta.10](https://github.com/YumNumm/EQMonitor/compare/v3.0.0-beta.9...v3.0.0-beta.10)

Bootstrap entry for the beta Release Please track. Subsequent beta releases are managed by `release-please-config.beta.json`.
