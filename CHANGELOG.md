# Changelog

## [2.7.0](https://github.com/YumNumm/EQMonitor/compare/v2.6.0...v2.7.0) (2026-09-26)


### Features

* analyzer plugin に Provider/Primary Constructor のルールを追加する ([70418ee](https://github.com/YumNumm/EQMonitor/commit/70418ee8c243d77e8afb8f4798646bafbe5ece43))
* Dynamic Islandに現在地優先の表示を反映する ([2baf012](https://github.com/YumNumm/EQMonitor/commit/2baf01213492f58217d904eda5561e846590b1ac))
* Fill meshの自己交差失敗型を追加 ([acbbc0f](https://github.com/YumNumm/EQMonitor/commit/acbbc0f3f951a099d3663895f8efe40d8b2bdacd))
* Flutter Scene sprite resource所有とprobeを統合 ([1e6b4ed](https://github.com/YumNumm/EQMonitor/commit/1e6b4ed334bf182313f53fdd61be995b3edc23f3))
* GPUデバッグ地図の診断UIを強化 ([13e84a7](https://github.com/YumNumm/EQMonitor/commit/13e84a7a429f5bc33619308a393f83deb7ec1418))
* GPU地図のcamera commandとAppClockを統合 ([e7910a2](https://github.com/YumNumm/EQMonitor/commit/e7910a2c16c292721fc195e704389d628fc1f27a))
* GPU地図のsprite atlasとzoom policy契約を追加 ([223c7e0](https://github.com/YumNumm/EQMonitor/commit/223c7e0e52e26e1a1769ad5b98897f7d008f6c09))
* GPU地図のsprite batchとshader契約を追加 ([37c1d43](https://github.com/YumNumm/EQMonitor/commit/37c1d43fff3337ad7bd17805576a338ea7c1f56f))
* GPU地図の震度coverage診断を追加 ([3cd08d5](https://github.com/YumNumm/EQMonitor/commit/3cd08d5ae8f5c0d94b81cb1692f75f222066f122))
* GPU地図の震源移動Actionを追加 ([19432ed](https://github.com/YumNumm/EQMonitor/commit/19432ede526731e6b23fd478de60031e3186f49f))
* GPU地図へ地震震源spriteを統合 ([e0f4302](https://github.com/YumNumm/EQMonitor/commit/e0f430285874d7a2c346b8b5a3873f931633c49c))
* gzip展開byteをchunk単位で制限 ([76c9ae7](https://github.com/YumNumm/EQMonitor/commit/76c9ae765451f1aa9ac7dd11492175b3590671b0))
* **ios:** 統合 Live Activity の SwiftUI 実装とデザイン確認用 Preview を追加する ([409ad43](https://github.com/YumNumm/EQMonitor/commit/409ad435a5d09c7d936517af499029ff233dcc6f))
* PMTiles directory entry上限を必須化 ([84f8c8d](https://github.com/YumNumm/EQMonitor/commit/84f8c8d66ac723f2f8279dd999a41c187873953c))
* PMTiles gzip展開にbyte上限を適用 ([93224b7](https://github.com/YumNumm/EQMonitor/commit/93224b73f9b3a61bd5c31b8a83c36f15951f81c6))
* PMTiles leafキャッシュ上限を必須化 ([2d27bc4](https://github.com/YumNumm/EQMonitor/commit/2d27bc402dfddf9f35d308980226138dc3a78756))
* PMTiles resource超過を型分類 ([ce9cfaf](https://github.com/YumNumm/EQMonitor/commit/ce9cfaf9c770d2b1d95a40b452367cd5a10cb4b8))
* PMTiles全展開経路にbyte上限を適用 ([178c740](https://github.com/YumNumm/EQMonitor/commit/178c740f6786e32e59320bcb383a6a613306ee6c))
* PMTiles展開とleaf保持量を制限 ([1805db6](https://github.com/YumNumm/EQMonitor/commit/1805db6322c302601b37d5ca0dccb23bc0fd453a))
* Polygon交差比較上限を必須化 ([b18165c](https://github.com/YumNumm/EQMonitor/commit/b18165c5a94a87820b519915c90b4a6d7e3142eb))
* Polygon包含失敗型を追加 ([e5e7280](https://github.com/YumNumm/EQMonitor/commit/e5e7280c02aa45237d741f00887238abdc9d1298))
* Polygon包含関係を検証 ([ae92051](https://github.com/YumNumm/EQMonitor/commit/ae92051a0e76e6a997b8d0ad9d3142fec88e62e3))
* Polygon境界交差検証器を追加 ([8c3270f](https://github.com/YumNumm/EQMonitor/commit/8c3270fb3c798daaa78c1e63f9201f1b287220bd))
* seismicityへresource超過を伝播 ([73438de](https://github.com/YumNumm/EQMonitor/commit/73438dedfe792a90c4ccd1c8cf2e5895c455fcb1))
* Siriの検索語をアプリ内検索へ渡す ([8ed9481](https://github.com/YumNumm/EQMonitor/commit/8ed94818dc827ccc82e0ae0c1bc94c8a83af251d))
* Tokyo時刻フォーマッターを追加する ([d63e64d](https://github.com/YumNumm/EQMonitor/commit/d63e64d7b1332a54cf96fc03cb062712bfbd07f4))
* Webhookデータアクセスを追加 ([2376678](https://github.com/YumNumm/EQMonitor/commit/237667809396763bbf3773580de10ddcb7ac56e3))
* ストアの月額価格と購入可能状態を表示 ([670f252](https://github.com/YumNumm/EQMonitor/commit/670f252a27ebffff371040657bc3d69d4ee4f900))
* デバッグ画面から揺れ検知の地域通知を設定 ([4b44961](https://github.com/YumNumm/EQMonitor/commit/4b449612a62cece8a0927db3eac28276c15de5d0))
* デバッグ画面にWebhook管理を追加 ([6425a9f](https://github.com/YumNumm/EQMonitor/commit/6425a9f2d18906a9246cd9c8108b061ccea8997e))
* デバッグ画面にWebhook管理を追加 ([c0871ad](https://github.com/YumNumm/EQMonitor/commit/c0871ade30ace51d4dfb53565de01b582034fd05))
* ロック画面を現在地震度中心の配置へ変更する ([919fa3d](https://github.com/YumNumm/EQMonitor/commit/919fa3dfb7e535fc456c9a63887501c3fdf55451))
* 共通地域選択に地図選択を実装 ([c1cf733](https://github.com/YumNumm/EQMonitor/commit/c1cf7332cdf6567568a8dc4a5ef8b3088971a3a3))
* 単一と複数を切り替える地域選択画面を追加 ([4799162](https://github.com/YumNumm/EQMonitor/commit/4799162c2d0704adcc43ccfdadb4855e35717ca8))
* 地域パラメータから検索結果を非同期に取得する ([7e941fa](https://github.com/YumNumm/EQMonitor/commit/7e941fa97b68852b2c4ffe2c16c44f2771bd7c19))
* 地域候補を選んで地震履歴を開く画面を追加する ([cfd0b9e](https://github.com/YumNumm/EQMonitor/commit/cfd0b9e85fa222bd2bc1c38fcfe1e4e11ab5350e))
* 地域名から地震履歴の検索候補を作る ([12353a6](https://github.com/YumNumm/EQMonitor/commit/12353a6e7be0653ba788b3d41f03fec76d85ba64))
* 地域選択の型と検索カタログを共通化 ([4c08a01](https://github.com/YumNumm/EQMonitor/commit/4c08a0105eb5a687062134d9aeb997a140036381))
* 地震と速報の詳細をペイン内の地図とシートで表示 ([3320f95](https://github.com/YumNumm/EQMonitor/commit/3320f9597ea2dfa4feccd5bc5f0cd78670e9c195))
* 地震履歴・緊急地震速報一覧のタブレットと折りたたみ表示に対応 ([6a5bc16](https://github.com/YumNumm/EQMonitor/commit/6a5bc16bdc56deb4f2f69ee27c4a5a6737e63e20))
* 地震履歴一覧をタブレットの二画面表示に対応 ([43d3d61](https://github.com/YumNumm/EQMonitor/commit/43d3d611cad2b497b09b209ff3e0c2e323382e6e))
* 地震情報の音声応答を追加する ([20a02f2](https://github.com/YumNumm/EQMonitor/commit/20a02f265928532a32b0a9fb210d9096e9ee4d40))
* 地震検索のディープリンクと経路を追加する ([f5f5409](https://github.com/YumNumm/EQMonitor/commit/f5f5409cfa02e85e309b3c97bd6cd32b2f705367))
* 履歴ペインのスクロール領域と選択表示を分離 ([814aaac](https://github.com/YumNumm/EQMonitor/commit/814aaac7681d009b9fde6e4b2b7250e7b889f171))
* 推計震度archive headerを検証 ([1e77006](https://github.com/YumNumm/EQMonitor/commit/1e7700613b5d95748e6873f6ae2a51a5a18aed1e))
* 推計震度archive streamを検証 ([51dabcf](https://github.com/YumNumm/EQMonitor/commit/51dabcf80a86e5bf3a94380a14e29a969a378960))
* 推計震度archive停止を管理 ([99c3ff8](https://github.com/YumNumm/EQMonitor/commit/99c3ff82da7fb63091fd7c9faf73235df07101fa))
* 推計震度archive取得を検証 ([36fe9dc](https://github.com/YumNumm/EQMonitor/commit/36fe9dc6a0b2fc23f844bcbdcb26ab3b1fb78114))
* 推計震度archive取得を統合 ([0071b40](https://github.com/YumNumm/EQMonitor/commit/0071b40fd744ba1506dd46f25abe796c89e1a110))
* 推計震度archive応答を検証 ([1da6950](https://github.com/YumNumm/EQMonitor/commit/1da6950af48efa5c8e10c2a48643b8e47583fcf6))
* 推計震度archive書込を直列化 ([bf72219](https://github.com/YumNumm/EQMonitor/commit/bf72219a719abad5ac5dffd990d7ba52511963e7))
* 推計震度decode上限を定義 ([a80bfe1](https://github.com/YumNumm/EQMonitor/commit/a80bfe1b980716d51d783cb2ce522b8ccd102828))
* 推計震度descriptor API clientを同期 ([d25dea0](https://github.com/YumNumm/EQMonitor/commit/d25dea063eb4f323f1785d446a5cbd6af67a5244))
* 推計震度descriptor検証境界を追加 ([98ef0ac](https://github.com/YumNumm/EQMonitor/commit/98ef0acfae7ba8c3fecd76aa8486cb49e11f227e))
* 推計震度header制約を検証 ([ba011c9](https://github.com/YumNumm/EQMonitor/commit/ba011c95c9596ef53f350d49af7426a9e25b302b))
* 推計震度header検証結果を型付け ([e6a6311](https://github.com/YumNumm/EQMonitor/commit/e6a63117ec135d5dca266170a7c3c1fcc508ef62))
* 推計震度MVTをclass別meshへ変換 ([d2814c4](https://github.com/YumNumm/EQMonitor/commit/d2814c4898bd37831a99ff8c43eaeec0bac2a165))
* 推計震度MVTをfail closedでdecode ([1e06a0b](https://github.com/YumNumm/EQMonitor/commit/1e06a0bca9d4d9105519c9aa7bf37043a7d62f74))
* 推計震度PMTiles headerを検証 ([cbe6b5b](https://github.com/YumNumm/EQMonitor/commit/cbe6b5be1b4313136de2c2fdf2758980b958f3a3))
* 推計震度PMTilesの所有権を移譲 ([f389ab9](https://github.com/YumNumm/EQMonitor/commit/f389ab9e12da7b480fb767a65243b16216ca07c4))
* 推計震度tile結果を型付け ([2342520](https://github.com/YumNumm/EQMonitor/commit/2342520466fb38782cc1c34dabbafe287498a02b))
* 現在地の警報対象と震度の表示条件を統一する ([85130b3](https://github.com/YumNumm/EQMonitor/commit/85130b3b77294bdcd10e47d7ff18148245501367))
* 現在地の警報帯と到達予想の表示部品を追加する ([8539eea](https://github.com/YumNumm/EQMonitor/commit/8539eeadb63cf160d0b0ef0145db94d74562ad7e))
* 現在地震度がない場合に地震発生検知時刻を表示する ([9057958](https://github.com/YumNumm/EQMonitor/commit/9057958f8a3409e4fb30ad01b49e33712029bd4d))
* 現在地震度と最大震度の表示部品を分離する ([2065e73](https://github.com/YumNumm/EQMonitor/commit/2065e73a801b51080933cd160d32910ee9ad715e))
* 端末IDに結び付けた課金SDK操作を直列化 ([48e3d8b](https://github.com/YumNumm/EQMonitor/commit/48e3d8b18899f2dee615a8a5c015ae954727f466))
* 統合Live ActivityのWidget実装をdevelopへ統合 ([ea57158](https://github.com/YumNumm/EQMonitor/commit/ea57158ff71291136c3624c78f8215542d9c2439))
* 緊急地震速報一覧の詳細選択と二画面表示に対応 ([e8c9cda](https://github.com/YumNumm/EQMonitor/commit/e8c9cda8ebeeac7810c39bd0ed6d5e07348778e6))
* 表示幅とヒンジ方向から履歴ペインの配置を決定 ([c5b7ee6](https://github.com/YumNumm/EQMonitor/commit/c5b7ee60de1809b583dadf4b13ba9fd4828a1ae9))
* 購入後の権限確認と再同期を実装 ([703c0c8](https://github.com/YumNumm/EQMonitor/commit/703c0c83732e5a869563b74a4f5a5e216d7f6b37))
* 購読の同期状態と認証復旧の操作を追加 ([c29cf81](https://github.com/YumNumm/EQMonitor/commit/c29cf810022297bc88344a00292779a37a96d8c7))
* 購読同期APIと応答型の生成を追加 ([8389d4e](https://github.com/YumNumm/EQMonitor/commit/8389d4ed6ba52fea361947f153402dd017851544))
* 購読権限の取得とサーバー同期を追加 ([0f8431a](https://github.com/YumNumm/EQMonitor/commit/0f8431a1abd1579eebe4ce845204f05e06b75c3b))
* 購読状態に同期結果を追加 ([da38e92](https://github.com/YumNumm/EQMonitor/commit/da38e92dad99644df3398bfdf5a54a3f38f9f167))
* 通知設定を確認済みのプラン制限に追従 ([24e14bf](https://github.com/YumNumm/EQMonitor/commit/24e14bf27053604c5784ef4a9a21d7bc50528d6a))
* 選択状態を保持する履歴一覧と詳細の適応表示を追加 ([69627ae](https://github.com/YumNumm/EQMonitor/commit/69627aeac8d48c5d0e348be01fe978f7ce918803))
* 震源要素をGoogle Sans Codeで統一する ([22b317c](https://github.com/YumNumm/EQMonitor/commit/22b317cdc3931f2824c1819a262245a60d79df5d))


### Bug Fixes

* analyzer error ([f3c86ae](https://github.com/YumNumm/EQMonitor/commit/f3c86ae432c684b8f834959658ccffe518a0a5e7))
* analyzer error ([86bf894](https://github.com/YumNumm/EQMonitor/commit/86bf894f1a3579cff0bced4c649faa04840b03fc))
* Android配布で未使用のCodemagic依存を除去 ([fe29945](https://github.com/YumNumm/EQMonitor/commit/fe299456fb9cd0cb9143acc557a2c510e6192b9f))
* archive書込停止を安全に収束 ([df756e0](https://github.com/YumNumm/EQMonitor/commit/df756e0cab723f3532d057b15cbd46a83fba01bf))
* archive診断処理を専用classへ集約 ([1a3638d](https://github.com/YumNumm/EQMonitor/commit/1a3638d1d280d6d081ae3f8a97632457a5aeb3b9))
* archive長さ取得を停止と同期 ([9c20f6a](https://github.com/YumNumm/EQMonitor/commit/9c20f6ae6dcd6a1b1ce9bb73fead1780924acd21))
* CDのmiseダウンロードを有限回再試行 ([f7d1dad](https://github.com/YumNumm/EQMonitor/commit/f7d1dadafac3f6d2a46e664c16db8268bd56787d))
* CD初期ジョブのcheckout時間に余裕を確保 ([a9c9308](https://github.com/YumNumm/EQMonitor/commit/a9c93080843cfc901f2c21acf545a37a210ffb1f))
* **ci:** zizmorの[`self-repository`](https://docs.zizmor.sh/audits/#remediation_26)ルールによる指摘事項に対応 ([6aad416](https://github.com/YumNumm/EQMonitor/commit/6aad4160df3c416f56cdfd01c685c20305f6fb78))
* Codex worktreeのローカルセットアップを修復 ([74b8919](https://github.com/YumNumm/EQMonitor/commit/74b8919df44440898e1a130de2baaafe138beeab))
* Codexセットアップでflutter_sceneを初期化 ([1a5fc7f](https://github.com/YumNumm/EQMonitor/commit/1a5fc7fbe756c4ba8e33a106b6a894a6ebe0dcc8))
* Control Centerから地震履歴を開く処理を修正 ([192812d](https://github.com/YumNumm/EQMonitor/commit/192812dfa3850490d6ab9d8501b5788163148a78))
* Deploy Appの準備段階の失敗を解消 ([ef75f62](https://github.com/YumNumm/EQMonitor/commit/ef75f6287d48af11e2c728ccd9c18cc83847ac8b))
* design ([e8bbb99](https://github.com/YumNumm/EQMonitor/commit/e8bbb99d6f661466276fbe8285debfdc0bdc81af))
* Dynamic IslandのEEW表示を共通化し展開表示の情報を整理 ([ce3cc6d](https://github.com/YumNumm/EQMonitor/commit/ce3cc6d84bd172ab2cd3312f2d46a489a62a3651))
* EEW Live Activityのheadlineをライトモードでも白文字にする ([136f742](https://github.com/YumNumm/EQMonitor/commit/136f74218971c38cda9ff9a9164f20775930557f))
* EEWと電文をTokyo時刻表示に統一する ([3126292](https://github.com/YumNumm/EQMonitor/commit/312629295edfabe9827f98f0061a486680b9000a))
* EEW再取得中の表示消失を防ぐ ([112971c](https://github.com/YumNumm/EQMonitor/commit/112971c6d7e2fa5f51a771ecfc9489fffd0789b2))
* EEW再取得中も受信済みデータの表示を維持する ([7045043](https://github.com/YumNumm/EQMonitor/commit/704504386e22672df6c5a9f29a843e3a3b2f6fcd))
* Expandedの上段高と外周に沿う角丸を調整する ([adfc62b](https://github.com/YumNumm/EQMonitor/commit/adfc62b17e22e813e79f44d6ce3f7fb57ab21003))
* Expandedの高さ不足と警報名の省略を解消する ([3c07045](https://github.com/YumNumm/EQMonitor/commit/3c070457097a62b31af3c0c1d43907ce3d85f6e2))
* Expanded上部を拡大し警報名の行高を確保する ([0ca1ff1](https://github.com/YumNumm/EQMonitor/commit/0ca1ff1638b8189c9b2a30bbd94f0c8102cb7920))
* Fill meshで境界交差を拒否 ([63ef4e3](https://github.com/YumNumm/EQMonitor/commit/63ef4e3f938d2441ad72d754e3c1fb227bf19232))
* Firebase通知権限の永久拒否状態を表示する ([3235f51](https://github.com/YumNumm/EQMonitor/commit/3235f51b25e0fe6c651d394c87d3d212ab2f2e1c))
* Flutter CIのツール解決と同梱アセット準備を限定 ([d338ad1](https://github.com/YumNumm/EQMonitor/commit/d338ad1bd93c814fa18af6eda8042b866945501d))
* Flutter CIの不要なツール導入を防止する ([9ceb6db](https://github.com/YumNumm/EQMonitor/commit/9ceb6dbf0490f92063bbc0517176d8b1e00beaf9))
* Flutterジョブの自リポジトリ展開エラーを回避 ([4dba613](https://github.com/YumNumm/EQMonitor/commit/4dba6139a2a07edcb2fd94c4a7049301b1ef87d1))
* Google Playの編集処理を実行間で直列化 ([3079647](https://github.com/YumNumm/EQMonitor/commit/30796472393772cd550abdbfaa01ca34c23fce77))
* Intentの通信エラーを日本語案内へ正規化する ([9a1c2c5](https://github.com/YumNumm/EQMonitor/commit/9a1c2c58990b62faa5e771bcd929b2f7a0a08c4c))
* iOSの署名済みIPA書き出し時間を確保 ([73f9cea](https://github.com/YumNumm/EQMonitor/commit/73f9cea5a189c089e9196632d968b5ecf3cd9eb0))
* iOS配布CIをXcode 27対応runnerへ切り替え ([95bbe51](https://github.com/YumNumm/EQMonitor/commit/95bbe5117d905a271cefc3f1ffece4738fbd912d))
* **knet:** JST以外の端末でK-NETの時刻を正しく扱う ([c1a6dc1](https://github.com/YumNumm/EQMonitor/commit/c1a6dc1a70c1ae0a9282a75d5108f86c53933abf))
* layout error ([828e7b3](https://github.com/YumNumm/EQMonitor/commit/828e7b3ea1b2bf99f1e6150e0b5bc13b2f724cd7))
* Live ActivityのMAXと震度を中央揃え ([7f36177](https://github.com/YumNumm/EQMonitor/commit/7f36177ec4150b5fbb45ef46d82f2fae20a54a02))
* Live Activityの震源要素と余白を統一し表示の見切れを修正 ([11b2614](https://github.com/YumNumm/EQMonitor/commit/11b26142c40999d04e0553fd330639c9d38eaea7))
* PMTiles directory entryを確保前に制限 ([38da17e](https://github.com/YumNumm/EQMonitor/commit/38da17ebb6c555326c77847652b1c77125242d3f))
* PMTiles leafキャッシュをLRU制限 ([be24e74](https://github.com/YumNumm/EQMonitor/commit/be24e74e91bac4e1826ee697511d43eabcd0556e))
* PMTiles移行後のlintとtest callerを修正 ([3f1bd53](https://github.com/YumNumm/EQMonitor/commit/3f1bd53a3d1f18abe2a7f16ed8560d394183a5dd))
* PMTiles負値設定をopen時に拒否 ([76d966a](https://github.com/YumNumm/EQMonitor/commit/76d966a312cfe7908d6b7f90ef0065c37516c336))
* PMTiles配布元の文字列表現を秘匿 ([a0b9a55](https://github.com/YumNumm/EQMonitor/commit/a0b9a55a67dde14b2531183c522fca90465d62c0))
* Polygon meshの不正入力を拒否 ([4abfe7e](https://github.com/YumNumm/EQMonitor/commit/4abfe7ef4e7fc82d2734e4ffc9088a5f2be5568b))
* Polygonの島構造を許可 ([4b6c171](https://github.com/YumNumm/EQMonitor/commit/4b6c1713d894ce6ce5ee53421914eba01b33f8d6))
* Polygon外積の符号を正確化 ([e1dd62f](https://github.com/YumNumm/EQMonitor/commit/e1dd62fa4f7b47c5064183cf455df4a74ea6d247))
* Polygon面積の符号を正確化 ([57c81c0](https://github.com/YumNumm/EQMonitor/commit/57c81c0bbc38d07be8f988e348b9a17ce36b4cac))
* Siriのアプリ名を揃えてIntentテストを登録する ([4a1fda8](https://github.com/YumNumm/EQMonitor/commit/4a1fda80b6026b2e8a93d120d8117a2568613573))
* Stacked PRのworkflow filterを修正 ([534c289](https://github.com/YumNumm/EQMonitor/commit/534c289de08adc2d0b1c7b0cf1e2f4f29d907898))
* Swift APIに歴史震度分類を追加する ([b4a94f6](https://github.com/YumNumm/EQMonitor/commit/b4a94f6143c1afe23bfba744a920eb3ffdffb6c3))
* XcodeGenの基準ディレクトリをソースと一致させる ([a1f1600](https://github.com/YumNumm/EQMonitor/commit/a1f16006cda2a45d580030ccef7c16b922b483b4))
* アプリの静的解析を通し全体解析の残件を記録 ([5fc0bd6](https://github.com/YumNumm/EQMonitor/commit/5fc0bd64f29ab8281ef7c737dc349fbe4e3df4ac))
* アプリ設定に合わせてマップ配色を切り替える ([52cd267](https://github.com/YumNumm/EQMonitor/commit/52cd267bdee1651cd8f481a2d789ddae59ab1cf9))
* カタログと通知の時刻表示をJSTに統一 ([73fd37a](https://github.com/YumNumm/EQMonitor/commit/73fd37a549ea6d9b3cb5f9ad5f65f81ea23f0c63))
* コントロールセンターから地震履歴を開く導線を修正 ([bbf5c76](https://github.com/YumNumm/EQMonitor/commit/bbf5c768934cab4287f52d6cb757a716c7ee710e))
* デバッグと診断の時刻表示をJSTに統一 ([5487580](https://github.com/YumNumm/EQMonitor/commit/5487580cba7d259faeeebd543f3ca49925f3ffa7))
* ネイティブ検証の全ソースを絶対パスで参照する ([8c7d1f5](https://github.com/YumNumm/EQMonitor/commit/8c7d1f5bba897e42c41b47bfd0d9ccb55183b0ad))
* プレビュー用Bundleをライブアクティビティに限定 ([4212482](https://github.com/YumNumm/EQMonitor/commit/4212482c188d7453a747083a6fc76b758393a5ba))
* もろもろ ([1dea151](https://github.com/YumNumm/EQMonitor/commit/1dea1519dbf4e03dd3ff874309a5af8bdf1ee768))
* レイアウトバグを修正 ([d9d3b0d](https://github.com/YumNumm/EQMonitor/commit/d9d3b0d51ab70f0dc08d3cacd98ccff8bdd5fe28))
* 一時Xcodeプロジェクトからローカル依存を解決する ([05f5b14](https://github.com/YumNumm/EQMonitor/commit/05f5b14d59978a7c5c568cba7f73444407bd620a))
* 最近の地震の再読み込み中も既存一覧を維持 ([6cac7d0](https://github.com/YumNumm/EQMonitor/commit/6cac7d0920142abb01e8b36670e5c33a288d193b))
* 取消メッセージに先ほどの地震であることを明記する ([651f1b2](https://github.com/YumNumm/EQMonitor/commit/651f1b271f4e947441b66fa570bc4e0888e67a70))
* 取消時の種別と不要な説明文を整理する ([c88ba77](https://github.com/YumNumm/EQMonitor/commit/c88ba77788c51a9b8498bf6c11592c112577e282))
* 地域選択地図の非表示フィルターによるクラッシュを修正 ([66b4516](https://github.com/YumNumm/EQMonitor/commit/66b4516558df7d7f78e6e2a6ce9d6115555d6198))
* 地震Entityの状態と型付きプロパティを公開する ([f2fd1d7](https://github.com/YumNumm/EQMonitor/commit/f2fd1d752a495b4299ded1b94f1ffce852511087))
* 地震Intentの地域検証と取得結果保持を共通化する ([ed2da22](https://github.com/YumNumm/EQMonitor/commit/ed2da222518dc6a00a60fe783f11686239d1d2be))
* 地震カードの再描画と明示更新を分離する ([6d184f4](https://github.com/YumNumm/EQMonitor/commit/6d184f4886557527437c5c51202b1461becab8e4))
* 地震履歴の再取得失敗と再試行を表示 ([5973e41](https://github.com/YumNumm/EQMonitor/commit/5973e41e8441453458013d099051c909deac76ab))
* 地震履歴の分割表示では詳細の戻るボタンを隠す ([a0ab6d4](https://github.com/YumNumm/EQMonitor/commit/a0ab6d4b32c082ce1f2eebb734b7fdae4756227a))
* 地震履歴の分割表示で詳細の戻るボタンを非表示にする ([3f92e94](https://github.com/YumNumm/EQMonitor/commit/3f92e9468cb351948759b320db61da1c602b78f8))
* 地震履歴の観測点をSymbolのみで描画 ([c225512](https://github.com/YumNumm/EQMonitor/commit/c2255120ddb3d56944aeca7af63820429d7631e8))
* 地震履歴をTokyo時刻表示に統一する ([1c54c75](https://github.com/YumNumm/EQMonitor/commit/1c54c75e051a82dfcd185626e8da0ad2ad0c25f7))
* 地震履歴設定に地域名を表示 ([c97438b](https://github.com/YumNumm/EQMonitor/commit/c97438b54771521c906d9b69ddfe21bb25d2477b))
* 地震履歴設定に地域名を表示 ([b837b46](https://github.com/YumNumm/EQMonitor/commit/b837b46cc551b4dc0b8f5c1e64012fa386de8f3e))
* 地震詳細のSwift API型を最新契約に揃える ([68628cb](https://github.com/YumNumm/EQMonitor/commit/68628cb926a93b027229b2d33f3e4a118d1a906c))
* 地震詳細の復元と地域震度の保持を実装する ([6123a08](https://github.com/YumNumm/EQMonitor/commit/6123a08b872f2bc955b5ca68dd9cb505308d8b9c))
* 実Widgetの色定義をネイティブテストへ含める ([45daa44](https://github.com/YumNumm/EQMonitor/commit/45daa445b14ccdc6eda49550361ce372a4740172))
* 市区町村別最大震度の選択枠を地域選択UIに合わせる ([88c8b0c](https://github.com/YumNumm/EQMonitor/commit/88c8b0c5b4d91b1a1b1d17f70b9369adba5a261d))
* 推計震度archive cleanupを診断 ([7fbb3f4](https://github.com/YumNumm/EQMonitor/commit/7fbb3f46a0042986bc4fe196de0cf008d2496b72))
* 推計震度archive cleanup失敗を保持 ([5fca029](https://github.com/YumNumm/EQMonitor/commit/5fca02949f099ee2f099a55d6ded5f4f59b191da))
* 推計震度archive hashを中断 ([198a510](https://github.com/YumNumm/EQMonitor/commit/198a5102aeb2bda06fa0ecae5576c75cee706efb))
* 推計震度archive I/O停止を同期 ([71ad35e](https://github.com/YumNumm/EQMonitor/commit/71ad35e24dd933ec3673c2fdd7dc2b15f4bc0840))
* 推計震度archive取得の停止処理を強化 ([cdbb7c1](https://github.com/YumNumm/EQMonitor/commit/cdbb7c1bb523e527acd3290796f32cf34ddb9713))
* 推計震度archive検証結果を再bind ([f4916ce](https://github.com/YumNumm/EQMonitor/commit/f4916ce3d99c294d3f93f6ea1eb27316364b5f10))
* 推計震度headerの例外分類を保持 ([43b2b72](https://github.com/YumNumm/EQMonitor/commit/43b2b72c67321180e6bb383b4108cf0a3f795521))
* 推計震度の不正Polygonを型付き拒否 ([470dc77](https://github.com/YumNumm/EQMonitor/commit/470dc774af2861229b39be1630fea6e3ff16622e))
* 月額商品のID不一致時に購入を停止する ([7696803](https://github.com/YumNumm/EQMonitor/commit/76968038be623e3c42bd0ae8d1a689f8f926d5ad))
* 権限付与後の現在地監視と初回同期を復旧 ([d2c3146](https://github.com/YumNumm/EQMonitor/commit/d2c314602d542b321c7678bab18132d519db84d3))
* 津波と観測情報をTokyo時刻表示に統一する ([e57f59b](https://github.com/YumNumm/EQMonitor/commit/e57f59b89c0d845ae353a764f94104d2e1c095e4))
* 現在地の弱い揺れを薄い蒼の注意帯で表示する ([591d53d](https://github.com/YumNumm/EQMonitor/commit/591d53d647d50ffad917b3b30ea29753e97225ee))
* 細かいUI崩れの修正 ([f8b57a6](https://github.com/YumNumm/EQMonitor/commit/f8b57a683a89c16be38b8de8caf856c2fa12677f))
* 統合Live ActivityのEEW表示モデルと地震情報の扱いを修正 ([fea4458](https://github.com/YumNumm/EQMonitor/commit/fea4458fc88f4b9a36ede51ff97e434591c207e0))
* 統合Live Activityの不要なプレビュー状態を削除 ([3f6e7a9](https://github.com/YumNumm/EQMonitor/commit/3f6e7a9a7d50385278b14ac5a1e860d19e17fc61))
* 統合Live Activityの重複表示を省きロック画面を小型化 ([edc8d79](https://github.com/YumNumm/EQMonitor/commit/edc8d79fe8da6df8f10edeeadee6ee38b0e9ab46))
* 統合Live Activityの震源表示をEEWに統一 ([7949b67](https://github.com/YumNumm/EQMonitor/commit/7949b6749d6e205eb592d32c9c2f115bba9fd58b))
* 観測点詳細シートのはみ出しと表の文字色を修正 ([eabfcf6](https://github.com/YumNumm/EQMonitor/commit/eabfcf6263060de71de05aa9c939e62fc90aedd2))
* 購読APIの端末認証と資格情報変更の通知を追加 ([d8d91ea](https://github.com/YumNumm/EQMonitor/commit/d8d91eac4ff05271d2e364a019c31b1a13f3da30))
* 通知設定の保存応答を再取得前に反映 ([a9501a3](https://github.com/YumNumm/EQMonitor/commit/a9501a379266c19f52aedcfdf77355883677b1f5))
* 震度速報の対象地域から地図の初期表示範囲を設定する ([4cb8cac](https://github.com/YumNumm/EQMonitor/commit/4cb8cac716c9792a7bd0caf82cd567592966d068))
* 震度速報の重複バッジを抑止し巨大地震のM表記を修正 ([9532bc1](https://github.com/YumNumm/EQMonitor/commit/9532bc165ee7d11d26b8a1b395e83a18b9c3458b))
* 音声応答と地震カードで同じ取得結果を表示する ([0528882](https://github.com/YumNumm/EQMonitor/commit/0528882e2a3a7921b605c0c2c3c152fab663f49d))


### Reverts

* api-stub結合テストの削除を別ブランチへ移すため取り消し ([68b7328](https://github.com/YumNumm/EQMonitor/commit/68b7328df873b4120548723161e21a2f00a0271a))

## [v2.6.1](https://github.com/YumNumm/EQMonitor/compare/v2.6.0...v2.6.1) - 2024-08-12
- Fix/ios cd by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/764
- build(deps): bump the dependencies group with 3 updates by @dependabot in https://github.com/YumNumm/EQMonitor/pull/765
- [FIX] 震度データベースのJSON typesを変更 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/768
- fix: Android CD by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/770
- fix: PR Check Workflow by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/771
- fix: replace `以降` to `以前` by @ChanTsune in https://github.com/YumNumm/EQMonitor/pull/769
- release: v2.6.1のリリース準備 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/772

## [v2.6.0](https://github.com/YumNumm/EQMonitor/compare/v2.5.2...v2.6.0) - 2024-08-10
- [FIX] AndroidのNavigationBarを透明に by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/746
- add: Supabaseのスキーマ情報追加 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/748
- Restyle [FEATURE] 震度データベースによる地震履歴 by @restyled-io in https://github.com/YumNumm/EQMonitor/pull/751
- Restyle [FEATURE] 震度データベースによる地震履歴 by @restyled-io in https://github.com/YumNumm/EQMonitor/pull/752
- [FEATURE] 震度データベースによる地震履歴 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/750
- build(deps): bump rexml from 3.2.6 to 3.3.3 in /app/macos by @dependabot in https://github.com/YumNumm/EQMonitor/pull/762

## [v2.5.2](https://github.com/YumNumm/EQMonitor/compare/v2.5.1...v2.5.2) - 2024-06-19
- [FEATURE] Shorebirdの導入・いくつかバグ修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/743
- Restyled/feature/shorebird by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/744
- build(deps): bump melos from 6.0.0 to 6.1.0 by @dependabot in https://github.com/YumNumm/EQMonitor/pull/740

## [v2.5.1](https://github.com/YumNumm/EQMonitor/compare/v2.5.0...v2.5.1) - 2024-06-16
- Auto format - ref: develop by @github-actions in https://github.com/YumNumm/EQMonitor/pull/716
- [FIX CI] Auto Formatの削除 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/721
- [FEATURE] EEWテストの実装・ WebSocketエンドポイント切り替え実装 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/722
- [FIX] Token送信の改善 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/725
- [FEATURE] フィードバック機能の実装 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/726
- [FIX] [FIX] EEW S波到達予想円の色を警報・予報で切り替え by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/727
- [FEATURE] AndroidのDeepLink対応 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/728
- [FIX] デバッグモードの入口封鎖 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/730
- [FEATURE] 気象庁観測点に工学的基盤の増幅率を追加 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/731
- [DEPS] Flutter 3.22.2 へのアップデート by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/734
- [FIX] Sheet layoutの修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/735
- [FIX] Firebase Analyticsの修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/736
- [FIX] CIの修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/738

## [v2.5.0](https://github.com/YumNumm/EQMonitor/compare/v2.4.2...v2.5.0) - 2024-05-31
- update flutter 3.19.6 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/674
- 機内モードで null が出現する問題 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/675
- Firebase App Distributionの整備 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/679
- 【CHORE】xcprivacyファイルをXcodeプロジェクトファイルの管理下にする by @mrs1669 in https://github.com/YumNumm/EQMonitor/pull/678
- Flutter 3.22.0へのアップデート by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/684
- Maplibreのアップデート by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/685
- Fastlaneの修正・マップ配色変更 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/687
- [BUG] 走時表の計算バグ修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/691
- 通知条件設定機能の実装 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/693
- Auto format - ref: develop by @github-actions in https://github.com/YumNumm/EQMonitor/pull/700
- [FEATURE] 通知タップ時の挙動を追加 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/702
- [FIX] マップ配色の変更・マップの色が変わらない問題を修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/704
- [FIX] FABの位置ズレ by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/706
- [FEATURE] 配色切り替えの実装 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/710

## [v2.5.0](https://github.com/YumNumm/EQMonitor/compare/v2.4.2...v2.5.0) - 2024-05-30
- update flutter 3.19.6 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/674
- 機内モードで null が出現する問題 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/675
- Firebase App Distributionの整備 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/679
- 【CHORE】xcprivacyファイルをXcodeプロジェクトファイルの管理下にする by @mrs1669 in https://github.com/YumNumm/EQMonitor/pull/678
- Flutter 3.22.0へのアップデート by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/684
- Maplibreのアップデート by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/685
- Fastlaneの修正・マップ配色変更 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/687
- [BUG] 走時表の計算バグ修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/691
- 通知条件設定機能の実装 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/693
- Auto format - ref: develop by @github-actions in https://github.com/YumNumm/EQMonitor/pull/700
- [FEATURE] 通知タップ時の挙動を追加 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/702
- [FIX] マップ配色の変更・マップの色が変わらない問題を修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/704
- [FIX] FABの位置ズレ by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/706

## [v2.4.2](https://github.com/YumNumm/EQMonitor/compare/v2.4.1...v2.4.2) - 2024-04-20
- Android v2.4.1 において、起動しない問題の緊急対応 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/662

## [v2.4.1](https://github.com/YumNumm/EQMonitor/compare/v2.4.0...v2.4.1) - 2024-04-17
- v2.4.0 に対するhotfix by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/655

## [v2.4.0](https://github.com/YumNumm/EQMonitor/compare/v2.3.3...v2.4.0) - 2024-04-17
- 新サーバ 地震履歴・緊急地震速報の繋ぎこみ by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/611
- チップ機能の実装 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/609
- Auto format - ref: develop by @github-actions in https://github.com/YumNumm/EQMonitor/pull/621
- AndroidのApp内課金の実装 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/622
- build(deps): bump melos from 4.1.0 to 5.3.0 by @dependabot in https://github.com/YumNumm/EQMonitor/pull/623
- ライセンス周りの調整 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/626
- Fragment Shaderの更新 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/628
- プロキシ設定の実装 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/630
- Auto format - ref: develop by @github-actions in https://github.com/YumNumm/EQMonitor/pull/631
- 地震履歴のWebSocket結合 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/632
- iOSの署名管理をCloud-managed certificatesへ変更 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/635
- iOSデプロイ設定ミス by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/637
- Auto format - ref: develop by @github-actions in https://github.com/YumNumm/EQMonitor/pull/638
- iOSとAndroidのCD修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/640
- 地震履歴詳細画面のWebSocket結合 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/643
- 強震モニタのスケール実装 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/645
- Auto format - ref: develop by @github-actions in https://github.com/YumNumm/EQMonitor/pull/647
- 強震モニタスケール設定 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/648
- 海外大規模噴火の扱い修正  by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/649
- 強震モニタ設定の修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/650
- バグ修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/651
- Restyled/fix/support by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/652

## [v2.3.3](https://github.com/YumNumm/EQMonitor/compare/v2.3.2...v2.3.3) - 2024-03-03
- API v3を_oldへ移行し、deprecatedとしてマーク by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/587
- API v1 仮実装 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/589
- ディレクトリ構成の見直し by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/591
- ディレクトリ構成の見直し の対応抜け by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/595
- v2.3.3リリースに向けた調整 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/598

## [v2.3.3](https://github.com/YumNumm/EQMonitor/compare/v2.3.2...v2.3.3) - 2024-03-03
- API v3を_oldへ移行し、deprecatedとしてマーク by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/587
- API v1 仮実装 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/589
- ディレクトリ構成の見直し by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/591
- ディレクトリ構成の見直し の対応抜け by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/595
- v2.3.3リリースに向けた調整 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/598

## [v2.3.2](https://github.com/YumNumm/EQMonitor/compare/v2.3.1...v2.3.2) - 2024-02-22
- Fix/vxse41-crash-bug by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/580
- build(deps): bump envied from 0.5.2 to 0.5.3 by @dependabot in https://github.com/YumNumm/EQMonitor/pull/571
- JMAパラメータ更新用のシェルスクリプトを追加 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/584

## [v2.3.0](https://github.com/YumNumm/EQMonitor/compare/v2.2.2...v2.3.0) - 2024-02-12
- 震度5弱以上未入電が !5- と表示されていた問題を修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/516
- メイン画面のMapLibre化 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/517
- build(deps): bump go_router from 11.1.4 to 13.0.1 by @dependabot in https://github.com/YumNumm/EQMonitor/pull/523
- build(deps): bump intl from 0.18.1 to 0.19.0 by @dependabot in https://github.com/YumNumm/EQMonitor/pull/500
- build(deps): bump urllib3 from 1.26.11 to 1.26.18 in /util/arv by @dependabot in https://github.com/YumNumm/EQMonitor/pull/468
- Auto format - ref: develop by @github-actions in https://github.com/YumNumm/EQMonitor/pull/527
- JMA BBOX by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/528
- 気象庁による 地震・津波のお知らせ by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/529
- S波・P波どちらかの到達予想円がない場合に、例外が漏れる問題を解消 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/533
- 地図色をMaterial Color利用へ変更 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/534
- EQAPI v1 対応への下ごしらえ by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/547
- fix: vxse51 crash bug by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/548
- EEWの表示領域調整追加 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/556
- EEW表示領域調整 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/562

## [v2.2.2](https://github.com/YumNumm/EQMonitor/compare/v2.2.1...v2.2.2) - 2024-01-03
- 地震履歴詳細画面の観測点表示を追加 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/508
- 震度詳細画面の 都道府県ごとの震度が誤っていた問題を修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/510
- すべてのEEWが失効した時に、デフォルトの表示範囲へ戻す by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/512
- Auto format - ref: develop by @github-actions in https://github.com/YumNumm/EQMonitor/pull/511

## [v2.2.1](https://github.com/YumNumm/EQMonitor/compare/v2.2.0...v2.2.1) - 2024-01-03
- docs: Fix outdated syntax in README.md by @siketyan in https://github.com/YumNumm/EQMonitor/pull/501
- ci: Fix failing CI by @siketyan in https://github.com/YumNumm/EQMonitor/pull/502
- Android CDの修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/503
- Auto format - ref: develop by @github-actions in https://github.com/YumNumm/EQMonitor/pull/504
- Fix/everyone topic by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/505

## [v2.0.3](https://github.com/YumNumm/EQMonitor/compare/v2.0.2...v2.0.3) - 2024-01-01
- [iOS] 通知画像が表示されない問題を修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/433
- add: デバッグ時にFCM・APNS Tokenを表示するように by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/434
- Androidの通知関連修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/437
- fix: 旧バージョンのTopic購読を解除 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/439
- [Android] 予測型「戻る」ジェスチャーの仮対応 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/441
- [Android] KmoniStatusのProgressIndicatorのサイズ調整 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/444
- Auto format - ref: develop by @github-actions in https://github.com/YumNumm/EQMonitor/pull/443
- Auto format - ref: develop by @github-actions in https://github.com/YumNumm/EQMonitor/pull/446
- Auto format - ref: develop by @github-actions in https://github.com/YumNumm/EQMonitor/pull/447
- ホーム画面の不要な再描画の抑制 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/453
- 地震履歴詳細画面の震源地 cross-axisを修正 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/452
- build(deps): bump melos from 3.2.0 to 3.4.0 by @dependabot in https://github.com/YumNumm/EQMonitor/pull/451
- build(deps): bump dio_http2_adapter from 2.3.2 to 2.4.0 by @dependabot in https://github.com/YumNumm/EQMonitor/pull/450
- build(deps): bump package_info_plus from 4.2.0 to 5.0.1 by @dependabot in https://github.com/YumNumm/EQMonitor/pull/449
- build(deps): bump dio from 5.3.4 to 5.4.0 by @dependabot in https://github.com/YumNumm/EQMonitor/pull/448
- Temporary Support to Web by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/472
- REST APIのURL切り替え by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/474
- 地震履歴設定のUI構築 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/476
- PLUM法のEEWが、P/S波到達予想円に表示される問題 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/478
- Flutter 3.18.0-0.2-preへアップデート by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/490
- 震度速報のみの表示を改善 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/491
- VXSE51の発表時刻表示 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/492
- 地震履歴の長周期地震動階級周りの実装 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/494
- EEWのLPGM実装 by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/496

## [v2.0.2](https://github.com/YumNumm/EQMonitor/compare/v2.0.1...v2.0.2) - 2023-12-02
- Auto format - ref: develop by @github-actions in https://github.com/YumNumm/EQMonitor/pull/423

## [v2.0.1](https://github.com/YumNumm/EQMonitor/compare/v2.0.0...v2.0.1) - 2023-12-01
- Auto format - ref: develop by @github-actions in https://github.com/YumNumm/EQMonitor/pull/416

## [v2.0.1](https://github.com/YumNumm/EQMonitor/compare/v2.0.0...v2.0.1) - 2023-12-01
- Auto format - ref: develop by @github-actions in https://github.com/YumNumm/EQMonitor/pull/416
