# Changelog (Beta)

## [3.0.0-beta.13](https://github.com/YumNumm/EQMonitor/compare/v3.0.0-beta.12...v3.0.0-beta.13) (2026-08-23)


### Features

* BaseMapViewへ地震overlay lifecycleを接続 ([03093a2](https://github.com/YumNumm/EQMonitor/commit/03093a2a1d8cbe3fe0ba467236a9eef448f3bf32))
* **home:** EEWフォーカス中のホーム操作を無効化 ([9d6dd86](https://github.com/YumNumm/EQMonitor/commit/9d6dd864fb824a4e9fd52669bbc349f761c6f9a2))
* **home:** EEWフォーカス状態遷移を追加 ([3e64262](https://github.com/YumNumm/EQMonitor/commit/3e642625c4dbbdee8280fdac469089fdcd9c7ffd))
* **home:** 地図操作でEEWフォーカスを解除 ([02b9edb](https://github.com/YumNumm/EQMonitor/commit/02b9edb32a615c4353e62b8800c35d21f3020df1))
* overlay coverageの値変更通知を追加 ([ecf73a0](https://github.com/YumNumm/EQMonitor/commit/ecf73a0d04ada4e2cf113c21506f2865a30a7da0))
* overlay frameをsubmit後にcommit ([501ea2e](https://github.com/YumNumm/EQMonitor/commit/501ea2e2357a48ff85e51ddc8de518c31a778f94))
* 最新地震overlayの世代管理を追加 ([e858a1c](https://github.com/YumNumm/EQMonitor/commit/e858a1caa65812886ae68c0d3562dcd4c9fa1525))
* 最新地震overlayをデバッグ地図へ接続 ([2aae47b](https://github.com/YumNumm/EQMonitor/commit/2aae47b273f02df70f424ce1646670d02a5cbe35))
* 地図操作でEEWフォーカスを解除する ([d4619d7](https://github.com/YumNumm/EQMonitor/commit/d4619d77888862a677f5a7ff49b87c00c7c49bf2))
* 地震overlay frame統合境界を追加 ([9a2be11](https://github.com/YumNumm/EQMonitor/commit/9a2be117291e9e1df3dc3a7b2c38b31c842453fd))
* 地震overlay materialをDataAssetsへ接続 ([be3fc84](https://github.com/YumNumm/EQMonitor/commit/be3fc8492eb2611d3d89c9278a43b62d37998479))
* 地震情報のoverlay変換を追加 ([daaa151](https://github.com/YumNumm/EQMonitor/commit/daaa1511527c91ffbb8b37080f3cc9834d186cb0))
* 観測点を単一GPU instance batchで描画 ([a3e772f](https://github.com/YumNumm/EQMonitor/commit/a3e772f5a1597c66d984942e1367212f58ca47bf))


### Bug Fixes

* coverage通知を描画commitと一体化 ([b7720df](https://github.com/YumNumm/EQMonitor/commit/b7720dfb84edf22a12a0dec6a96e18539831ec20))
* dispose後もGPU完了を待ってgeometryをretire ([f7751bc](https://github.com/YumNumm/EQMonitor/commit/f7751bc9488dafe27dfa277dc172370ecf4091df))
* **home:** EEWフォーカスのカメラ制御を安定化 ([f7a9bc5](https://github.com/YumNumm/EQMonitor/commit/f7a9bc523b6146f0f4c5b883493f9a8a2dc7219c))
* **map:** iOSカメラ操作判定の修正版を参照 ([c4c2382](https://github.com/YumNumm/EQMonitor/commit/c4c2382aaba1827137209f9a8565461c0c214262))
* MapLibre Native修正版へ更新 ([4fdaa60](https://github.com/YumNumm/EQMonitor/commit/4fdaa60976b8ef14016b7c3cc7eaa63633fa131a))
* MapLibre依存のhook修正を反映 ([2c98a49](https://github.com/YumNumm/EQMonitor/commit/2c98a494693a2a17f9ac3dd7d93e9e3a648d2ca7))
* overlay失敗をbase-onlyへ閉じる ([dc74714](https://github.com/YumNumm/EQMonitor/commit/dc747141bc5600f08a9c07dce7bca28293458ea0))
* snapshot置換時に観測点geometryを更新 ([d61550b](https://github.com/YumNumm/EQMonitor/commit/d61550bbd4a46bbc364f24ae15cc2cb16693001b))
* 地震overlayのdecode欠損をterminal管理 ([23b4904](https://github.com/YumNumm/EQMonitor/commit/23b4904217902946b83804c7de017741713817b3))
* 市区町村震度レイヤーの初回更新を修正 ([5d6d5df](https://github.com/YumNumm/EQMonitor/commit/5d6d5df49f427f877c05416da4f0aae695bfd2ba))
* 観測点instanceの所有権と世代identityを強化 ([99fec31](https://github.com/YumNumm/EQMonitor/commit/99fec314212a1039661ba376940c73d423d3cf45))
* 観測点snapshot identity引数を明示化 ([0d4dc5c](https://github.com/YumNumm/EQMonitor/commit/0d4dc5c676dbe8565d87f7bdaeeb8afad351b6a9))
* 震度履歴の読み込み中も戻れるように修正 ([e4d17df](https://github.com/YumNumm/EQMonitor/commit/e4d17df682e1d919c74bd6f73e3eeb8f0cec3d0b))
* 震度情報の取得エラー表示を改善 ([98fb596](https://github.com/YumNumm/EQMonitor/commit/98fb5960dea4c38618a52996e701ac31f27ff34b))
* 震度速報の地図フォーカスを修正 ([97d12cd](https://github.com/YumNumm/EQMonitor/commit/97d12cd14df70aa9baca633ecd2fb2d616b823f8))


### Performance Improvements

* 震度style描画資源をsnapshot単位で再利用 ([7b35941](https://github.com/YumNumm/EQMonitor/commit/7b359419e354820c88cec752787582f0a6178c1f))

## [3.0.0-beta.12](https://github.com/YumNumm/EQMonitor/compare/v3.0.0-beta.11...v3.0.0-beta.12) (2026-08-23)


### Features

* **debug:** Device APIのロールがADMINならデバッグメニューを開けるようにする ([83a203f](https://github.com/YumNumm/EQMonitor/commit/83a203f37f61b08b3fd8f9991f18ea4f58f996e4))
* **debug:** Device APIのロールがADMINならデバッグメニューを開けるようにする ([57c5f92](https://github.com/YumNumm/EQMonitor/commit/57c5f922243ba706ea06b7808afebaf0f189f06c))
* EEWのLive Activityプレビューに報の進行を再現したStateを追加する ([be12006](https://github.com/YumNumm/EQMonitor/commit/be12006fddef1ea2a58efd3ea0371cfdd97fed60))
* **intensity-history:** 都道府県別最大震度を市区町村別最大震度に変更する ([9491cea](https://github.com/YumNumm/EQMonitor/commit/9491cea8e38173799b40e0bb89b6f85a8ce9393c))
* Live Activityのロック画面に深発地震の予想震度未発表注釈を追加する ([665ad65](https://github.com/YumNumm/EQMonitor/commit/665ad65cabdb4d30d7b63ed83b84b6db76010838))
* Widget/Live Activity のプレビュー専用ターゲットを追加する ([836367e](https://github.com/YumNumm/EQMonitor/commit/836367ea96412b43ddbd13424cd0a585f8e53e6d))
* 地図描画をfoundationのrender契約経由へ移す ([bbe6032](https://github.com/YumNumm/EQMonitor/commit/bbe603240c199402da805b37b39fcea31206f3eb))
* 市区町村詳細モーダルで地震履歴を並び替えられるようにする ([15e78d4](https://github.com/YumNumm/EQMonitor/commit/15e78d4c5a0412d7e1ee2e07489f58c461c8dbc7))
* 旧震度階級を履歴モデルへ保持する ([9f7b79d](https://github.com/YumNumm/EQMonitor/commit/9f7b79d0a18c59c1201b2f33c8cc94ee25bab9a5))
* 選択中の市区町村を最前面の枠線で強調する ([65b4088](https://github.com/YumNumm/EQMonitor/commit/65b4088beb23e5608a653a5447719b2647ffe425))


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
* iOSのMapLibre色式修正を取り込む ([3a762b2](https://github.com/YumNumm/EQMonitor/commit/3a762b2dd0fc314a016082b0c82833cfa551c549))
* **map:** iOS の quick zoom 中にマップのタップが誤発火するのを修正 ([85718bc](https://github.com/YumNumm/EQMonitor/commit/85718bcb7ee7237c190014f78523a1bdbbae5e91))
* **map:** iOS の quick zoom 中にマップのタップが誤発火するのを修正 ([b32751c](https://github.com/YumNumm/EQMonitor/commit/b32751c864eda8ef85e1d114c09a5605f7c02198))
* NTP, Kmoni時刻動機 ([6e73a52](https://github.com/YumNumm/EQMonitor/commit/6e73a522c00c0d6f755bd41b315aed1108721aac))
* **NTP:** NTP周りのバグ修正 ([d7af602](https://github.com/YumNumm/EQMonitor/commit/d7af6027142c15e4c7c77ea4343119361afa8a78))
* **onboarding:** デバイス登録の失敗後もインラインで再試行できるようにする ([a3c71b4](https://github.com/YumNumm/EQMonitor/commit/a3c71b4712da95926a0c27f60a0afec7d73d5a15))
* **theme:** JMA Standard の震度色を気象庁配色に修正し、ライトの地図背景を白ベースにする ([ff76dd5](https://github.com/YumNumm/EQMonitor/commit/ff76dd5d14606676ecbdcd49e456f7b82f0e95be))
* プレビュー用の widget extension を分けてクラッシュを解消する ([b36fbe7](https://github.com/YumNumm/EQMonitor/commit/b36fbe7375adf1eea1c536ec8df6db549c4f8ef2))
* マップレイヤー設定のセクションを同時に展開できるようにする ([7964064](https://github.com/YumNumm/EQMonitor/commit/7964064ebd95230f543fb60944f131a2019bb2fc))
* マップレイヤー設定のセクションを同時に展開できるようにする ([070be33](https://github.com/YumNumm/EQMonitor/commit/070be33abebc0c93d62c990e652b2574f09b709f))
* レイヤー切り替え時の世代管理を修正 ([c4fa095](https://github.com/YumNumm/EQMonitor/commit/c4fa095abd9fc722fdb71c0fe336df6fbaf36576))
* 予想震度が未発表でも震度バッジを灰色の「-」で表示する ([66e39ea](https://github.com/YumNumm/EQMonitor/commit/66e39eae9c2f8b9a21b572c47e6048995473f1d5))
* 予想震度不明のアイコンをハイフン表示にする ([fd4ed4d](https://github.com/YumNumm/EQMonitor/commit/fd4ed4dd68004d05219dd0a9e4bb631a9df0b328))
* 位置情報APIを3桁地域コードへ移行 ([f7d2a39](https://github.com/YumNumm/EQMonitor/commit/f7d2a39f683efb1fff5c8dd75feecb218d6a14d8))
* 到達後もカウントダウン表示を00:00のまま維持する ([dea6290](https://github.com/YumNumm/EQMonitor/commit/dea6290875db12c3128cdf8a8f368e20a7703691))
* 市区町村別最大震度のタップを常に市区町村選択にする ([d93342a](https://github.com/YumNumm/EQMonitor/commit/d93342af046752de8458d9ae203ee4c876fd5acf))
* 旧震度5を履歴一覧に表示する ([46088fb](https://github.com/YumNumm/EQMonitor/commit/46088fbfd70a5f6944818046e9311e4767fa23d5))
* 深発注意文の条件をJMA表記に合わせ深さ150kmより深い場合に限定する ([b000926](https://github.com/YumNumm/EQMonitor/commit/b00092606650b8a3b84a6906d3cd2f9da714a29d))
* 深発注意文の表示条件を専用クラスに切り出してテストする ([3a8a0d0](https://github.com/YumNumm/EQMonitor/commit/3a8a0d05d123260c4c1efa324290aa3c8493fc3c))
* 現在地の震度カードを測位精度に応じた粒度で表示する ([a90f242](https://github.com/YumNumm/EQMonitor/commit/a90f242e5175ad890af4d2f1b45acb6e007ad03f))
* 震度スケールの目盛り見切れを修正 ([5986689](https://github.com/YumNumm/EQMonitor/commit/598668925864edd2912982160fbe72f30c919ff2))
* 震度スケールの目盛り見切れを修正する ([3e99b8e](https://github.com/YumNumm/EQMonitor/commit/3e99b8eda515c0df50ae7a1651a15561160b3b00))
* 震度履歴の最終更新時刻を aggregatedAt に追従する ([59df276](https://github.com/YumNumm/EQMonitor/commit/59df2761097a440d0291b8277566968f3d2a1da0))
* 震度履歴パネルの更新時刻表示にテストと説明を揃える ([3c2d90e](https://github.com/YumNumm/EQMonitor/commit/3c2d90e10576c57786f934570bd6af0d47c83437))


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
