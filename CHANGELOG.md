# Changelog

## [2.7.0](https://github.com/YumNumm/EQMonitor/compare/v2.6.0...v2.7.0) (2026-09-12)


### Features

* Android位置同期leaseを永続化 ([170a42e](https://github.com/YumNumm/EQMonitor/commit/170a42e9298f14d766e7549824ff979e75ab09da))
* Android終了中の位置同期を永続実行 ([db4fc72](https://github.com/YumNumm/EQMonitor/commit/db4fc722cc754e3fded505f05bd1256df34fcdcd))
* AppClockをGPU地図へ注入 ([52a10ab](https://github.com/YumNumm/EQMonitor/commit/52a10ab3eba478ec97028942b900b84e3cede7de))
* BaseMapViewへsprite resourceを統合 ([dd3405d](https://github.com/YumNumm/EQMonitor/commit/dd3405d239f500cca4c672ac42dbc094f614779e))
* BaseMapViewへ地震overlay lifecycleを接続 ([03093a2](https://github.com/YumNumm/EQMonitor/commit/03093a2a1d8cbe3fe0ba467236a9eef448f3bf32))
* Better Authのセッション基盤を追加する ([35307ae](https://github.com/YumNumm/EQMonitor/commit/35307aec21115a3a24c86800abeee2bc97397b80))
* clock modeで地震overlay世代を失効 ([379ec56](https://github.com/YumNumm/EQMonitor/commit/379ec566e631a74c33fd661e36bff18bb8a77788))
* debug map GPU probe UIを追加 ([8036cb0](https://github.com/YumNumm/EQMonitor/commit/8036cb0ccd8f523506be90ede3645ea5f663c2f6))
* Dynamic Islandに現在地優先の表示を反映する ([2baf012](https://github.com/YumNumm/EQMonitor/commit/2baf01213492f58217d904eda5561e846590b1ac))
* exact tile coverageをScene commitへ統合 ([c47cf64](https://github.com/YumNumm/EQMonitor/commit/c47cf645da8d269db4d06b4b5b258469b558e3aa))
* Fill meshの自己交差失敗型を追加 ([acbbc0f](https://github.com/YumNumm/EQMonitor/commit/acbbc0f3f951a099d3663895f8efe40d8b2bdacd))
* Flutter Scene sprite resource所有とprobeを統合 ([1e6b4ed](https://github.com/YumNumm/EQMonitor/commit/1e6b4ed334bf182313f53fdd61be995b3edc23f3))
* Flutter Scene sprite resource所有を実装 ([99e6da5](https://github.com/YumNumm/EQMonitor/commit/99e6da5c17872e307a1f7beff15c5464922973e3))
* GoogleとAppleのNative認証を追加する ([6813cd6](https://github.com/YumNumm/EQMonitor/commit/6813cd6103413c03a5aa92d07799d23a67b55910))
* GPU map probe契約を追加 ([e453e67](https://github.com/YumNumm/EQMonitor/commit/e453e6719897fc64bb8c0065f9d9aa634f12b01f))
* GPU map sprite batchを追加 ([88fb76c](https://github.com/YumNumm/EQMonitor/commit/88fb76cb2fe213643a1215ec3e2aa1efd443407e))
* GPU probe設定を継続更新 ([126bbcf](https://github.com/YumNumm/EQMonitor/commit/126bbcf8aef9002f697c88bb2bab55908e478214))
* GPUデバッグ地図の診断UIを強化 ([13e84a7](https://github.com/YumNumm/EQMonitor/commit/13e84a7a429f5bc33619308a393f83deb7ec1418))
* GPUデバッグ地図の診断操作を強化 ([f503d66](https://github.com/YumNumm/EQMonitor/commit/f503d66db98aa1b380b70bac80d89420ecce85f5))
* GPU地図のcamera commandとAppClockを統合 ([e7910a2](https://github.com/YumNumm/EQMonitor/commit/e7910a2c16c292721fc195e704389d628fc1f27a))
* GPU地図のcamera controllerを公開 ([15637fd](https://github.com/YumNumm/EQMonitor/commit/15637fd9670cb78ef1aca4bd03c3566046aae3ec))
* GPU地図のsprite atlasとzoom policy契約を追加 ([223c7e0](https://github.com/YumNumm/EQMonitor/commit/223c7e0e52e26e1a1769ad5b98897f7d008f6c09))
* GPU地図のsprite batchとshader契約を追加 ([37c1d43](https://github.com/YumNumm/EQMonitor/commit/37c1d43fff3337ad7bd17805576a338ea7c1f56f))
* GPU地図の震度coverage診断を追加 ([3cd08d5](https://github.com/YumNumm/EQMonitor/commit/3cd08d5ae8f5c0d94b81cb1692f75f222066f122))
* GPU地図の震源移動Actionを追加 ([19432ed](https://github.com/YumNumm/EQMonitor/commit/19432ede526731e6b23fd478de60031e3186f49f))
* GPU地図の震源移動Actionを追加 ([095bcbd](https://github.com/YumNumm/EQMonitor/commit/095bcbd8848a9a80ab194cf0b9b30aa5ecf6b6ff))
* GPU地図へ地震震源spriteを統合 ([e0f4302](https://github.com/YumNumm/EQMonitor/commit/e0f430285874d7a2c346b8b5a3873f931633c49c))
* gzip展開byteをchunk単位で制限 ([76c9ae7](https://github.com/YumNumm/EQMonitor/commit/76c9ae765451f1aa9ac7dd11492175b3590671b0))
* **home:** EEWフォーカス中のホーム操作を無効化 ([9d6dd86](https://github.com/YumNumm/EQMonitor/commit/9d6dd864fb824a4e9fd52669bbc349f761c6f9a2))
* **home:** EEWフォーカス状態遷移を追加 ([3e64262](https://github.com/YumNumm/EQMonitor/commit/3e642625c4dbbdee8280fdac469089fdcd9c7ffd))
* **home:** 地図操作でEEWフォーカスを解除 ([02b9edb](https://github.com/YumNumm/EQMonitor/commit/02b9edb32a615c4353e62b8800c35d21f3020df1))
* iOS位置同期leaseを永続化 ([6a0e611](https://github.com/YumNumm/EQMonitor/commit/6a0e611d2064602989360a4db69f4c22b1d9e05b))
* iOS終了中の位置同期を完了管理 ([63e1439](https://github.com/YumNumm/EQMonitor/commit/63e143996376e2d3e3cb9f76f1dea648c98cbafc))
* JWTからDevice IDを取得 ([6f0a5c6](https://github.com/YumNumm/EQMonitor/commit/6f0a5c69b186f9313b776a5ad1a6e70aab4b579f))
* map camera bounds fitterを追加 ([31e8066](https://github.com/YumNumm/EQMonitor/commit/31e80664211ff4428f76ee7f94c31196052cc5e6))
* map sprite atlas契約を追加 ([19852a7](https://github.com/YumNumm/EQMonitor/commit/19852a71f65840d7ae4b2c2036876c802aa7e88d))
* map zoom policyとsprite featureを追加 ([46aef9d](https://github.com/YumNumm/EQMonitor/commit/46aef9d83e5d9c0d3d501313c0265385156fd603))
* MVT文字列propertyを上限付きでdecode ([844d925](https://github.com/YumNumm/EQMonitor/commit/844d925bb00d0f92141adc7f0113ebb59b8a83ee))
* Native Better Authログインを追加する ([a0e5399](https://github.com/YumNumm/EQMonitor/commit/a0e5399fb847d04935701d218ef76f215348bcab))
* Native認証のデバッグ画面を追加する ([b039043](https://github.com/YumNumm/EQMonitor/commit/b0390436b67989dc14d2cc6bdcf9f376031afe07))
* overlay coverageの値変更通知を追加 ([ecf73a0](https://github.com/YumNumm/EQMonitor/commit/ecf73a0d04ada4e2cf113c21506f2865a30a7da0))
* overlay digestとincarnation生成を追加 ([e490fa8](https://github.com/YumNumm/EQMonitor/commit/e490fa8f37b183ffe76a23a967dbecc558edebbd))
* overlay frameをsubmit後にcommit ([501ea2e](https://github.com/YumNumm/EQMonitor/commit/501ea2e2357a48ff85e51ddc8de518c31a778f94))
* overlay version stamp契約を追加 ([46df57c](https://github.com/YumNumm/EQMonitor/commit/46df57c9ed27216a993edb423c6e27cfcad6ad15))
* Passkey登録とサインインを追加する ([53636ba](https://github.com/YumNumm/EQMonitor/commit/53636bae120b4c7cd737b0bcea88dd7e7512aba9))
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
* Scene adapterへsprite stageを追加 ([0c38dce](https://github.com/YumNumm/EQMonitor/commit/0c38dce7158e26be357f976dcb8a7f4d936b1afa))
* Scene全体の描画phase policyを共有 ([c9797cc](https://github.com/YumNumm/EQMonitor/commit/c9797cc9782cddb0fecb0819824d55abb776ecb5))
* seismicityへresource超過を伝播 ([73438de](https://github.com/YumNumm/EQMonitor/commit/73438dedfe792a90c4ccd1c8cf2e5895c455fcb1))
* Siriの検索語をアプリ内検索へ渡す ([8ed9481](https://github.com/YumNumm/EQMonitor/commit/8ed94818dc827ccc82e0ae0c1bc94c8a83af251d))
* sprite batchをScene frameへ統合 ([e168a25](https://github.com/YumNumm/EQMonitor/commit/e168a25336a8be67d1a628c4fdb85896b83c83f3))
* sprite GPU bindingを追加 ([4fcb46a](https://github.com/YumNumm/EQMonitor/commit/4fcb46a54e653ec7f2715ffaff1a63860085c781))
* Tokyo時刻フォーマッターを追加する ([d63e64d](https://github.com/YumNumm/EQMonitor/commit/d63e64d7b1332a54cf96fc03cb062712bfbd07f4))
* Webhookデータアクセスを追加 ([2376678](https://github.com/YumNumm/EQMonitor/commit/237667809396763bbf3773580de10ddcb7ac56e3))
* デバッグ画面にWebhook管理を追加 ([6425a9f](https://github.com/YumNumm/EQMonitor/commit/6425a9f2d18906a9246cd9c8108b061ccea8997e))
* デバッグ画面にWebhook管理を追加 ([c0871ad](https://github.com/YumNumm/EQMonitor/commit/c0871ade30ace51d4dfb53565de01b582034fd05))
* ロック画面を現在地震度中心の配置へ変更する ([919fa3d](https://github.com/YumNumm/EQMonitor/commit/919fa3dfb7e535fc456c9a63887501c3fdf55451))
* 位置同期leaseのnative契約を生成 ([d620bf6](https://github.com/YumNumm/EQMonitor/commit/d620bf6aef329f4e419910951e399c7c4c79d7f0))
* 位置情報同期判定を共通化 ([ea24751](https://github.com/YumNumm/EQMonitor/commit/ea2475193bedc40f8249aaf49d5c1731085a9489))
* 最新地震overlayの世代管理を追加 ([e858a1c](https://github.com/YumNumm/EQMonitor/commit/e858a1caa65812886ae68c0d3562dcd4c9fa1525))
* 最新地震overlayをデバッグ地図へ接続 ([2aae47b](https://github.com/YumNumm/EQMonitor/commit/2aae47b273f02df70f424ce1646670d02a5cbe35))
* 区域code付き震度Fill geometryを保持 ([66218c0](https://github.com/YumNumm/EQMonitor/commit/66218c085283046db4087e2c43825438c795f7ba))
* 地図操作でEEWフォーカスを解除する ([d4619d7](https://github.com/YumNumm/EQMonitor/commit/d4619d77888862a677f5a7ff49b87c00c7c49bf2))
* 地域パラメータから検索結果を非同期に取得する ([7e941fa](https://github.com/YumNumm/EQMonitor/commit/7e941fa97b68852b2c4ffe2c16c44f2771bd7c19))
* 地域候補を選んで地震履歴を開く画面を追加する ([cfd0b9e](https://github.com/YumNumm/EQMonitor/commit/cfd0b9e85fa222bd2bc1c38fcfe1e4e11ab5350e))
* 地域名から地震履歴の検索候補を作る ([12353a6](https://github.com/YumNumm/EQMonitor/commit/12353a6e7be0653ba788b3d41f03fec76d85ba64))
* 地震map sprite atlas providerを追加 ([f72b5a2](https://github.com/YumNumm/EQMonitor/commit/f72b5a220a3eaef3728200a7610d8ce35af5f8ba))
* 地震map sprite atlasを構築 ([ab4407e](https://github.com/YumNumm/EQMonitor/commit/ab4407e690f67c43ccad051b77c91b303fbd4613))
* 地震overlay coverage診断型を追加 ([96b821a](https://github.com/YumNumm/EQMonitor/commit/96b821adabaf7fa8f14d825c73e2261b831f781f))
* 地震overlay frame統合境界を追加 ([9a2be11](https://github.com/YumNumm/EQMonitor/commit/9a2be117291e9e1df3dc3a7b2c38b31c842453fd))
* 地震overlay materialをDataAssetsへ接続 ([be3fc84](https://github.com/YumNumm/EQMonitor/commit/be3fc8492eb2611d3d89c9278a43b62d37998479))
* 地震overlay snapshot契約を公開 ([ef51b1f](https://github.com/YumNumm/EQMonitor/commit/ef51b1f66d1cc474375dfb69209e612ed814931d))
* 地震overlayへsprite atlasを統合 ([cbd7ea9](https://github.com/YumNumm/EQMonitor/commit/cbd7ea91c727a77ce7ceb89dd6ec90f0691213c2))
* 地震snapshotへsprite入力を追加 ([7edc195](https://github.com/YumNumm/EQMonitor/commit/7edc19595e041b33f395dd962698989e3a55401d))
* 地震と速報の詳細をペイン内の地図とシートで表示 ([3320f95](https://github.com/YumNumm/EQMonitor/commit/3320f9597ea2dfa4feccd5bc5f0cd78670e9c195))
* 地震履歴・緊急地震速報一覧のタブレットと折りたたみ表示に対応 ([6a5bc16](https://github.com/YumNumm/EQMonitor/commit/6a5bc16bdc56deb4f2f69ee27c4a5a6737e63e20))
* 地震履歴一覧をタブレットの二画面表示に対応 ([43d3d61](https://github.com/YumNumm/EQMonitor/commit/43d3d611cad2b497b09b209ff3e0c2e323382e6e))
* 地震情報のoverlay変換を追加 ([daaa151](https://github.com/YumNumm/EQMonitor/commit/daaa1511527c91ffbb8b37080f3cc9834d186cb0))
* 地震情報の音声応答を追加する ([20a02f2](https://github.com/YumNumm/EQMonitor/commit/20a02f265928532a32b0a9fb210d9096e9ee4d40))
* 地震検索のディープリンクと経路を追加する ([f5f5409](https://github.com/YumNumm/EQMonitor/commit/f5f5409cfa02e85e309b3c97bd6cd32b2f705367))
* 地震震源をGPU sprite入力へ変換 ([3c7bf49](https://github.com/YumNumm/EQMonitor/commit/3c7bf49576484e61bcccc54070e1985143c39391))
* 履歴ペインのスクロール領域と選択表示を分離 ([814aaac](https://github.com/YumNumm/EQMonitor/commit/814aaac7681d009b9fde6e4b2b7250e7b889f171))
* 市区町村詳細モーダルで地震履歴を並び替えられるようにする ([15e78d4](https://github.com/YumNumm/EQMonitor/commit/15e78d4c5a0412d7e1ee2e07489f58c461c8dbc7))
* 推計震度archive file検証境界を定義 ([577d9f5](https://github.com/YumNumm/EQMonitor/commit/577d9f518a9a4a1c7a065f2e1c8197cb0b18cbd0))
* 推計震度archive headerを検証 ([1e77006](https://github.com/YumNumm/EQMonitor/commit/1e7700613b5d95748e6873f6ae2a51a5a18aed1e))
* 推計震度archive HTTP操作を分離 ([92b6626](https://github.com/YumNumm/EQMonitor/commit/92b66268a4d727556a159348530ccf4983a301d5))
* 推計震度archive path validatorを追加 ([21bd180](https://github.com/YumNumm/EQMonitor/commit/21bd180f95a8959e6087cb1d879430f5fb314b0f))
* 推計震度archive streamを検証 ([51dabcf](https://github.com/YumNumm/EQMonitor/commit/51dabcf80a86e5bf3a94380a14e29a969a378960))
* 推計震度archive URL policyを検証 ([30cf6f9](https://github.com/YumNumm/EQMonitor/commit/30cf6f9275a338422fb6ceaf6fbf814440481d0b))
* 推計震度archive停止を管理 ([99c3ff8](https://github.com/YumNumm/EQMonitor/commit/99c3ff82da7fb63091fd7c9faf73235df07101fa))
* 推計震度archive取得を検証 ([36fe9dc](https://github.com/YumNumm/EQMonitor/commit/36fe9dc6a0b2fc23f844bcbdcb26ab3b1fb78114))
* 推計震度archive取得を統合 ([0071b40](https://github.com/YumNumm/EQMonitor/commit/0071b40fd744ba1506dd46f25abe796c89e1a110))
* 推計震度archive取得上限を定義 ([2d30cb0](https://github.com/YumNumm/EQMonitor/commit/2d30cb061ea6334715bf5e90d1b88fa048c27418))
* 推計震度archive取得結果を型付け ([73c6fdc](https://github.com/YumNumm/EQMonitor/commit/73c6fdc2c19e5a0d173788a1faff32426d5b5b12))
* 推計震度archive境界型を追加 ([c9560a7](https://github.com/YumNumm/EQMonitor/commit/c9560a76fc60bc2d482def0d73879c5d623b4933))
* 推計震度archive応答を検証 ([1da6950](https://github.com/YumNumm/EQMonitor/commit/1da6950af48efa5c8e10c2a48643b8e47583fcf6))
* 推計震度archive書込を直列化 ([bf72219](https://github.com/YumNumm/EQMonitor/commit/bf72219a719abad5ac5dffd990d7ba52511963e7))
* 推計震度decode上限を定義 ([a80bfe1](https://github.com/YumNumm/EQMonitor/commit/a80bfe1b980716d51d783cb2ce522b8ccd102828))
* 推計震度descriptor API clientを同期 ([d25dea0](https://github.com/YumNumm/EQMonitor/commit/d25dea063eb4f323f1785d446a5cbd6af67a5244))
* 推計震度descriptor validatorを追加 ([ec8f24f](https://github.com/YumNumm/EQMonitor/commit/ec8f24f9fc558a5f4adc6e8a559015b5d30a546e))
* 推計震度descriptor検証境界を追加 ([98ef0ac](https://github.com/YumNumm/EQMonitor/commit/98ef0acfae7ba8c3fecd76aa8486cb49e11f227e))
* 推計震度descriptor検証結果を追加 ([070fcaa](https://github.com/YumNumm/EQMonitor/commit/070fcaa252266cfa639a46a18ce707838f0ce230))
* 推計震度header制約を検証 ([ba011c9](https://github.com/YumNumm/EQMonitor/commit/ba011c95c9596ef53f350d49af7426a9e25b302b))
* 推計震度header検証結果を型付け ([e6a6311](https://github.com/YumNumm/EQMonitor/commit/e6a63117ec135d5dca266170a7c3c1fcc508ef62))
* 推計震度MVTをclass別meshへ変換 ([d2814c4](https://github.com/YumNumm/EQMonitor/commit/d2814c4898bd37831a99ff8c43eaeec0bac2a165))
* 推計震度MVTをfail closedでdecode ([1e06a0b](https://github.com/YumNumm/EQMonitor/commit/1e06a0bca9d4d9105519c9aa7bf37043a7d62f74))
* 推計震度PMTiles headerを検証 ([cbe6b5b](https://github.com/YumNumm/EQMonitor/commit/cbe6b5be1b4313136de2c2fdf2758980b958f3a3))
* 推計震度PMTilesの所有権を移譲 ([f389ab9](https://github.com/YumNumm/EQMonitor/commit/f389ab9e12da7b480fb767a65243b16216ca07c4))
* 推計震度tile結果を型付け ([2342520](https://github.com/YumNumm/EQMonitor/commit/2342520466fb38782cc1c34dabbafe287498a02b))
* 旧震度階級を履歴モデルへ保持する ([9f7b79d](https://github.com/YumNumm/EQMonitor/commit/9f7b79d0a18c59c1201b2f33c8cc94ee25bab9a5))
* 未処理位置を利用者別に保持 ([b024b14](https://github.com/YumNumm/EQMonitor/commit/b024b142b82d244345b121c136e417e2cfc68138))
* 現在地の警報対象と震度の表示条件を統一する ([85130b3](https://github.com/YumNumm/EQMonitor/commit/85130b3b77294bdcd10e47d7ff18148245501367))
* 現在地の警報帯と到達予想の表示部品を追加する ([8539eea](https://github.com/YumNumm/EQMonitor/commit/8539eeadb63cf160d0b0ef0145db94d74562ad7e))
* 現在地同期状態を永続化 ([2070be2](https://github.com/YumNumm/EQMonitor/commit/2070be28d8d194e5d1e2f716c97ac2e74df05cbf))
* 現在地震度がない場合に地震発生検知時刻を表示する ([9057958](https://github.com/YumNumm/EQMonitor/commit/9057958f8a3409e4fb30ad01b49e33712029bd4d))
* 現在地震度と最大震度の表示部品を分離する ([2065e73](https://github.com/YumNumm/EQMonitor/commit/2065e73a801b51080933cd160d32910ee9ad715e))
* 終了中の位置同期Workerを追加 ([c42b313](https://github.com/YumNumm/EQMonitor/commit/c42b31317bd5ec4c5e8aa1f62d8fdc3eff9963b4))
* 緊急地震速報一覧の詳細選択と二画面表示に対応 ([e8c9cda](https://github.com/YumNumm/EQMonitor/commit/e8c9cda8ebeeac7810c39bd0ed6d5e07348778e6))
* 表示幅とヒンジ方向から履歴ペインの配置を決定 ([c5b7ee6](https://github.com/YumNumm/EQMonitor/commit/c5b7ee60de1809b583dadf4b13ba9fd4828a1ae9))
* 観測点を単一GPU instance batchで描画 ([a3e772f](https://github.com/YumNumm/EQMonitor/commit/a3e772f5a1597c66d984942e1367212f58ca47bf))
* 通常とheadlessでnative leaseを共有 ([e28d6cc](https://github.com/YumNumm/EQMonitor/commit/e28d6cc67a488108df552b4f4de4d2272c60d661))
* 選択中の市区町村を最前面の枠線で強調する ([65b4088](https://github.com/YumNumm/EQMonitor/commit/65b4088beb23e5608a653a5447719b2647ffe425))
* 選択状態を保持する履歴一覧と詳細の適応表示を追加 ([69627ae](https://github.com/YumNumm/EQMonitor/commit/69627aeac8d48c5d0e348be01fe978f7ce918803))
* 震度Fillを単一Scene compositorへ統合 ([263530c](https://github.com/YumNumm/EQMonitor/commit/263530ce62f550c5f323b7f48b44f2be2fafe32a))
* 震度Fill用packed mesh cacheを追加 ([e452339](https://github.com/YumNumm/EQMonitor/commit/e45233980dcf82e4bd090db1decdbfcac6c993fb))
* 震度overlayをexact tileだけで解決 ([8b67e85](https://github.com/YumNumm/EQMonitor/commit/8b67e8533aa2d7bb25f18d804ae594cb77c6792d))
* 震度区域Fill packetを構築 ([9c807b6](https://github.com/YumNumm/EQMonitor/commit/9c807b63346c4472f3474950272e7c20bbdf3545))
* 震源要素をGoogle Sans Codeで統一する ([22b317c](https://github.com/YumNumm/EQMonitor/commit/22b317cdc3931f2824c1819a262245a60d79df5d))


### Bug Fixes

* AGP9のprofile設定を修正 ([e280f60](https://github.com/YumNumm/EQMonitor/commit/e280f6010a4f987e8d83f88cdc863aa85dae11ae))
* Android headless起動の競合を解消 ([fede96d](https://github.com/YumNumm/EQMonitor/commit/fede96d165c5d46e0f1421f0d89fa5a117b3c564))
* Android raw位置情報をbackup対象外に設定 ([91d65d8](https://github.com/YumNumm/EQMonitor/commit/91d65d86b1e40d1a66650bd29ecc025f4a8c9177))
* Android未処理位置の永続化失敗を復元 ([b775352](https://github.com/YumNumm/EQMonitor/commit/b77535284964d68da0e4c5298c366eea0e652a6f))
* archive書込停止を安全に収束 ([df756e0](https://github.com/YumNumm/EQMonitor/commit/df756e0cab723f3532d057b15cbd46a83fba01bf))
* archive診断処理を専用classへ集約 ([1a3638d](https://github.com/YumNumm/EQMonitor/commit/1a3638d1d280d6d081ae3f8a97632457a5aeb3b9))
* archive長さ取得を停止と同期 ([9c20f6a](https://github.com/YumNumm/EQMonitor/commit/9c20f6ae6dcd6a1b1ce9bb73fead1780924acd21))
* Better Authの認証無効化を強化する ([fe81156](https://github.com/YumNumm/EQMonitor/commit/fe811562833fa57359cb7ff0cf2187506093032a))
* camera commandの旧host副作用を防止 ([c025d8b](https://github.com/YumNumm/EQMonitor/commit/c025d8b6fe972083145c003f6ecab1e8806312f5))
* camera commandをatomic commitへ移行 ([b586688](https://github.com/YumNumm/EQMonitor/commit/b5866889c6a19d5dfb1ee341d7a60021a6fa863d))
* Codex worktreeのローカルセットアップを修復 ([74b8919](https://github.com/YumNumm/EQMonitor/commit/74b8919df44440898e1a130de2baaafe138beeab))
* Codexセットアップでflutter_sceneを初期化 ([1a5fc7f](https://github.com/YumNumm/EQMonitor/commit/1a5fc7fbe756c4ba8e33a106b6a894a6ebe0dcc8))
* consumer変更後に位置監視をreconcile ([0f969e1](https://github.com/YumNumm/EQMonitor/commit/0f969e15876ebb66d781b2abc77e91f621a6c599))
* Control Centerから地震履歴を開く処理を修正 ([192812d](https://github.com/YumNumm/EQMonitor/commit/192812dfa3850490d6ab9d8501b5788163148a78))
* coverage通知を描画commitと一体化 ([b7720df](https://github.com/YumNumm/EQMonitor/commit/b7720dfb84edf22a12a0dec6a96e18539831ec20))
* Device IDヘッダーをJWTへ追従 ([587db7b](https://github.com/YumNumm/EQMonitor/commit/587db7b5d7d828e0b78a6f17b0d1ed224566b79b))
* device再登録で位置同期世代を更新 ([1d30fe4](https://github.com/YumNumm/EQMonitor/commit/1d30fe44b2fa161e86d5979c6168f4d2541e7bab))
* device再登録後の位置監視を整合 ([088c06f](https://github.com/YumNumm/EQMonitor/commit/088c06fc408ccc0485f73511ff7f5d6a91c1fb5e))
* dispose後もGPU完了を待ってgeometryをretire ([f7751bc](https://github.com/YumNumm/EQMonitor/commit/f7751bc9488dafe27dfa277dc172370ecf4091df))
* **earthquake-history:** 地域観測震度と最大震度を分離する ([a670156](https://github.com/YumNumm/EQMonitor/commit/a6701566ad7a0206c49cc309214847e091b2ade1))
* EEW Live Activityのheadlineをライトモードでも白文字にする ([136f742](https://github.com/YumNumm/EQMonitor/commit/136f74218971c38cda9ff9a9164f20775930557f))
* EEWと電文をTokyo時刻表示に統一する ([3126292](https://github.com/YumNumm/EQMonitor/commit/312629295edfabe9827f98f0061a486680b9000a))
* EEW再取得中の表示消失を防ぐ ([112971c](https://github.com/YumNumm/EQMonitor/commit/112971c6d7e2fa5f51a771ecfc9489fffd0789b2))
* EEW再取得中も受信済みデータの表示を維持する ([7045043](https://github.com/YumNumm/EQMonitor/commit/704504386e22672df6c5a9f29a843e3a3b2f6fcd))
* exact overlay結果にsource/tile同一性を保持 ([d672e95](https://github.com/YumNumm/EQMonitor/commit/d672e95ada402c52c20a1d2f3e0d7c2d8221a083))
* Expandedの上段高と外周に沿う角丸を調整する ([adfc62b](https://github.com/YumNumm/EQMonitor/commit/adfc62b17e22e813e79f44d6ce3f7fb57ab21003))
* Expandedの高さ不足と警報名の省略を解消する ([3c07045](https://github.com/YumNumm/EQMonitor/commit/3c070457097a62b31af3c0c1d43907ce3d85f6e2))
* Expanded上部を拡大し警報名の行高を確保する ([0ca1ff1](https://github.com/YumNumm/EQMonitor/commit/0ca1ff1638b8189c9b2a30bbd94f0c8102cb7920))
* Fill meshで境界交差を拒否 ([63ef4e3](https://github.com/YumNumm/EQMonitor/commit/63ef4e3f938d2441ad72d754e3c1fb227bf19232))
* Firebase通知権限の永久拒否状態を表示する ([3235f51](https://github.com/YumNumm/EQMonitor/commit/3235f51b25e0fe6c651d394c87d3d212ab2f2e1c))
* **home:** EEWフォーカスのカメラ制御を安定化 ([f7a9bc5](https://github.com/YumNumm/EQMonitor/commit/f7a9bc523b6146f0f4c5b883493f9a8a2dc7219c))
* Intentの通信エラーを日本語案内へ正規化する ([9a1c2c5](https://github.com/YumNumm/EQMonitor/commit/9a1c2c58990b62faa5e771bcd929b2f7a0a08c4c))
* iOS raw位置情報のbackup除外属性を維持 ([cd6d9d6](https://github.com/YumNumm/EQMonitor/commit/cd6d9d6b80443cea60157a153eb37e005132b03d))
* iOSのMapLibre色式修正を取り込む ([3a762b2](https://github.com/YumNumm/EQMonitor/commit/3a762b2dd0fc314a016082b0c82833cfa551c549))
* iOS未処理位置をロック中も永続化 ([bf642a3](https://github.com/YumNumm/EQMonitor/commit/bf642a3ace4afce0d952546aff26601859dc0a5b))
* iOS未処理位置を原子的に永続化 ([3c65b53](https://github.com/YumNumm/EQMonitor/commit/3c65b5320cd605b8abfff33ccc0fe46b77c83c87))
* iOS終了中の起動経路を堅牢化 ([2442709](https://github.com/YumNumm/EQMonitor/commit/2442709f254c8830b9ec13c8e34d0e84c3360f81))
* iOS配布CIをXcode 27対応runnerへ切り替え ([95bbe51](https://github.com/YumNumm/EQMonitor/commit/95bbe5117d905a271cefc3f1ffece4738fbd912d))
* **knet:** JST以外の端末でK-NETの時刻を正しく扱う ([c1a6dc1](https://github.com/YumNumm/EQMonitor/commit/c1a6dc1a70c1ae0a9282a75d5108f86c53933abf))
* **map:** iOSカメラ操作判定の修正版を参照 ([c4c2382](https://github.com/YumNumm/EQMonitor/commit/c4c2382aaba1827137209f9a8565461c0c214262))
* MapLibre Native修正版へ更新 ([4fdaa60](https://github.com/YumNumm/EQMonitor/commit/4fdaa60976b8ef14016b7c3cc7eaa63633fa131a))
* MapLibre依存のhook修正を反映 ([2c98a49](https://github.com/YumNumm/EQMonitor/commit/2c98a494693a2a17f9ac3dd7d93e9e3a648d2ca7))
* material型をScene更新前にpreflight ([0a87483](https://github.com/YumNumm/EQMonitor/commit/0a87483774faeabef172c04dc5c16d67825ecb7e))
* Native認証デバッグの操作可否を修正する ([2a658b8](https://github.com/YumNumm/EQMonitor/commit/2a658b83ef248c2e02acdf729551b20d48fe4f83))
* Native認証デバッグ画面の状態同期を修正する ([7bff60c](https://github.com/YumNumm/EQMonitor/commit/7bff60c5d3f0e3cf08837932dec525f37dd0a38e))
* Native認証の同時実行とsession確立を堅牢化する ([571e9db](https://github.com/YumNumm/EQMonitor/commit/571e9dbc897d00234776792c0dd1c47a81fe63ae))
* Native認証の解析警告を解消する ([b10bb06](https://github.com/YumNumm/EQMonitor/commit/b10bb06786009e0bb498464d47f220db9f9fdfeb))
* Native認証設定とrollback回帰を強化する ([9f25fb8](https://github.com/YumNumm/EQMonitor/commit/9f25fb8efdc3af183fb21fb04743337c3b70227d))
* non-string propertyの重複keyを拒否 ([921fd02](https://github.com/YumNumm/EQMonitor/commit/921fd0258966061b51b764c2f4ea8357c2786d0f))
* overlay失敗をbase-onlyへ閉じる ([dc74714](https://github.com/YumNumm/EQMonitor/commit/dc747141bc5600f08a9c07dce7bca28293458ea0))
* Passkey cable transportを許可する ([b9412b7](https://github.com/YumNumm/EQMonitor/commit/b9412b78e2c67ba6c0c0338a64554eda94d742d2))
* Passkey transport互換性を修正する ([333864c](https://github.com/YumNumm/EQMonitor/commit/333864cbfd6f19e1a60ae71471d069a703b137db))
* Passkey認証の競合と検証境界を修正する ([c28a75c](https://github.com/YumNumm/EQMonitor/commit/c28a75ca5fe43b24a8ccf6584066921fe404bce8))
* PMTiles directory entryを確保前に制限 ([38da17e](https://github.com/YumNumm/EQMonitor/commit/38da17ebb6c555326c77847652b1c77125242d3f))
* PMTiles leafキャッシュをLRU制限 ([be24e74](https://github.com/YumNumm/EQMonitor/commit/be24e74e91bac4e1826ee697511d43eabcd0556e))
* PMTiles移行後のlintとtest callerを修正 ([3f1bd53](https://github.com/YumNumm/EQMonitor/commit/3f1bd53a3d1f18abe2a7f16ed8560d394183a5dd))
* PMTiles負値設定をopen時に拒否 ([76d966a](https://github.com/YumNumm/EQMonitor/commit/76d966a312cfe7908d6b7f90ef0065c37516c336))
* PMTiles配布元の文字列表現を秘匿 ([a0b9a55](https://github.com/YumNumm/EQMonitor/commit/a0b9a55a67dde14b2531183c522fca90465d62c0))
* Polygon meshの不正入力を拒否 ([4abfe7e](https://github.com/YumNumm/EQMonitor/commit/4abfe7ef4e7fc82d2734e4ffc9088a5f2be5568b))
* Polygonの島構造を許可 ([4b6c171](https://github.com/YumNumm/EQMonitor/commit/4b6c1713d894ce6ce5ee53421914eba01b33f8d6))
* Polygon外積の符号を正確化 ([e1dd62f](https://github.com/YumNumm/EQMonitor/commit/e1dd62fa4f7b47c5064183cf455df4a74ea6d247))
* Polygon面積の符号を正確化 ([57c81c0](https://github.com/YumNumm/EQMonitor/commit/57c81c0bbc38d07be8f988e348b9a17ce36b4cac))
* replay fileごとにclock sessionを更新 ([ece8f42](https://github.com/YumNumm/EQMonitor/commit/ece8f42f4c2319f3362dff68f61722f458ad97e7))
* Scene node上限違反を型付け ([69eea42](https://github.com/YumNumm/EQMonitor/commit/69eea4279569a89a42f0e890259fe7444c39e350))
* Scene更新前に全batchをpreflight ([b0283b2](https://github.com/YumNumm/EQMonitor/commit/b0283b2908f6c87ba2ab82af4144b01277cccf56))
* Siriのアプリ名を揃えてIntentテストを登録する ([4a1fda8](https://github.com/YumNumm/EQMonitor/commit/4a1fda80b6026b2e8a93d120d8117a2568613573))
* snapshot置換時に観測点geometryを更新 ([d61550b](https://github.com/YumNumm/EQMonitor/commit/d61550bbd4a46bbc364f24ae15cc2cb16693001b))
* sprite candidateと初期化失敗を分離 ([434858d](https://github.com/YumNumm/EQMonitor/commit/434858de74ab432ef07a3c583e0867351d656760))
* sprite policyのsigned zeroを正規化 ([398a5a6](https://github.com/YumNumm/EQMonitor/commit/398a5a68bb41e4d48f2e80cf4c5ec645f2d212c7))
* sprite resource retirementを堅牢化 ([2178fe5](https://github.com/YumNumm/EQMonitor/commit/2178fe50377dbd24f17bc422ba0a37c25a503446))
* Stacked PRのworkflow filterを修正 ([534c289](https://github.com/YumNumm/EQMonitor/commit/534c289de08adc2d0b1c7b0cf1e2f4f29d907898))
* Swift APIに歴史震度分類を追加する ([b4a94f6](https://github.com/YumNumm/EQMonitor/commit/b4a94f6143c1afe23bfba744a920eb3ffdffb6c3))
* UIScene復帰時の位置同期retryを再登録 ([ab32201](https://github.com/YumNumm/EQMonitor/commit/ab32201fa8cefa7b17693e006abcc18c35fc05c5))
* カタログと通知の時刻表示をJSTに統一 ([73fd37a](https://github.com/YumNumm/EQMonitor/commit/73fd37a549ea6d9b3cb5f9ad5f65f81ea23f0c63))
* コントロールセンターから地震履歴を開く導線を修正 ([bbf5c76](https://github.com/YumNumm/EQMonitor/commit/bbf5c768934cab4287f52d6cb757a716c7ee710e))
* デバッグと診断の時刻表示をJSTに統一 ([5487580](https://github.com/YumNumm/EQMonitor/commit/5487580cba7d259faeeebd543f3ca49925f3ffa7))
* レイヤー切り替え時の世代管理を修正 ([c4fa095](https://github.com/YumNumm/EQMonitor/commit/c4fa095abd9fc722fdb71c0fe336df6fbaf36576))
* 不要なKeychainAccess解決を削除 ([a516ae4](https://github.com/YumNumm/EQMonitor/commit/a516ae4630fffbbceaade6829e97865f609590ca))
* 位置同期の4xx分類を安全側に修正 ([fd91fb6](https://github.com/YumNumm/EQMonitor/commit/fd91fb6adc501b3268a7f0f6d33dae0a85c5df24))
* 位置同期の反転応答をleaseで抑止 ([06d18a8](https://github.com/YumNumm/EQMonitor/commit/06d18a85fc4b52990a87063507684958f421bdf2))
* 位置同期成功値をbackend scopeへ紐付け ([b9828e7](https://github.com/YumNumm/EQMonitor/commit/b9828e73ae8e2e630e1fe9e059c799e85889783f))
* 位置情報APIを3桁地域コードへ移行 ([f7d2a39](https://github.com/YumNumm/EQMonitor/commit/f7d2a39f683efb1fff5c8dd75feecb218d6a14d8))
* 取消メッセージに先ほどの地震であることを明記する ([651f1b2](https://github.com/YumNumm/EQMonitor/commit/651f1b271f4e947441b66fa570bc4e0888e67a70))
* 取消時の種別と不要な説明文を整理する ([c88ba77](https://github.com/YumNumm/EQMonitor/commit/c88ba77788c51a9b8498bf6c11592c112577e282))
* 地域観測震度Chipを明確化 ([1729be9](https://github.com/YumNumm/EQMonitor/commit/1729be97356d208fd2eab5ba3dbe8af58931cd23))
* 地域観測震度の型と絞り込みを修正 ([4ad9bfd](https://github.com/YumNumm/EQMonitor/commit/4ad9bfd37b91328709ec1b980225d1776a010160))
* 地域震度フィルター表示を明確化 ([a010beb](https://github.com/YumNumm/EQMonitor/commit/a010beb77f36c913b6f70243caee305ce1f51beb))
* 地震Entityの状態と型付きプロパティを公開する ([f2fd1d7](https://github.com/YumNumm/EQMonitor/commit/f2fd1d752a495b4299ded1b94f1ffce852511087))
* 地震Intentの地域検証と取得結果保持を共通化する ([ed2da22](https://github.com/YumNumm/EQMonitor/commit/ed2da222518dc6a00a60fe783f11686239d1d2be))
* 地震overlay version更新を原子的にする ([c07fa20](https://github.com/YumNumm/EQMonitor/commit/c07fa202860caee6ab4248f14820b5fba222cc76))
* 地震overlayのdecode欠損をterminal管理 ([23b4904](https://github.com/YumNumm/EQMonitor/commit/23b4904217902946b83804c7de017741713817b3))
* 地震カードの再描画と明示更新を分離する ([6d184f4](https://github.com/YumNumm/EQMonitor/commit/6d184f4886557527437c5c51202b1461becab8e4))
* 地震履歴の分割表示では詳細の戻るボタンを隠す ([a0ab6d4](https://github.com/YumNumm/EQMonitor/commit/a0ab6d4b32c082ce1f2eebb734b7fdae4756227a))
* 地震履歴の分割表示で詳細の戻るボタンを非表示にする ([3f92e94](https://github.com/YumNumm/EQMonitor/commit/3f92e9468cb351948759b320db61da1c602b78f8))
* 地震履歴の観測点をSymbolのみで描画 ([c225512](https://github.com/YumNumm/EQMonitor/commit/c2255120ddb3d56944aeca7af63820429d7631e8))
* 地震履歴をTokyo時刻表示に統一する ([1c54c75](https://github.com/YumNumm/EQMonitor/commit/1c54c75e051a82dfcd185626e8da0ad2ad0c25f7))
* 地震履歴設定に地域名を表示 ([c97438b](https://github.com/YumNumm/EQMonitor/commit/c97438b54771521c906d9b69ddfe21bb25d2477b))
* 地震履歴設定に地域名を表示 ([b837b46](https://github.com/YumNumm/EQMonitor/commit/b837b46cc551b4dc0b8f5c1e64012fa386de8f3e))
* 地震詳細のSwift API型を最新契約に揃える ([68628cb](https://github.com/YumNumm/EQMonitor/commit/68628cb926a93b027229b2d33f3e4a118d1a906c))
* 地震詳細の復元と地域震度の保持を実装する ([6123a08](https://github.com/YumNumm/EQMonitor/commit/6123a08b872f2bc955b5ca68dd9cb505308d8b9c))
* 市区町村別最大震度のタップを常に市区町村選択にする ([d93342a](https://github.com/YumNumm/EQMonitor/commit/d93342af046752de8458d9ae203ee4c876fd5acf))
* 市区町村履歴を地域震度順で表示 ([0a1702e](https://github.com/YumNumm/EQMonitor/commit/0a1702e9fb4c28e09db11cf20f109daf7b30b933))
* 市区町村震度レイヤーの初回更新を修正 ([5d6d5df](https://github.com/YumNumm/EQMonitor/commit/5d6d5df49f427f877c05416da4f0aae695bfd2ba))
* 推計震度archive cleanupを診断 ([7fbb3f4](https://github.com/YumNumm/EQMonitor/commit/7fbb3f46a0042986bc4fe196de0cf008d2496b72))
* 推計震度archive cleanup失敗を保持 ([5fca029](https://github.com/YumNumm/EQMonitor/commit/5fca02949f099ee2f099a55d6ded5f4f59b191da))
* 推計震度archive hashを中断 ([198a510](https://github.com/YumNumm/EQMonitor/commit/198a5102aeb2bda06fa0ecae5576c75cee706efb))
* 推計震度archive I/O停止を同期 ([71ad35e](https://github.com/YumNumm/EQMonitor/commit/71ad35e24dd933ec3673c2fdd7dc2b15f4bc0840))
* 推計震度archive取得の停止処理を強化 ([cdbb7c1](https://github.com/YumNumm/EQMonitor/commit/cdbb7c1bb523e527acd3290796f32cf34ddb9713))
* 推計震度archive検証結果を再bind ([f4916ce](https://github.com/YumNumm/EQMonitor/commit/f4916ce3d99c294d3f93f6ea1eb27316364b5f10))
* 推計震度headerの例外分類を保持 ([43b2b72](https://github.com/YumNumm/EQMonitor/commit/43b2b72c67321180e6bb383b4108cf0a3f795521))
* 推計震度の不正Polygonを型付き拒否 ([470dc77](https://github.com/YumNumm/EQMonitor/commit/470dc774af2861229b39be1630fea6e3ff16622e))
* 新規地震で履歴Providerを再取得 ([6037a07](https://github.com/YumNumm/EQMonitor/commit/6037a079d5971fdbaf7d6e16761da85ccd666177))
* 旧位置API互換と反映後ackを両立 ([8498294](https://github.com/YumNumm/EQMonitor/commit/8498294c083e02a275c00d5265e1736d766bf921))
* 旧震度5を履歴一覧に表示する ([46088fb](https://github.com/YumNumm/EQMonitor/commit/46088fbfd70a5f6944818046e9311e4767fa23d5))
* 未初期化の位置同期状態を安全に復元 ([6ae00db](https://github.com/YumNumm/EQMonitor/commit/6ae00dbc21a977f9657368f3872ab2d2828f9820))
* 津波と観測情報をTokyo時刻表示に統一する ([e57f59b](https://github.com/YumNumm/EQMonitor/commit/e57f59b89c0d845ae353a764f94104d2e1c095e4))
* 現在地の弱い揺れを薄い蒼の注意帯で表示する ([591d53d](https://github.com/YumNumm/EQMonitor/commit/591d53d647d50ffad917b3b30ea29753e97225ee))
* 観測点instanceの所有権と世代identityを強化 ([99fec31](https://github.com/YumNumm/EQMonitor/commit/99fec314212a1039661ba376940c73d423d3cf45))
* 観測点snapshot identity引数を明示化 ([0d4dc5c](https://github.com/YumNumm/EQMonitor/commit/0d4dc5c676dbe8565d87f7bdaeeb8afad351b6a9))
* 認証無効化中の資格情報復活を防ぐ ([41c406b](https://github.com/YumNumm/EQMonitor/commit/41c406b406c48f25f4fbc18e23d240eb7b8e1c78))
* 起動時に位置監視状態をreconcile ([e1c7ba1](https://github.com/YumNumm/EQMonitor/commit/e1c7ba1c9449e274a298cdf4513676a0c201c7c2))
* 震度Fill geometry cacheをrevisionから分離 ([3804e8d](https://github.com/YumNumm/EQMonitor/commit/3804e8dedef03396b7776e2121a6c5d57edb59a2))
* 震度Fillのpacked mesh identityを保持 ([31c3270](https://github.com/YumNumm/EQMonitor/commit/31c3270f4b0d015ed0ca8317db695f4417962719))
* 震度履歴の読み込み中も戻れるように修正 ([e4d17df](https://github.com/YumNumm/EQMonitor/commit/e4d17df682e1d919c74bd6f73e3eeb8f0cec3d0b))
* 震度履歴パネルの更新時刻表示にテストと説明を揃える ([3c2d90e](https://github.com/YumNumm/EQMonitor/commit/3c2d90e10576c57786f934570bd6af0d47c83437))
* 震度情報の取得エラー表示を改善 ([98fb596](https://github.com/YumNumm/EQMonitor/commit/98fb5960dea4c38618a52996e701ac31f27ff34b))
* 震度速報の地図フォーカスを修正 ([97d12cd](https://github.com/YumNumm/EQMonitor/commit/97d12cd14df70aa9baca633ecd2fb2d616b823f8))
* 音声応答と地震カードで同じ取得結果を表示する ([0528882](https://github.com/YumNumm/EQMonitor/commit/0528882e2a3a7921b605c0c2c3c152fab663f49d))


### Performance Improvements

* atlas差替え時のsprite geometryを再利用 ([8203b84](https://github.com/YumNumm/EQMonitor/commit/8203b84f2875b0e5e08f2eab2e5d25b60fc5a225))
* production sprite hot pathからprobeを除外 ([6467a7b](https://github.com/YumNumm/EQMonitor/commit/6467a7bac4e4f3e56f9017c50609db18a4579ccd))
* 震度style描画資源をsnapshot単位で再利用 ([7b35941](https://github.com/YumNumm/EQMonitor/commit/7b359419e354820c88cec752787582f0a6178c1f))

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
