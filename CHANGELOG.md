# Changelog

## [3.0.0](https://github.com/YumNumm/EQMonitor/compare/v3.0.0...v3.0.0) (2026-10-02)


### Features

* analyzer plugin に Provider/Primary Constructor のルールを追加する ([70418ee](https://github.com/YumNumm/EQMonitor/commit/70418ee8c243d77e8afb8f4798646bafbe5ece43))
* HTTPキャッシュにbody合計5MBのLRU削除を導入 ([59491b0](https://github.com/YumNumm/EQMonitor/commit/59491b0fb911696defc758968477d3ecd595f534))
* **ios:** 統合 Live Activity の SwiftUI 実装とデザイン確認用 Preview を追加する ([409ad43](https://github.com/YumNumm/EQMonitor/commit/409ad435a5d09c7d936517af499029ff233dcc6f))
* IS_PRODUCTION設定へ統一しbeta表示を廃止 ([681cfb9](https://github.com/YumNumm/EQMonitor/commit/681cfb9b2e9d8dfa64cc09795bd779dd774e27b7))
* ストアの月額価格と購入可能状態を表示 ([670f252](https://github.com/YumNumm/EQMonitor/commit/670f252a27ebffff371040657bc3d69d4ee4f900))
* デバッグ画面から揺れ検知の地域通知を設定 ([4b44961](https://github.com/YumNumm/EQMonitor/commit/4b449612a62cece8a0927db3eac28276c15de5d0))
* 共通地域選択に地図選択を実装 ([c1cf733](https://github.com/YumNumm/EQMonitor/commit/c1cf7332cdf6567568a8dc4a5ef8b3088971a3a3))
* 単一と複数を切り替える地域選択画面を追加 ([4799162](https://github.com/YumNumm/EQMonitor/commit/4799162c2d0704adcc43ccfdadb4855e35717ca8))
* 地図の簡易観測点モーダルを廃止し地域別震度を表示 ([2c5cba3](https://github.com/YumNumm/EQMonitor/commit/2c5cba3a8012bc6738a5e0d777b80d4c5d6ae41a))
* 地域コードで各地の震度を絞り込む処理を追加 ([fbc0882](https://github.com/YumNumm/EQMonitor/commit/fbc0882ab440c09c4debbcf25a4fcfa266e14ead))
* 地域パラメータから検索結果を非同期に取得する ([7e941fa](https://github.com/YumNumm/EQMonitor/commit/7e941fa97b68852b2c4ffe2c16c44f2771bd7c19))
* 地域候補を選んで地震履歴を開く画面を追加する ([cfd0b9e](https://github.com/YumNumm/EQMonitor/commit/cfd0b9e85fa222bd2bc1c38fcfe1e4e11ab5350e))
* 地域選択の型と検索カタログを共通化 ([4c08a01](https://github.com/YumNumm/EQMonitor/commit/4c08a0105eb5a687062134d9aeb997a140036381))
* 地震と速報の詳細をペイン内の地図とシートで表示 ([3320f95](https://github.com/YumNumm/EQMonitor/commit/3320f9597ea2dfa4feccd5bc5f0cd78670e9c195))
* 地震履歴・緊急地震速報一覧のタブレットと折りたたみ表示に対応 ([6a5bc16](https://github.com/YumNumm/EQMonitor/commit/6a5bc16bdc56deb4f2f69ee27c4a5a6737e63e20))
* 地震履歴一覧をタブレットの二画面表示に対応 ([43d3d61](https://github.com/YumNumm/EQMonitor/commit/43d3d611cad2b497b09b209ff3e0c2e323382e6e))
* 地震検索のディープリンクと経路を追加する ([f5f5409](https://github.com/YumNumm/EQMonitor/commit/f5f5409cfa02e85e309b3c97bd6cd32b2f705367))
* 履歴ペインのスクロール領域と選択表示を分離 ([814aaac](https://github.com/YumNumm/EQMonitor/commit/814aaac7681d009b9fde6e4b2b7250e7b889f171))
* 既定音と震度別設定で追加音を選択 ([59631e5](https://github.com/YumNumm/EQMonitor/commit/59631e53af0ab3004f3908a9c6f32b727307f960))
* 気象庁の都道府県境界データと再生成手順を同梱 ([8f57a0d](https://github.com/YumNumm/EQMonitor/commit/8f57a0d6276589a65d20733f9a2e9ee429dcca55))
* 端末IDに結び付けた課金SDK操作を直列化 ([48e3d8b](https://github.com/YumNumm/EQMonitor/commit/48e3d8b18899f2dee615a8a5c015ae954727f466))
* 統合Live ActivityのWidget実装をdevelopへ統合 ([ea57158](https://github.com/YumNumm/EQMonitor/commit/ea57158ff71291136c3624c78f8215542d9c2439))
* 緊急地震速報一覧の詳細選択と二画面表示に対応 ([e8c9cda](https://github.com/YumNumm/EQMonitor/commit/e8c9cda8ebeeac7810c39bd0ed6d5e07348778e6))
* 表示幅とヒンジ方向から履歴ペインの配置を決定 ([c5b7ee6](https://github.com/YumNumm/EQMonitor/commit/c5b7ee60de1809b583dadf4b13ba9fd4828a1ae9))
* 観測点詳細を共通化してスクロール表示に対応 ([12b8d91](https://github.com/YumNumm/EQMonitor/commit/12b8d91828b1a1dab4e96bac2c347f6379a680f6))
* 購入後の権限確認と再同期を実装 ([703c0c8](https://github.com/YumNumm/EQMonitor/commit/703c0c83732e5a869563b74a4f5a5e216d7f6b37))
* 購読の同期状態と認証復旧の操作を追加 ([c29cf81](https://github.com/YumNumm/EQMonitor/commit/c29cf810022297bc88344a00292779a37a96d8c7))
* 購読同期APIと応答型の生成を追加 ([8389d4e](https://github.com/YumNumm/EQMonitor/commit/8389d4ed6ba52fea361947f153402dd017851544))
* 購読権限の取得とサーバー同期を追加 ([0f8431a](https://github.com/YumNumm/EQMonitor/commit/0f8431a1abd1579eebe4ce845204f05e06b75c3b))
* 購読状態に同期結果を追加 ([da38e92](https://github.com/YumNumm/EQMonitor/commit/da38e92dad99644df3398bfdf5a54a3f38f9f167))
* 追加通知音のモデルを定義 ([3c82a0f](https://github.com/YumNumm/EQMonitor/commit/3c82a0fef365222ab8343b8e33fc88ad66c73e76))
* 追加通知音の管理画面を追加 ([a684027](https://github.com/YumNumm/EQMonitor/commit/a684027fc618bde12d2fb217cb2435758ebf92d4))
* 追加音の一覧と操作 Mutation を公開 ([2ac115e](https://github.com/YumNumm/EQMonitor/commit/2ac115eae88efee6117b1b52e92845226a86f1de))
* 通知設定を確認済みのプラン制限に追従 ([24e14bf](https://github.com/YumNumm/EQMonitor/commit/24e14bf27053604c5784ef4a9a21d7bc50528d6a))
* 通知音の native 操作と試聴を接続 ([3b6b96e](https://github.com/YumNumm/EQMonitor/commit/3b6b96e8b76640461998b65249f80213fc2d6264))
* 通知音のカタログと音声を永続化 ([9f3c9b6](https://github.com/YumNumm/EQMonitor/commit/9f3c9b65feabc0c16405ce304c9fa6da4d5a946f))
* 通知音の追加と保存操作を実装 ([5b5085d](https://github.com/YumNumm/EQMonitor/commit/5b5085d82452ca26bacd082a8e4d8e64c2df931c))
* 通知音の選択と取り込みを Repository に追加 ([2122af0](https://github.com/YumNumm/EQMonitor/commit/2122af0b0507da412ec13f99999cd12d128a53b6))
* 選択状態を保持する履歴一覧と詳細の適応表示を追加 ([69627ae](https://github.com/YumNumm/EQMonitor/commit/69627aeac8d48c5d0e348be01fe978f7ce918803))
* 都道府県境界を非同期で読み込む ([416129f](https://github.com/YumNumm/EQMonitor/commit/416129f072b19f0f722154704584dea1a810cf95))
* 音声の検証と通知用変換を追加 ([88c4bb3](https://github.com/YumNumm/EQMonitor/commit/88c4bb34cb19933b8d0f1a547353954f0d5739b0))


### Bug Fixes

* analyzer error ([f3c86ae](https://github.com/YumNumm/EQMonitor/commit/f3c86ae432c684b8f834959658ccffe518a0a5e7))
* analyzer error ([86bf894](https://github.com/YumNumm/EQMonitor/commit/86bf894f1a3579cff0bced4c649faa04840b03fc))
* Android前面通知の表示をリポジトリへ集約 ([d934006](https://github.com/YumNumm/EQMonitor/commit/d934006971691e4fb3ccb5e392b2274d45ec7c46))
* Android配布で未使用のCodemagic依存を除去 ([fe29945](https://github.com/YumNumm/EQMonitor/commit/fe299456fb9cd0cb9143acc557a2c510e6192b9f))
* App Intentの連続遷移と詳細表示の共通処理を修正 ([919718e](https://github.com/YumNumm/EQMonitor/commit/919718ef372d373b194e6344969a3c819f06fd10))
* Asset Pack インストール失敗カードの題名を内容に合わせる ([14cb2e7](https://github.com/YumNumm/EQMonitor/commit/14cb2e776880af6eb536ca3947ba88eeebb5057d))
* Asset Pack の解析失敗時も同梱版へフォールバック ([2111f8b](https://github.com/YumNumm/EQMonitor/commit/2111f8bd65eebee4754dd5d8a47b653a928c22b2))
* Asset Pack を Android の Auto Backup 対象から除外 ([b734947](https://github.com/YumNumm/EQMonitor/commit/b734947bdeeb52f4eadc4b8cf3a6be00c3096a2b))
* CDのmiseダウンロードを有限回再試行 ([f7d1dad](https://github.com/YumNumm/EQMonitor/commit/f7d1dadafac3f6d2a46e664c16db8268bd56787d))
* CD初期ジョブのcheckout時間に余裕を確保 ([a9c9308](https://github.com/YumNumm/EQMonitor/commit/a9c93080843cfc901f2c21acf545a37a210ffb1f))
* **ci:** zizmorの[`self-repository`](https://docs.zizmor.sh/audits/#remediation_26)ルールによる指摘事項に対応 ([6aad416](https://github.com/YumNumm/EQMonitor/commit/6aad4160df3c416f56cdfd01c685c20305f6fb78))
* Control Centerから地震履歴を開く処理を修正 ([192812d](https://github.com/YumNumm/EQMonitor/commit/192812dfa3850490d6ab9d8501b5788163148a78))
* Deploy Appの準備段階の失敗を解消 ([ef75f62](https://github.com/YumNumm/EQMonitor/commit/ef75f6287d48af11e2c728ccd9c18cc83847ac8b))
* design ([e8bbb99](https://github.com/YumNumm/EQMonitor/commit/e8bbb99d6f661466276fbe8285debfdc0bdc81af))
* device-id読み取り失敗でAPIリクエストを失敗させない ([7fec3fd](https://github.com/YumNumm/EQMonitor/commit/7fec3fd809334f17043a9cf14eca6ec98caec705))
* Dynamic IslandのEEW表示を共通化し展開表示の情報を整理 ([ce3cc6d](https://github.com/YumNumm/EQMonitor/commit/ce3cc6d84bd172ab2cd3312f2d46a489a62a3651))
* EEW再取得中の表示消失を防ぐ ([112971c](https://github.com/YumNumm/EQMonitor/commit/112971c6d7e2fa5f51a771ecfc9489fffd0789b2))
* EEW取消報でカードが消え取消表示が出ない問題を修正 ([0260e00](https://github.com/YumNumm/EQMonitor/commit/0260e000db9e359b4a4bb1aecdafbc95798dad10))
* EEW履歴とイベント別EEWで報の上書き・欠落が起きる問題を修正 ([727f18c](https://github.com/YumNumm/EQMonitor/commit/727f18c43cf29a77e36d70eea79462acda8c4580))
* EEW履歴の発表中セクションに終了済みのEEWが残る問題を修正 ([3c9058a](https://github.com/YumNumm/EQMonitor/commit/3c9058a1b4f395b8bd66f2cb4fe86df25e34bcab))
* Firebase AnalyticsのObjective-Cリンク設定を補完 ([76c27d5](https://github.com/YumNumm/EQMonitor/commit/76c27d5d1a9a0086aa995532ae5a77f9a25a36da))
* Firebase通知権限の永久拒否状態を表示する ([3235f51](https://github.com/YumNumm/EQMonitor/commit/3235f51b25e0fe6c651d394c87d3d212ab2f2e1c))
* Flutter CIのツール解決と同梱アセット準備を限定 ([d338ad1](https://github.com/YumNumm/EQMonitor/commit/d338ad1bd93c814fa18af6eda8042b866945501d))
* Flutter CIの不要なツール導入を防止する ([9ceb6db](https://github.com/YumNumm/EQMonitor/commit/9ceb6dbf0490f92063bbc0517176d8b1e00beaf9))
* Flutterジョブの自リポジトリ展開エラーを回避 ([4dba613](https://github.com/YumNumm/EQMonitor/commit/4dba6139a2a07edcb2fd94c4a7049301b1ef87d1))
* foreground復帰時もPro確認値を保持し通信エラーでは期限まで維持 ([1188210](https://github.com/YumNumm/EQMonitor/commit/11882108d851b8d3a839a4adad8225d96bcfc520))
* Google Playの編集処理を実行間で直列化 ([3079647](https://github.com/YumNumm/EQMonitor/commit/30796472393772cd550abdbfaa01ca34c23fce77))
* headless で保存済み Telegram URL を本体と同じ保存先から読む ([29fc904](https://github.com/YumNumm/EQMonitor/commit/29fc90435b77a4b93fd58b50b0ed074076a73127))
* headless 位置処理で有効なダウンロード版 Asset Pack を読む ([f7e1e65](https://github.com/YumNumm/EQMonitor/commit/f7e1e657bc635bd1e0d73c59107c2baf8b837148))
* Intentの通信エラーを日本語案内へ正規化する ([9a1c2c5](https://github.com/YumNumm/EQMonitor/commit/9a1c2c58990b62faa5e771bcd929b2f7a0a08c4c))
* iOS 26.1未満のLive Activity対応判定を修正 ([c119f85](https://github.com/YumNumm/EQMonitor/commit/c119f85b830de3fe55dce6ba23e7383d036556a4))
* iOS IPA書き出しの通信タイムアウトを再試行 ([4a27d86](https://github.com/YumNumm/EQMonitor/commit/4a27d86619252c257491b15c6b0b15bc9d9bb1a9))
* iOSの未使用トラッキング許可説明を削除 ([783f919](https://github.com/YumNumm/EQMonitor/commit/783f91914fb2acedc8a5305424b77b5434c7ded1))
* iOSの署名済みIPA書き出し時間を確保 ([73f9cea](https://github.com/YumNumm/EQMonitor/commit/73f9cea5a189c089e9196632d968b5ecf3cd9eb0))
* iOS拡張へproductionフラグと機能制限を反映 ([9a557b9](https://github.com/YumNumm/EQMonitor/commit/9a557b9b3220d39798806d34bcc7283c273dd2da))
* iOS通知音のJSONキーをネイティブ応答に統一 ([0ae315b](https://github.com/YumNumm/EQMonitor/commit/0ae315ba75139c01c8e9482aed83483a5366945d))
* iOS配布CIをXcode 27対応runnerへ切り替え ([95bbe51](https://github.com/YumNumm/EQMonitor/commit/95bbe5117d905a271cefc3f1ffece4738fbd912d))
* iOS配布用のAnalytics依存をクラッシュ修正版に更新 ([509316e](https://github.com/YumNumm/EQMonitor/commit/509316ebd67df500340e75b5d157626d6547cbfa))
* layout error ([828e7b3](https://github.com/YumNumm/EQMonitor/commit/828e7b3ea1b2bf99f1e6150e0b5bc13b2f724cd7))
* Live ActivityのMAXと震度を中央揃え ([7f36177](https://github.com/YumNumm/EQMonitor/commit/7f36177ec4150b5fbb45ef46d82f2fae20a54a02))
* Live ActivityのM数値の字間を以前の値に戻す ([41e6e0f](https://github.com/YumNumm/EQMonitor/commit/41e6e0f2327c67a000c5edc626b6607c8cc3c62f))
* Live Activityの震源要素と余白を統一し表示の見切れを修正 ([11b2614](https://github.com/YumNumm/EQMonitor/commit/11b26142c40999d04e0553fd330639c9d38eaea7))
* Paywallの特典をPro限定の実機能に揃え支払い保留文言を調整 ([6e8e736](https://github.com/YumNumm/EQMonitor/commit/6e8e7365cdbbc75dce9a7d29ce26068cacda6678))
* PrivacyInfo に App Group UserDefaults の理由コード 1C8F.1 を追加 ([4a48d56](https://github.com/YumNumm/EQMonitor/commit/4a48d56509499d62603a7b6f631dbb7ad237710e))
* productionで揺れ検知処理と既存通知を無効化 ([3349db2](https://github.com/YumNumm/EQMonitor/commit/3349db221217bf2530d354e5eeda75b14762707d))
* productionのTelemetry保存と送信を停止 ([115df66](https://github.com/YumNumm/EQMonitor/commit/115df66742e3027a6d3af26d5638a5e604f60f48))
* Pro加入状態と共通の利用制限表示を整備 ([294c9d0](https://github.com/YumNumm/EQMonitor/commit/294c9d020834623ce778c0c20a419fc0f954dd4b))
* resume時に端末が未登録ならprovisionをやり直す ([79a6bd8](https://github.com/YumNumm/EQMonitor/commit/79a6bd89044189677f61abba2b4b78311ae9970f))
* Siriのアプリ名を揃えてIntentテストを登録する ([4a1fda8](https://github.com/YumNumm/EQMonitor/commit/4a1fda80b6026b2e8a93d120d8117a2568613573))
* v2 JWTの旧端末IDを初期化前に保全 ([172324f](https://github.com/YumNumm/EQMonitor/commit/172324f285db0b8ab817733f22805baab114b82e))
* WAV通知音取り込みの末尾処理と出力確定を修正 ([620514f](https://github.com/YumNumm/EQMonitor/commit/620514f27b76ebba63ba1ef7214185921d5d5cc2))
* WebSocketの無受信を検知して再接続する ([6c60626](https://github.com/YumNumm/EQMonitor/commit/6c60626840e2b7acba510f1dc8b9d773404eac8c))
* XcodeGenの基準ディレクトリをソースと一致させる ([a1f1600](https://github.com/YumNumm/EQMonitor/commit/a1f16006cda2a45d580030ccef7c16b922b483b4))
* アプリの静的解析を通し全体解析の残件を記録 ([5fc0bd6](https://github.com/YumNumm/EQMonitor/commit/5fc0bd64f29ab8281ef7c737dc349fbe4e3df4ac))
* アプリ設定に合わせてマップ配色を切り替える ([52cd267](https://github.com/YumNumm/EQMonitor/commit/52cd267bdee1651cd8f481a2d789ddae59ab1cf9))
* コールドスタートの通知タップ遷移先喪失と計測失敗時のタップ不能を修正 ([1ab5c34](https://github.com/YumNumm/EQMonitor/commit/1ab5c3416c4710e14f3002d602a18889acb7d296))
* コントロールセンターから地震履歴を開く導線を修正 ([bbf5c76](https://github.com/YumNumm/EQMonitor/commit/bbf5c768934cab4287f52d6cb757a716c7ee710e))
* ストアの支払い保留を購入失敗ではなく保留中として表示 ([0835b2a](https://github.com/YumNumm/EQMonitor/commit/0835b2a0c22b4e3b07e908c3f3c37042a4a5b5aa))
* デバッグメニューを開けないときは加速度センサーを購読しない ([fb0941d](https://github.com/YumNumm/EQMonitor/commit/fb0941db80a5b3457084a3db0cf6c1970ac12709))
* テレメトリ DB のパス解決に失敗しても起動を継続する ([99deb5c](https://github.com/YumNumm/EQMonitor/commit/99deb5ccb68b23b8a8499876ef88c43b5504ef66))
* ネイティブ検証の全ソースを絶対パスで参照する ([8c7d1f5](https://github.com/YumNumm/EQMonitor/commit/8c7d1f5bba897e42c41b47bfd0d9ccb55183b0ad))
* ネットワーク変化時にジッタ付きでWebSocketを再接続する ([e881429](https://github.com/YumNumm/EQMonitor/commit/e8814291193153922ca82f4814968bba998af1be))
* プッシュトークン更新が破棄済みのNotifierへ渡る問題を修正 ([38cf109](https://github.com/YumNumm/EQMonitor/commit/38cf109e6ca974df1edbceaaa99e6e97739013bf))
* プレビュー用Bundleをライブアクティビティに限定 ([4212482](https://github.com/YumNumm/EQMonitor/commit/4212482c188d7453a747083a6fc76b758393a5ba))
* モニターの既定取得元と長周期画像URLを修正 ([eb5319a](https://github.com/YumNumm/EQMonitor/commit/eb5319ac2938e7e2224682ea9b1d19ebfc6d2fa6))
* もろもろ ([1dea151](https://github.com/YumNumm/EQMonitor/commit/1dea1519dbf4e03dd3ff874309a5af8bdf1ee768))
* リプレイ終了時にEEWのRESTを取り直す ([03f30ef](https://github.com/YumNumm/EQMonitor/commit/03f30ef8460fa99d3e38fc7cbfe89d4337096984))
* レイアウトバグを修正 ([d9d3b0d](https://github.com/YumNumm/EQMonitor/commit/d9d3b0d51ab70f0dc08d3cacd98ccff8bdd5fe28))
* ローカル通知のデータ変換と起動待機を追加 ([e06d5b0](https://github.com/YumNumm/EQMonitor/commit/e06d5b0437a7b91f8dbe92b6c104c6358b9ff95f))
* 一時Xcodeプロジェクトからローカル依存を解決する ([05f5b14](https://github.com/YumNumm/EQMonitor/commit/05f5b14d59978a7c5c568cba7f73444407bd620a))
* 再接続時のreadyイベントが下流へ通知されない問題を修正 ([c646105](https://github.com/YumNumm/EQMonitor/commit/c6461053fd68f714515af3eb4c897120b3f4d882))
* 再試行間隔の計算をRetryBackoffPolicyに移しトップレベル関数の lint 違反を解消 ([005ef45](https://github.com/YumNumm/EQMonitor/commit/005ef45d816a9a5cb5f6987efcd1a44b1f178111))
* 最近の地震の再読み込み中も既存一覧を維持 ([6cac7d0](https://github.com/YumNumm/EQMonitor/commit/6cac7d0920142abb01e8b36670e5c33a288d193b))
* 前面通知の受信とタップ遷移を接続 ([233e047](https://github.com/YumNumm/EQMonitor/commit/233e04762aea2a48c8fdddb66ff3cb5eaef8bab3))
* 地図設定の保存値を解釈できない場合は既定値を使う ([3587455](https://github.com/YumNumm/EQMonitor/commit/35874551140c167964b3e8effeb4c1f2de5909e1))
* 地域選択地図に都道府県の外周レイヤーを接続 ([85cb1f5](https://github.com/YumNumm/EQMonitor/commit/85cb1f5d2f1f79f3f5fac25a07127a9c48beacff))
* 地域選択地図の非表示フィルターによるクラッシュを修正 ([66b4516](https://github.com/YumNumm/EQMonitor/commit/66b4516558df7d7f78e6e2a6ce9d6115555d6198))
* 地震Entityの状態と型付きプロパティを公開する ([f2fd1d7](https://github.com/YumNumm/EQMonitor/commit/f2fd1d752a495b4299ded1b94f1ffce852511087))
* 地震Intentの地域検証と取得結果保持を共通化する ([ed2da22](https://github.com/YumNumm/EQMonitor/commit/ed2da222518dc6a00a60fe783f11686239d1d2be))
* 地震Snippetの詳細導線と保存地域の表示を修正 ([003eb24](https://github.com/YumNumm/EQMonitor/commit/003eb24633908ce916ab7e29c9fa0e81e94c0e67))
* 地震カードの再描画と明示更新を分離する ([6d184f4](https://github.com/YumNumm/EQMonitor/commit/6d184f4886557527437c5c51202b1461becab8e4))
* 地震履歴の再取得失敗と再試行を表示 ([5973e41](https://github.com/YumNumm/EQMonitor/commit/5973e41e8441453458013d099051c909deac76ab))
* 地震履歴の分割表示では詳細の戻るボタンを隠す ([a0ab6d4](https://github.com/YumNumm/EQMonitor/commit/a0ab6d4b32c082ce1f2eebb734b7fdae4756227a))
* 地震履歴の分割表示で詳細の戻るボタンを非表示にする ([3f92e94](https://github.com/YumNumm/EQMonitor/commit/3f92e9468cb351948759b320db61da1c602b78f8))
* 地震履歴一覧のグループ検索で要素がない場合に例外にしない ([8ceac80](https://github.com/YumNumm/EQMonitor/commit/8ceac80f0cfab3779cf30002117e8994e952d2e2))
* 地震履歴一覧を作り直さず先頭ページの差分反映で新着に追従 ([0823b1f](https://github.com/YumNumm/EQMonitor/commit/0823b1f40fc862579c1532d7208d8f3fb0694185))
* 地震履歴地図で観測のない区域の「観測なし」表示を復元 ([0915404](https://github.com/YumNumm/EQMonitor/commit/0915404c64d53b851cae4c5896afd441dffafd83))
* 地震履歴地図のLPGM観測点タップと震度DB読み込み中の区域タップを修正 ([de5634e](https://github.com/YumNumm/EQMonitor/commit/de5634e7eca512179de486112aaa48558b9b52d1))
* 地震履歴詳細で表示範囲の算出に失敗しても震源か既定位置で地図を表示 ([a20ee28](https://github.com/YumNumm/EQMonitor/commit/a20ee2812111064f177b5346ec889dab9c5e7031))
* 地震情報の通知優先度と上書き説明を修正 ([49c3cb3](https://github.com/YumNumm/EQMonitor/commit/49c3cb32936e098a5708806de4689d400fe20ba5))
* 地震活動ページで終了日当日の地震が欠落する問題を修正 ([f2198aa](https://github.com/YumNumm/EQMonitor/commit/f2198aa6ff90713fd18df20ac18d19ff7f24968f))
* 地震詳細のSwift API型を最新契約に揃える ([68628cb](https://github.com/YumNumm/EQMonitor/commit/68628cb926a93b027229b2d33f3e4a118d1a906c))
* 地震詳細の復元と地域震度の保持を実装する ([6123a08](https://github.com/YumNumm/EQMonitor/commit/6123a08b872f2bc955b5ca68dd9cb505308d8b9c))
* 実Widgetの色定義をネイティブテストへ含める ([45daa44](https://github.com/YumNumm/EQMonitor/commit/45daa445b14ccdc6eda49550361ce372a4740172))
* 市区町村別最大震度の選択枠を地域選択UIに合わせる ([88c8b0c](https://github.com/YumNumm/EQMonitor/commit/88c8b0c5b4d91b1a1b1d17f70b9369adba5a261d))
* 強震モニタの取得失敗時は遅延表示にし表示時刻を観測時刻に ([8d65b72](https://github.com/YumNumm/EQMonitor/commit/8d65b72b7f65164aac6afed9de6673a5fbdc1187))
* 強震モニタの遅延詳細設定を非表示にする ([7eae640](https://github.com/YumNumm/EQMonitor/commit/7eae640e643a367f1fe3ee003da27c40134f2916))
* 強震モニタを inactive では停止しないように ([3826928](https://github.com/YumNumm/EQMonitor/commit/3826928cd3a6e1d870ca5c225401a24b96e9c376))
* 強震モニタ画像解析 worker に6秒のタイムアウトと再起動を追加 ([17f9388](https://github.com/YumNumm/EQMonitor/commit/17f9388614420cff1c0755f77640f53ee41d5f50))
* 強震モニタ解析の座標範囲外と worker 終了時の応答待ちを処理 ([7d3e16a](https://github.com/YumNumm/EQMonitor/commit/7d3e16a72b5b5dc3b16390858d7d46352b8a42f6))
* 強震モニタ設定の読み込み中に requireValue で落ちないように ([2008825](https://github.com/YumNumm/EQMonitor/commit/2008825ac384395870fc913eeba7949788db0956))
* 復元元のない304応答をエラーとして扱う ([bb83e6a](https://github.com/YumNumm/EQMonitor/commit/bb83e6a2138b143f29692ccc1387e358c15be604))
* 旧版 Asset Pack の削除を次回起動時まで遅らせる ([b4f7ea8](https://github.com/YumNumm/EQMonitor/commit/b4f7ea8adc2e3f78495801f6047aec5227706de7))
* 月額商品のID不一致時に購入を停止する ([7696803](https://github.com/YumNumm/EQMonitor/commit/76968038be623e3c42bd0ae8d1a689f8f926d5ad))
* 本番ビルドのアイコンをAppIconに統一 ([db0d133](https://github.com/YumNumm/EQMonitor/commit/db0d133bacc269d7d9c772c001ed49b24fbec8bf))
* 権限付与後の現在地監視と初回同期を復旧 ([d2c3146](https://github.com/YumNumm/EQMonitor/commit/d2c314602d542b321c7678bab18132d519db84d3))
* 権限要求後に再取得した最新の権限状態を返す ([89e8ce8](https://github.com/YumNumm/EQMonitor/commit/89e8ce8dcca1b35c4494b3d2d67f975bb33988ba))
* 気象庁XMLがある地震だけ電文一覧を表示 ([b3e5c06](https://github.com/YumNumm/EQMonitor/commit/b3e5c0656cdb08b62166808bdf21ef85bc35b7a2))
* 気象庁XMLがある地震だけ電文一覧を表示 ([1acf8af](https://github.com/YumNumm/EQMonitor/commit/1acf8af80ce18c49d264fb6aa836ae781e4b8dc1))
* 津波詳細のポーリング失敗時に前回値を保持して表示 ([b5fc8c4](https://github.com/YumNumm/EQMonitor/commit/b5fc8c4af850f3a65d799568598c98a7dc0ec5f3))
* 無料プランのEEW履歴と近傍地震へのアクセスを制限 ([ddd1eda](https://github.com/YumNumm/EQMonitor/commit/ddd1eda7e9597de1ae6a806f43e66da17cf3b07a))
* 確定報の区域ポップアップで速報バッジを出さない ([1ac212e](https://github.com/YumNumm/EQMonitor/commit/1ac212ec95337da1c680d1aa0c5f50e592e6d899))
* 端末登録と旧設定移行の完了判定を分離 ([8cf9133](https://github.com/YumNumm/EQMonitor/commit/8cf91337021be0f832c7a70fdb6d0d2ca431086e))
* 細かいUI崩れの修正 ([f8b57a6](https://github.com/YumNumm/EQMonitor/commit/f8b57a683a89c16be38b8de8caf856c2fa12677f))
* 統合Live ActivityのEEW表示モデルと地震情報の扱いを修正 ([fea4458](https://github.com/YumNumm/EQMonitor/commit/fea4458fc88f4b9a36ede51ff97e434591c207e0))
* 統合Live Activityの不要なプレビュー状態を削除 ([3f6e7a9](https://github.com/YumNumm/EQMonitor/commit/3f6e7a9a7d50385278b14ac5a1e860d19e17fc61))
* 統合Live Activityの重複表示を省きロック画面を小型化 ([edc8d79](https://github.com/YumNumm/EQMonitor/commit/edc8d79fe8da6df8f10edeeadee6ee38b0e9ab46))
* 統合Live Activityの震源表示をEEWに統一 ([7949b67](https://github.com/YumNumm/EQMonitor/commit/7949b6749d6e205eb592d32c9c2f115bba9fd58b))
* 緊急地震速報履歴のAppBar配置を地震履歴と統一 ([0ed0075](https://github.com/YumNumm/EQMonitor/commit/0ed00759b9beaf2205fe06a32345d337b5159b61))
* 観測点詳細シートのはみ出しと表の文字色を修正 ([eabfcf6](https://github.com/YumNumm/EQMonitor/commit/eabfcf6263060de71de05aa9c939e62fc90aedd2))
* 訓練報・試験報のEEWを全画面警報と振動の対象外にする ([5735173](https://github.com/YumNumm/EQMonitor/commit/57351733a144aed392733aca5ad8bf776be98a84))
* 購入直後の同期が409 pendingのとき端末登録と同じ間隔で再試行 ([603c64d](https://github.com/YumNumm/EQMonitor/commit/603c64d30ac26a1ffadc2315170708eb2156d271))
* 購読APIの端末認証と資格情報変更の通知を追加 ([d8d91ea](https://github.com/YumNumm/EQMonitor/commit/d8d91eac4ff05271d2e364a019c31b1a13f3da30))
* 起動失敗時のエラー画面に既定テーマを渡す ([85ffbef](https://github.com/YumNumm/EQMonitor/commit/85ffbefefd86eb7909d9a9353228addbb9a1b008))
* 通知地域の一覧・地図・保存コードを細分区域に統一 ([3412ff1](https://github.com/YumNumm/EQMonitor/commit/3412ff18b0a8159962d70b533a2f89d947df4e52))
* 通知地域選択を地震情報の細分区域に統一 ([c3b3e34](https://github.com/YumNumm/EQMonitor/commit/c3b3e3492a20bbd826f371c83ecc2a364d44f299))
* 通知設定の保存応答を再取得前に反映 ([a9501a3](https://github.com/YumNumm/EQMonitor/commit/a9501a379266c19f52aedcfdf77355883677b1f5))
* 通知配信ログの本文を左寄せに修正 ([de65217](https://github.com/YumNumm/EQMonitor/commit/de6521760e4cc00145ec44a3b817555ec37b9825))
* 通知音エラーの診断情報を詳細表示とコピーに追加 ([c57fef8](https://github.com/YumNumm/EQMonitor/commit/c57fef8ba7b4dd4efb258bdd873e86d3e3ec6eb2))
* 通知音の削除と設定保存の競合を防止 ([3942c66](https://github.com/YumNumm/EQMonitor/commit/3942c662a1142ab633acd2ce2647b7154eff404e))
* 通知音処理の失敗箇所とOSエラーを保持 ([1327794](https://github.com/YumNumm/EQMonitor/commit/13277949706d3d6aa41257d11fdfb620ec5f6e8e))
* 都道府県選択を市区町村へ展開せず専用境界で強調 ([241e8b7](https://github.com/YumNumm/EQMonitor/commit/241e8b7578afd3867a7d32adbd25093c9c7a3b04))
* 配布ビルドをXcode 27.0正式版に固定 ([2704a5f](https://github.com/YumNumm/EQMonitor/commit/2704a5fb968ecff8385da1fe9723356ccd25d14f))
* 配布ビルドをXcode 27.0正式版に固定 ([1859019](https://github.com/YumNumm/EQMonitor/commit/1859019fd3dc7e25f4ad098736f7c6c510d661aa))
* 長周期データのない観測点詳細で長周期の解説リンクを出さない ([6ea47db](https://github.com/YumNumm/EQMonitor/commit/6ea47db42743ccb7707cfab8645449516a7176ee))
* 長周期画像の解析例外と誤った震度換算を修正 ([bb8fd5c](https://github.com/YumNumm/EQMonitor/commit/bb8fd5c8f89dfdb746469514ee7ab7966588a0ff))
* 電文一覧の緊急地震速報カードの押下表示を修正 ([afa8ae8](https://github.com/YumNumm/EQMonitor/commit/afa8ae8d7736ec5df91fc820928c3296426d0524))
* 電文一覧の緊急地震速報カードの押下表示を修正 ([d742128](https://github.com/YumNumm/EQMonitor/commit/d7421285ca9f12f2cb9905e6d7aea64baed6758f))
* 震度速報の対象地域から地図の初期表示範囲を設定する ([4cb8cac](https://github.com/YumNumm/EQMonitor/commit/4cb8cac716c9792a7bd0caf82cd567592966d068))
* 震度速報の重複バッジを抑止し巨大地震のM表記を修正 ([9532bc1](https://github.com/YumNumm/EQMonitor/commit/9532bc165ee7d11d26b8a1b395e83a18b9c3458b))
* 音声応答と地震カードで同じ取得結果を表示する ([0528882](https://github.com/YumNumm/EQMonitor/commit/0528882e2a3a7921b605c0c2c3c152fab663f49d))


### Reverts

* api-stub結合テストの削除を別ブランチへ移すため取り消し ([68b7328](https://github.com/YumNumm/EQMonitor/commit/68b7328df873b4120548723161e21a2f00a0271a))


### Miscellaneous Chores

* 次のリリースを3.0.0に固定する ([7f67b65](https://github.com/YumNumm/EQMonitor/commit/7f67b65afaf110bca689c86dfb56a2a9d2770e23))

## [3.0.0](https://github.com/YumNumm/EQMonitor/compare/v3.0.0...v3.0.0) (2026-09-30)


### Features

* analyzer plugin に Provider/Primary Constructor のルールを追加する ([70418ee](https://github.com/YumNumm/EQMonitor/commit/70418ee8c243d77e8afb8f4798646bafbe5ece43))
* Dynamic Islandに現在地優先の表示を反映する ([2baf012](https://github.com/YumNumm/EQMonitor/commit/2baf01213492f58217d904eda5561e846590b1ac))
* HTTPキャッシュにbody合計5MBのLRU削除を導入 ([59491b0](https://github.com/YumNumm/EQMonitor/commit/59491b0fb911696defc758968477d3ecd595f534))
* **ios:** 統合 Live Activity の SwiftUI 実装とデザイン確認用 Preview を追加する ([409ad43](https://github.com/YumNumm/EQMonitor/commit/409ad435a5d09c7d936517af499029ff233dcc6f))
* IS_PRODUCTION設定へ統一しbeta表示を廃止 ([681cfb9](https://github.com/YumNumm/EQMonitor/commit/681cfb9b2e9d8dfa64cc09795bd779dd774e27b7))
* Siriの検索語をアプリ内検索へ渡す ([8ed9481](https://github.com/YumNumm/EQMonitor/commit/8ed94818dc827ccc82e0ae0c1bc94c8a83af251d))
* ストアの月額価格と購入可能状態を表示 ([670f252](https://github.com/YumNumm/EQMonitor/commit/670f252a27ebffff371040657bc3d69d4ee4f900))
* デバッグ画面から揺れ検知の地域通知を設定 ([4b44961](https://github.com/YumNumm/EQMonitor/commit/4b449612a62cece8a0927db3eac28276c15de5d0))
* ロック画面を現在地震度中心の配置へ変更する ([919fa3d](https://github.com/YumNumm/EQMonitor/commit/919fa3dfb7e535fc456c9a63887501c3fdf55451))
* 共通地域選択に地図選択を実装 ([c1cf733](https://github.com/YumNumm/EQMonitor/commit/c1cf7332cdf6567568a8dc4a5ef8b3088971a3a3))
* 単一と複数を切り替える地域選択画面を追加 ([4799162](https://github.com/YumNumm/EQMonitor/commit/4799162c2d0704adcc43ccfdadb4855e35717ca8))
* 地図の簡易観測点モーダルを廃止し地域別震度を表示 ([2c5cba3](https://github.com/YumNumm/EQMonitor/commit/2c5cba3a8012bc6738a5e0d777b80d4c5d6ae41a))
* 地域コードで各地の震度を絞り込む処理を追加 ([fbc0882](https://github.com/YumNumm/EQMonitor/commit/fbc0882ab440c09c4debbcf25a4fcfa266e14ead))
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
* 既定音と震度別設定で追加音を選択 ([59631e5](https://github.com/YumNumm/EQMonitor/commit/59631e53af0ab3004f3908a9c6f32b727307f960))
* 気象庁の都道府県境界データと再生成手順を同梱 ([8f57a0d](https://github.com/YumNumm/EQMonitor/commit/8f57a0d6276589a65d20733f9a2e9ee429dcca55))
* 現在地の警報帯と到達予想の表示部品を追加する ([8539eea](https://github.com/YumNumm/EQMonitor/commit/8539eeadb63cf160d0b0ef0145db94d74562ad7e))
* 現在地震度がない場合に地震発生検知時刻を表示する ([9057958](https://github.com/YumNumm/EQMonitor/commit/9057958f8a3409e4fb30ad01b49e33712029bd4d))
* 端末IDに結び付けた課金SDK操作を直列化 ([48e3d8b](https://github.com/YumNumm/EQMonitor/commit/48e3d8b18899f2dee615a8a5c015ae954727f466))
* 統合Live ActivityのWidget実装をdevelopへ統合 ([ea57158](https://github.com/YumNumm/EQMonitor/commit/ea57158ff71291136c3624c78f8215542d9c2439))
* 緊急地震速報一覧の詳細選択と二画面表示に対応 ([e8c9cda](https://github.com/YumNumm/EQMonitor/commit/e8c9cda8ebeeac7810c39bd0ed6d5e07348778e6))
* 表示幅とヒンジ方向から履歴ペインの配置を決定 ([c5b7ee6](https://github.com/YumNumm/EQMonitor/commit/c5b7ee60de1809b583dadf4b13ba9fd4828a1ae9))
* 観測点詳細を共通化してスクロール表示に対応 ([12b8d91](https://github.com/YumNumm/EQMonitor/commit/12b8d91828b1a1dab4e96bac2c347f6379a680f6))
* 購入後の権限確認と再同期を実装 ([703c0c8](https://github.com/YumNumm/EQMonitor/commit/703c0c83732e5a869563b74a4f5a5e216d7f6b37))
* 購読の同期状態と認証復旧の操作を追加 ([c29cf81](https://github.com/YumNumm/EQMonitor/commit/c29cf810022297bc88344a00292779a37a96d8c7))
* 購読同期APIと応答型の生成を追加 ([8389d4e](https://github.com/YumNumm/EQMonitor/commit/8389d4ed6ba52fea361947f153402dd017851544))
* 購読権限の取得とサーバー同期を追加 ([0f8431a](https://github.com/YumNumm/EQMonitor/commit/0f8431a1abd1579eebe4ce845204f05e06b75c3b))
* 購読状態に同期結果を追加 ([da38e92](https://github.com/YumNumm/EQMonitor/commit/da38e92dad99644df3398bfdf5a54a3f38f9f167))
* 追加通知音のモデルを定義 ([3c82a0f](https://github.com/YumNumm/EQMonitor/commit/3c82a0fef365222ab8343b8e33fc88ad66c73e76))
* 追加通知音の管理画面を追加 ([a684027](https://github.com/YumNumm/EQMonitor/commit/a684027fc618bde12d2fb217cb2435758ebf92d4))
* 追加音の一覧と操作 Mutation を公開 ([2ac115e](https://github.com/YumNumm/EQMonitor/commit/2ac115eae88efee6117b1b52e92845226a86f1de))
* 通知設定を確認済みのプラン制限に追従 ([24e14bf](https://github.com/YumNumm/EQMonitor/commit/24e14bf27053604c5784ef4a9a21d7bc50528d6a))
* 通知音の native 操作と試聴を接続 ([3b6b96e](https://github.com/YumNumm/EQMonitor/commit/3b6b96e8b76640461998b65249f80213fc2d6264))
* 通知音のカタログと音声を永続化 ([9f3c9b6](https://github.com/YumNumm/EQMonitor/commit/9f3c9b65feabc0c16405ce304c9fa6da4d5a946f))
* 通知音の追加と保存操作を実装 ([5b5085d](https://github.com/YumNumm/EQMonitor/commit/5b5085d82452ca26bacd082a8e4d8e64c2df931c))
* 通知音の選択と取り込みを Repository に追加 ([2122af0](https://github.com/YumNumm/EQMonitor/commit/2122af0b0507da412ec13f99999cd12d128a53b6))
* 選択状態を保持する履歴一覧と詳細の適応表示を追加 ([69627ae](https://github.com/YumNumm/EQMonitor/commit/69627aeac8d48c5d0e348be01fe978f7ce918803))
* 都道府県境界を非同期で読み込む ([416129f](https://github.com/YumNumm/EQMonitor/commit/416129f072b19f0f722154704584dea1a810cf95))
* 音声の検証と通知用変換を追加 ([88c4bb3](https://github.com/YumNumm/EQMonitor/commit/88c4bb34cb19933b8d0f1a547353954f0d5739b0))


### Bug Fixes

* analyzer error ([f3c86ae](https://github.com/YumNumm/EQMonitor/commit/f3c86ae432c684b8f834959658ccffe518a0a5e7))
* analyzer error ([86bf894](https://github.com/YumNumm/EQMonitor/commit/86bf894f1a3579cff0bced4c649faa04840b03fc))
* Android前面通知の表示をリポジトリへ集約 ([d934006](https://github.com/YumNumm/EQMonitor/commit/d934006971691e4fb3ccb5e392b2274d45ec7c46))
* Android配布で未使用のCodemagic依存を除去 ([fe29945](https://github.com/YumNumm/EQMonitor/commit/fe299456fb9cd0cb9143acc557a2c510e6192b9f))
* App Intentの連続遷移と詳細表示の共通処理を修正 ([919718e](https://github.com/YumNumm/EQMonitor/commit/919718ef372d373b194e6344969a3c819f06fd10))
* Asset Pack インストール失敗カードの題名を内容に合わせる ([14cb2e7](https://github.com/YumNumm/EQMonitor/commit/14cb2e776880af6eb536ca3947ba88eeebb5057d))
* Asset Pack の解析失敗時も同梱版へフォールバック ([2111f8b](https://github.com/YumNumm/EQMonitor/commit/2111f8bd65eebee4754dd5d8a47b653a928c22b2))
* Asset Pack を Android の Auto Backup 対象から除外 ([b734947](https://github.com/YumNumm/EQMonitor/commit/b734947bdeeb52f4eadc4b8cf3a6be00c3096a2b))
* CDのmiseダウンロードを有限回再試行 ([f7d1dad](https://github.com/YumNumm/EQMonitor/commit/f7d1dadafac3f6d2a46e664c16db8268bd56787d))
* CD初期ジョブのcheckout時間に余裕を確保 ([a9c9308](https://github.com/YumNumm/EQMonitor/commit/a9c93080843cfc901f2c21acf545a37a210ffb1f))
* **ci:** zizmorの[`self-repository`](https://docs.zizmor.sh/audits/#remediation_26)ルールによる指摘事項に対応 ([6aad416](https://github.com/YumNumm/EQMonitor/commit/6aad4160df3c416f56cdfd01c685c20305f6fb78))
* Control Centerから地震履歴を開く処理を修正 ([192812d](https://github.com/YumNumm/EQMonitor/commit/192812dfa3850490d6ab9d8501b5788163148a78))
* Deploy Appの準備段階の失敗を解消 ([ef75f62](https://github.com/YumNumm/EQMonitor/commit/ef75f6287d48af11e2c728ccd9c18cc83847ac8b))
* design ([e8bbb99](https://github.com/YumNumm/EQMonitor/commit/e8bbb99d6f661466276fbe8285debfdc0bdc81af))
* device-id読み取り失敗でAPIリクエストを失敗させない ([7fec3fd](https://github.com/YumNumm/EQMonitor/commit/7fec3fd809334f17043a9cf14eca6ec98caec705))
* Dynamic IslandのEEW表示を共通化し展開表示の情報を整理 ([ce3cc6d](https://github.com/YumNumm/EQMonitor/commit/ce3cc6d84bd172ab2cd3312f2d46a489a62a3651))
* EEW再取得中の表示消失を防ぐ ([112971c](https://github.com/YumNumm/EQMonitor/commit/112971c6d7e2fa5f51a771ecfc9489fffd0789b2))
* EEW再取得中も受信済みデータの表示を維持する ([7045043](https://github.com/YumNumm/EQMonitor/commit/704504386e22672df6c5a9f29a843e3a3b2f6fcd))
* EEW取消報でカードが消え取消表示が出ない問題を修正 ([0260e00](https://github.com/YumNumm/EQMonitor/commit/0260e000db9e359b4a4bb1aecdafbc95798dad10))
* EEW履歴とイベント別EEWで報の上書き・欠落が起きる問題を修正 ([727f18c](https://github.com/YumNumm/EQMonitor/commit/727f18c43cf29a77e36d70eea79462acda8c4580))
* EEW履歴の発表中セクションに終了済みのEEWが残る問題を修正 ([3c9058a](https://github.com/YumNumm/EQMonitor/commit/3c9058a1b4f395b8bd66f2cb4fe86df25e34bcab))
* Expandedの上段高と外周に沿う角丸を調整する ([adfc62b](https://github.com/YumNumm/EQMonitor/commit/adfc62b17e22e813e79f44d6ce3f7fb57ab21003))
* Expandedの高さ不足と警報名の省略を解消する ([3c07045](https://github.com/YumNumm/EQMonitor/commit/3c070457097a62b31af3c0c1d43907ce3d85f6e2))
* Expanded上部を拡大し警報名の行高を確保する ([0ca1ff1](https://github.com/YumNumm/EQMonitor/commit/0ca1ff1638b8189c9b2a30bbd94f0c8102cb7920))
* Firebase AnalyticsのObjective-Cリンク設定を補完 ([76c27d5](https://github.com/YumNumm/EQMonitor/commit/76c27d5d1a9a0086aa995532ae5a77f9a25a36da))
* Firebase通知権限の永久拒否状態を表示する ([3235f51](https://github.com/YumNumm/EQMonitor/commit/3235f51b25e0fe6c651d394c87d3d212ab2f2e1c))
* Flutter CIのツール解決と同梱アセット準備を限定 ([d338ad1](https://github.com/YumNumm/EQMonitor/commit/d338ad1bd93c814fa18af6eda8042b866945501d))
* Flutter CIの不要なツール導入を防止する ([9ceb6db](https://github.com/YumNumm/EQMonitor/commit/9ceb6dbf0490f92063bbc0517176d8b1e00beaf9))
* Flutterジョブの自リポジトリ展開エラーを回避 ([4dba613](https://github.com/YumNumm/EQMonitor/commit/4dba6139a2a07edcb2fd94c4a7049301b1ef87d1))
* foreground復帰時もPro確認値を保持し通信エラーでは期限まで維持 ([1188210](https://github.com/YumNumm/EQMonitor/commit/11882108d851b8d3a839a4adad8225d96bcfc520))
* Google Playの編集処理を実行間で直列化 ([3079647](https://github.com/YumNumm/EQMonitor/commit/30796472393772cd550abdbfaa01ca34c23fce77))
* headless で保存済み Telegram URL を本体と同じ保存先から読む ([29fc904](https://github.com/YumNumm/EQMonitor/commit/29fc90435b77a4b93fd58b50b0ed074076a73127))
* headless 位置処理で有効なダウンロード版 Asset Pack を読む ([f7e1e65](https://github.com/YumNumm/EQMonitor/commit/f7e1e657bc635bd1e0d73c59107c2baf8b837148))
* Intentの通信エラーを日本語案内へ正規化する ([9a1c2c5](https://github.com/YumNumm/EQMonitor/commit/9a1c2c58990b62faa5e771bcd929b2f7a0a08c4c))
* iOS 26.1未満のLive Activity対応判定を修正 ([c119f85](https://github.com/YumNumm/EQMonitor/commit/c119f85b830de3fe55dce6ba23e7383d036556a4))
* iOSの未使用トラッキング許可説明を削除 ([783f919](https://github.com/YumNumm/EQMonitor/commit/783f91914fb2acedc8a5305424b77b5434c7ded1))
* iOSの署名済みIPA書き出し時間を確保 ([73f9cea](https://github.com/YumNumm/EQMonitor/commit/73f9cea5a189c089e9196632d968b5ecf3cd9eb0))
* iOS拡張へproductionフラグと機能制限を反映 ([9a557b9](https://github.com/YumNumm/EQMonitor/commit/9a557b9b3220d39798806d34bcc7283c273dd2da))
* iOS配布CIをXcode 27対応runnerへ切り替え ([95bbe51](https://github.com/YumNumm/EQMonitor/commit/95bbe5117d905a271cefc3f1ffece4738fbd912d))
* iOS配布用のAnalytics依存をクラッシュ修正版に更新 ([509316e](https://github.com/YumNumm/EQMonitor/commit/509316ebd67df500340e75b5d157626d6547cbfa))
* layout error ([828e7b3](https://github.com/YumNumm/EQMonitor/commit/828e7b3ea1b2bf99f1e6150e0b5bc13b2f724cd7))
* Live ActivityのMAXと震度を中央揃え ([7f36177](https://github.com/YumNumm/EQMonitor/commit/7f36177ec4150b5fbb45ef46d82f2fae20a54a02))
* Live ActivityのM数値の字間を以前の値に戻す ([41e6e0f](https://github.com/YumNumm/EQMonitor/commit/41e6e0f2327c67a000c5edc626b6607c8cc3c62f))
* Live Activityの震源要素と余白を統一し表示の見切れを修正 ([11b2614](https://github.com/YumNumm/EQMonitor/commit/11b26142c40999d04e0553fd330639c9d38eaea7))
* Paywallの特典をPro限定の実機能に揃え支払い保留文言を調整 ([6e8e736](https://github.com/YumNumm/EQMonitor/commit/6e8e7365cdbbc75dce9a7d29ce26068cacda6678))
* PrivacyInfo に App Group UserDefaults の理由コード 1C8F.1 を追加 ([4a48d56](https://github.com/YumNumm/EQMonitor/commit/4a48d56509499d62603a7b6f631dbb7ad237710e))
* productionで揺れ検知処理と既存通知を無効化 ([3349db2](https://github.com/YumNumm/EQMonitor/commit/3349db221217bf2530d354e5eeda75b14762707d))
* productionのTelemetry保存と送信を停止 ([115df66](https://github.com/YumNumm/EQMonitor/commit/115df66742e3027a6d3af26d5638a5e604f60f48))
* Pro加入状態と共通の利用制限表示を整備 ([294c9d0](https://github.com/YumNumm/EQMonitor/commit/294c9d020834623ce778c0c20a419fc0f954dd4b))
* resume時に端末が未登録ならprovisionをやり直す ([79a6bd8](https://github.com/YumNumm/EQMonitor/commit/79a6bd89044189677f61abba2b4b78311ae9970f))
* Siriのアプリ名を揃えてIntentテストを登録する ([4a1fda8](https://github.com/YumNumm/EQMonitor/commit/4a1fda80b6026b2e8a93d120d8117a2568613573))
* Swift APIに歴史震度分類を追加する ([b4a94f6](https://github.com/YumNumm/EQMonitor/commit/b4a94f6143c1afe23bfba744a920eb3ffdffb6c3))
* WebSocketの無受信を検知して再接続する ([6c60626](https://github.com/YumNumm/EQMonitor/commit/6c60626840e2b7acba510f1dc8b9d773404eac8c))
* XcodeGenの基準ディレクトリをソースと一致させる ([a1f1600](https://github.com/YumNumm/EQMonitor/commit/a1f16006cda2a45d580030ccef7c16b922b483b4))
* アプリの静的解析を通し全体解析の残件を記録 ([5fc0bd6](https://github.com/YumNumm/EQMonitor/commit/5fc0bd64f29ab8281ef7c737dc349fbe4e3df4ac))
* アプリ設定に合わせてマップ配色を切り替える ([52cd267](https://github.com/YumNumm/EQMonitor/commit/52cd267bdee1651cd8f481a2d789ddae59ab1cf9))
* コールドスタートの通知タップ遷移先喪失と計測失敗時のタップ不能を修正 ([1ab5c34](https://github.com/YumNumm/EQMonitor/commit/1ab5c3416c4710e14f3002d602a18889acb7d296))
* コントロールセンターから地震履歴を開く導線を修正 ([bbf5c76](https://github.com/YumNumm/EQMonitor/commit/bbf5c768934cab4287f52d6cb757a716c7ee710e))
* ストアの支払い保留を購入失敗ではなく保留中として表示 ([0835b2a](https://github.com/YumNumm/EQMonitor/commit/0835b2a0c22b4e3b07e908c3f3c37042a4a5b5aa))
* デバッグメニューを開けないときは加速度センサーを購読しない ([fb0941d](https://github.com/YumNumm/EQMonitor/commit/fb0941db80a5b3457084a3db0cf6c1970ac12709))
* テレメトリ DB のパス解決に失敗しても起動を継続する ([99deb5c](https://github.com/YumNumm/EQMonitor/commit/99deb5ccb68b23b8a8499876ef88c43b5504ef66))
* ネイティブ検証の全ソースを絶対パスで参照する ([8c7d1f5](https://github.com/YumNumm/EQMonitor/commit/8c7d1f5bba897e42c41b47bfd0d9ccb55183b0ad))
* ネットワーク変化時にジッタ付きでWebSocketを再接続する ([e881429](https://github.com/YumNumm/EQMonitor/commit/e8814291193153922ca82f4814968bba998af1be))
* プッシュトークン更新が破棄済みのNotifierへ渡る問題を修正 ([38cf109](https://github.com/YumNumm/EQMonitor/commit/38cf109e6ca974df1edbceaaa99e6e97739013bf))
* プレビュー用Bundleをライブアクティビティに限定 ([4212482](https://github.com/YumNumm/EQMonitor/commit/4212482c188d7453a747083a6fc76b758393a5ba))
* モニターの既定取得元と長周期画像URLを修正 ([eb5319a](https://github.com/YumNumm/EQMonitor/commit/eb5319ac2938e7e2224682ea9b1d19ebfc6d2fa6))
* もろもろ ([1dea151](https://github.com/YumNumm/EQMonitor/commit/1dea1519dbf4e03dd3ff874309a5af8bdf1ee768))
* リプレイ終了時にEEWのRESTを取り直す ([03f30ef](https://github.com/YumNumm/EQMonitor/commit/03f30ef8460fa99d3e38fc7cbfe89d4337096984))
* レイアウトバグを修正 ([d9d3b0d](https://github.com/YumNumm/EQMonitor/commit/d9d3b0d51ab70f0dc08d3cacd98ccff8bdd5fe28))
* ローカル通知のデータ変換と起動待機を追加 ([e06d5b0](https://github.com/YumNumm/EQMonitor/commit/e06d5b0437a7b91f8dbe92b6c104c6358b9ff95f))
* 一時Xcodeプロジェクトからローカル依存を解決する ([05f5b14](https://github.com/YumNumm/EQMonitor/commit/05f5b14d59978a7c5c568cba7f73444407bd620a))
* 再接続時のreadyイベントが下流へ通知されない問題を修正 ([c646105](https://github.com/YumNumm/EQMonitor/commit/c6461053fd68f714515af3eb4c897120b3f4d882))
* 再試行間隔の計算をRetryBackoffPolicyに移しトップレベル関数の lint 違反を解消 ([005ef45](https://github.com/YumNumm/EQMonitor/commit/005ef45d816a9a5cb5f6987efcd1a44b1f178111))
* 最近の地震の再読み込み中も既存一覧を維持 ([6cac7d0](https://github.com/YumNumm/EQMonitor/commit/6cac7d0920142abb01e8b36670e5c33a288d193b))
* 前面通知の受信とタップ遷移を接続 ([233e047](https://github.com/YumNumm/EQMonitor/commit/233e04762aea2a48c8fdddb66ff3cb5eaef8bab3))
* 取消メッセージに先ほどの地震であることを明記する ([651f1b2](https://github.com/YumNumm/EQMonitor/commit/651f1b271f4e947441b66fa570bc4e0888e67a70))
* 取消時の種別と不要な説明文を整理する ([c88ba77](https://github.com/YumNumm/EQMonitor/commit/c88ba77788c51a9b8498bf6c11592c112577e282))
* 地図設定の保存値を解釈できない場合は既定値を使う ([3587455](https://github.com/YumNumm/EQMonitor/commit/35874551140c167964b3e8effeb4c1f2de5909e1))
* 地域選択地図に都道府県の外周レイヤーを接続 ([85cb1f5](https://github.com/YumNumm/EQMonitor/commit/85cb1f5d2f1f79f3f5fac25a07127a9c48beacff))
* 地域選択地図の非表示フィルターによるクラッシュを修正 ([66b4516](https://github.com/YumNumm/EQMonitor/commit/66b4516558df7d7f78e6e2a6ce9d6115555d6198))
* 地震Entityの状態と型付きプロパティを公開する ([f2fd1d7](https://github.com/YumNumm/EQMonitor/commit/f2fd1d752a495b4299ded1b94f1ffce852511087))
* 地震Intentの地域検証と取得結果保持を共通化する ([ed2da22](https://github.com/YumNumm/EQMonitor/commit/ed2da222518dc6a00a60fe783f11686239d1d2be))
* 地震Snippetの詳細導線と保存地域の表示を修正 ([003eb24](https://github.com/YumNumm/EQMonitor/commit/003eb24633908ce916ab7e29c9fa0e81e94c0e67))
* 地震カードの再描画と明示更新を分離する ([6d184f4](https://github.com/YumNumm/EQMonitor/commit/6d184f4886557527437c5c51202b1461becab8e4))
* 地震履歴の再取得失敗と再試行を表示 ([5973e41](https://github.com/YumNumm/EQMonitor/commit/5973e41e8441453458013d099051c909deac76ab))
* 地震履歴の分割表示では詳細の戻るボタンを隠す ([a0ab6d4](https://github.com/YumNumm/EQMonitor/commit/a0ab6d4b32c082ce1f2eebb734b7fdae4756227a))
* 地震履歴の分割表示で詳細の戻るボタンを非表示にする ([3f92e94](https://github.com/YumNumm/EQMonitor/commit/3f92e9468cb351948759b320db61da1c602b78f8))
* 地震履歴一覧のグループ検索で要素がない場合に例外にしない ([8ceac80](https://github.com/YumNumm/EQMonitor/commit/8ceac80f0cfab3779cf30002117e8994e952d2e2))
* 地震履歴一覧を作り直さず先頭ページの差分反映で新着に追従 ([0823b1f](https://github.com/YumNumm/EQMonitor/commit/0823b1f40fc862579c1532d7208d8f3fb0694185))
* 地震履歴地図で観測のない区域の「観測なし」表示を復元 ([0915404](https://github.com/YumNumm/EQMonitor/commit/0915404c64d53b851cae4c5896afd441dffafd83))
* 地震履歴地図のLPGM観測点タップと震度DB読み込み中の区域タップを修正 ([de5634e](https://github.com/YumNumm/EQMonitor/commit/de5634e7eca512179de486112aaa48558b9b52d1))
* 地震履歴詳細で表示範囲の算出に失敗しても震源か既定位置で地図を表示 ([a20ee28](https://github.com/YumNumm/EQMonitor/commit/a20ee2812111064f177b5346ec889dab9c5e7031))
* 地震情報の通知優先度と上書き説明を修正 ([49c3cb3](https://github.com/YumNumm/EQMonitor/commit/49c3cb32936e098a5708806de4689d400fe20ba5))
* 地震活動ページで終了日当日の地震が欠落する問題を修正 ([f2198aa](https://github.com/YumNumm/EQMonitor/commit/f2198aa6ff90713fd18df20ac18d19ff7f24968f))
* 地震詳細のSwift API型を最新契約に揃える ([68628cb](https://github.com/YumNumm/EQMonitor/commit/68628cb926a93b027229b2d33f3e4a118d1a906c))
* 地震詳細の復元と地域震度の保持を実装する ([6123a08](https://github.com/YumNumm/EQMonitor/commit/6123a08b872f2bc955b5ca68dd9cb505308d8b9c))
* 実Widgetの色定義をネイティブテストへ含める ([45daa44](https://github.com/YumNumm/EQMonitor/commit/45daa445b14ccdc6eda49550361ce372a4740172))
* 市区町村別最大震度の選択枠を地域選択UIに合わせる ([88c8b0c](https://github.com/YumNumm/EQMonitor/commit/88c8b0c5b4d91b1a1b1d17f70b9369adba5a261d))
* 強震モニタの取得失敗時は遅延表示にし表示時刻を観測時刻に ([8d65b72](https://github.com/YumNumm/EQMonitor/commit/8d65b72b7f65164aac6afed9de6673a5fbdc1187))
* 強震モニタの遅延詳細設定を非表示にする ([7eae640](https://github.com/YumNumm/EQMonitor/commit/7eae640e643a367f1fe3ee003da27c40134f2916))
* 強震モニタを inactive では停止しないように ([3826928](https://github.com/YumNumm/EQMonitor/commit/3826928cd3a6e1d870ca5c225401a24b96e9c376))
* 強震モニタ画像解析 worker に6秒のタイムアウトと再起動を追加 ([17f9388](https://github.com/YumNumm/EQMonitor/commit/17f9388614420cff1c0755f77640f53ee41d5f50))
* 強震モニタ解析の座標範囲外と worker 終了時の応答待ちを処理 ([7d3e16a](https://github.com/YumNumm/EQMonitor/commit/7d3e16a72b5b5dc3b16390858d7d46352b8a42f6))
* 強震モニタ設定の読み込み中に requireValue で落ちないように ([2008825](https://github.com/YumNumm/EQMonitor/commit/2008825ac384395870fc913eeba7949788db0956))
* 復元元のない304応答をエラーとして扱う ([bb83e6a](https://github.com/YumNumm/EQMonitor/commit/bb83e6a2138b143f29692ccc1387e358c15be604))
* 旧版 Asset Pack の削除を次回起動時まで遅らせる ([b4f7ea8](https://github.com/YumNumm/EQMonitor/commit/b4f7ea8adc2e3f78495801f6047aec5227706de7))
* 月額商品のID不一致時に購入を停止する ([7696803](https://github.com/YumNumm/EQMonitor/commit/76968038be623e3c42bd0ae8d1a689f8f926d5ad))
* 本番ビルドのアイコンをAppIconに統一 ([db0d133](https://github.com/YumNumm/EQMonitor/commit/db0d133bacc269d7d9c772c001ed49b24fbec8bf))
* 権限付与後の現在地監視と初回同期を復旧 ([d2c3146](https://github.com/YumNumm/EQMonitor/commit/d2c314602d542b321c7678bab18132d519db84d3))
* 権限要求後に再取得した最新の権限状態を返す ([89e8ce8](https://github.com/YumNumm/EQMonitor/commit/89e8ce8dcca1b35c4494b3d2d67f975bb33988ba))
* 気象庁XMLがある地震だけ電文一覧を表示 ([b3e5c06](https://github.com/YumNumm/EQMonitor/commit/b3e5c0656cdb08b62166808bdf21ef85bc35b7a2))
* 気象庁XMLがある地震だけ電文一覧を表示 ([1acf8af](https://github.com/YumNumm/EQMonitor/commit/1acf8af80ce18c49d264fb6aa836ae781e4b8dc1))
* 津波詳細のポーリング失敗時に前回値を保持して表示 ([b5fc8c4](https://github.com/YumNumm/EQMonitor/commit/b5fc8c4af850f3a65d799568598c98a7dc0ec5f3))
* 無料プランのEEW履歴と近傍地震へのアクセスを制限 ([ddd1eda](https://github.com/YumNumm/EQMonitor/commit/ddd1eda7e9597de1ae6a806f43e66da17cf3b07a))
* 現在地の弱い揺れを薄い蒼の注意帯で表示する ([591d53d](https://github.com/YumNumm/EQMonitor/commit/591d53d647d50ffad917b3b30ea29753e97225ee))
* 確定報の区域ポップアップで速報バッジを出さない ([1ac212e](https://github.com/YumNumm/EQMonitor/commit/1ac212ec95337da1c680d1aa0c5f50e592e6d899))
* 細かいUI崩れの修正 ([f8b57a6](https://github.com/YumNumm/EQMonitor/commit/f8b57a683a89c16be38b8de8caf856c2fa12677f))
* 統合Live ActivityのEEW表示モデルと地震情報の扱いを修正 ([fea4458](https://github.com/YumNumm/EQMonitor/commit/fea4458fc88f4b9a36ede51ff97e434591c207e0))
* 統合Live Activityの不要なプレビュー状態を削除 ([3f6e7a9](https://github.com/YumNumm/EQMonitor/commit/3f6e7a9a7d50385278b14ac5a1e860d19e17fc61))
* 統合Live Activityの重複表示を省きロック画面を小型化 ([edc8d79](https://github.com/YumNumm/EQMonitor/commit/edc8d79fe8da6df8f10edeeadee6ee38b0e9ab46))
* 統合Live Activityの震源表示をEEWに統一 ([7949b67](https://github.com/YumNumm/EQMonitor/commit/7949b6749d6e205eb592d32c9c2f115bba9fd58b))
* 緊急地震速報履歴のAppBar配置を地震履歴と統一 ([0ed0075](https://github.com/YumNumm/EQMonitor/commit/0ed00759b9beaf2205fe06a32345d337b5159b61))
* 観測点詳細シートのはみ出しと表の文字色を修正 ([eabfcf6](https://github.com/YumNumm/EQMonitor/commit/eabfcf6263060de71de05aa9c939e62fc90aedd2))
* 訓練報・試験報のEEWを全画面警報と振動の対象外にする ([5735173](https://github.com/YumNumm/EQMonitor/commit/57351733a144aed392733aca5ad8bf776be98a84))
* 購入直後の同期が409 pendingのとき端末登録と同じ間隔で再試行 ([603c64d](https://github.com/YumNumm/EQMonitor/commit/603c64d30ac26a1ffadc2315170708eb2156d271))
* 購読APIの端末認証と資格情報変更の通知を追加 ([d8d91ea](https://github.com/YumNumm/EQMonitor/commit/d8d91eac4ff05271d2e364a019c31b1a13f3da30))
* 起動失敗時のエラー画面に既定テーマを渡す ([85ffbef](https://github.com/YumNumm/EQMonitor/commit/85ffbefefd86eb7909d9a9353228addbb9a1b008))
* 通知設定の保存応答を再取得前に反映 ([a9501a3](https://github.com/YumNumm/EQMonitor/commit/a9501a379266c19f52aedcfdf77355883677b1f5))
* 通知配信ログの本文を左寄せに修正 ([de65217](https://github.com/YumNumm/EQMonitor/commit/de6521760e4cc00145ec44a3b817555ec37b9825))
* 通知音の削除と設定保存の競合を防止 ([3942c66](https://github.com/YumNumm/EQMonitor/commit/3942c662a1142ab633acd2ce2647b7154eff404e))
* 都道府県選択を市区町村へ展開せず専用境界で強調 ([241e8b7](https://github.com/YumNumm/EQMonitor/commit/241e8b7578afd3867a7d32adbd25093c9c7a3b04))
* 配布ビルドをXcode 27.0正式版に固定 ([2704a5f](https://github.com/YumNumm/EQMonitor/commit/2704a5fb968ecff8385da1fe9723356ccd25d14f))
* 配布ビルドをXcode 27.0正式版に固定 ([1859019](https://github.com/YumNumm/EQMonitor/commit/1859019fd3dc7e25f4ad098736f7c6c510d661aa))
* 長周期データのない観測点詳細で長周期の解説リンクを出さない ([6ea47db](https://github.com/YumNumm/EQMonitor/commit/6ea47db42743ccb7707cfab8645449516a7176ee))
* 長周期画像の解析例外と誤った震度換算を修正 ([bb8fd5c](https://github.com/YumNumm/EQMonitor/commit/bb8fd5c8f89dfdb746469514ee7ab7966588a0ff))
* 電文一覧の緊急地震速報カードの押下表示を修正 ([afa8ae8](https://github.com/YumNumm/EQMonitor/commit/afa8ae8d7736ec5df91fc820928c3296426d0524))
* 電文一覧の緊急地震速報カードの押下表示を修正 ([d742128](https://github.com/YumNumm/EQMonitor/commit/d7421285ca9f12f2cb9905e6d7aea64baed6758f))
* 震度速報の対象地域から地図の初期表示範囲を設定する ([4cb8cac](https://github.com/YumNumm/EQMonitor/commit/4cb8cac716c9792a7bd0caf82cd567592966d068))
* 震度速報の重複バッジを抑止し巨大地震のM表記を修正 ([9532bc1](https://github.com/YumNumm/EQMonitor/commit/9532bc165ee7d11d26b8a1b395e83a18b9c3458b))
* 音声応答と地震カードで同じ取得結果を表示する ([0528882](https://github.com/YumNumm/EQMonitor/commit/0528882e2a3a7921b605c0c2c3c152fab663f49d))


### Reverts

* api-stub結合テストの削除を別ブランチへ移すため取り消し ([68b7328](https://github.com/YumNumm/EQMonitor/commit/68b7328df873b4120548723161e21a2f00a0271a))


### Miscellaneous Chores

* 次のリリースを3.0.0に固定する ([7f67b65](https://github.com/YumNumm/EQMonitor/commit/7f67b65afaf110bca689c86dfb56a2a9d2770e23))

## [3.0.0](https://github.com/YumNumm/EQMonitor/compare/v2.6.0...v3.0.0) (2026-09-30)


### Features

* analyzer plugin に Provider/Primary Constructor のルールを追加する ([70418ee](https://github.com/YumNumm/EQMonitor/commit/70418ee8c243d77e8afb8f4798646bafbe5ece43))
* Dynamic Islandに現在地優先の表示を反映する ([2baf012](https://github.com/YumNumm/EQMonitor/commit/2baf01213492f58217d904eda5561e846590b1ac))
* HTTPキャッシュにbody合計5MBのLRU削除を導入 ([59491b0](https://github.com/YumNumm/EQMonitor/commit/59491b0fb911696defc758968477d3ecd595f534))
* **ios:** 統合 Live Activity の SwiftUI 実装とデザイン確認用 Preview を追加する ([409ad43](https://github.com/YumNumm/EQMonitor/commit/409ad435a5d09c7d936517af499029ff233dcc6f))
* IS_PRODUCTION設定へ統一しbeta表示を廃止 ([681cfb9](https://github.com/YumNumm/EQMonitor/commit/681cfb9b2e9d8dfa64cc09795bd779dd774e27b7))
* PMTiles展開とleaf保持量を制限 ([1805db6](https://github.com/YumNumm/EQMonitor/commit/1805db6322c302601b37d5ca0dccb23bc0fd453a))
* Siriの検索語をアプリ内検索へ渡す ([8ed9481](https://github.com/YumNumm/EQMonitor/commit/8ed94818dc827ccc82e0ae0c1bc94c8a83af251d))
* ストアの月額価格と購入可能状態を表示 ([670f252](https://github.com/YumNumm/EQMonitor/commit/670f252a27ebffff371040657bc3d69d4ee4f900))
* デバッグ画面から揺れ検知の地域通知を設定 ([4b44961](https://github.com/YumNumm/EQMonitor/commit/4b449612a62cece8a0927db3eac28276c15de5d0))
* ロック画面を現在地震度中心の配置へ変更する ([919fa3d](https://github.com/YumNumm/EQMonitor/commit/919fa3dfb7e535fc456c9a63887501c3fdf55451))
* 共通地域選択に地図選択を実装 ([c1cf733](https://github.com/YumNumm/EQMonitor/commit/c1cf7332cdf6567568a8dc4a5ef8b3088971a3a3))
* 単一と複数を切り替える地域選択画面を追加 ([4799162](https://github.com/YumNumm/EQMonitor/commit/4799162c2d0704adcc43ccfdadb4855e35717ca8))
* 地図の簡易観測点モーダルを廃止し地域別震度を表示 ([2c5cba3](https://github.com/YumNumm/EQMonitor/commit/2c5cba3a8012bc6738a5e0d777b80d4c5d6ae41a))
* 地域コードで各地の震度を絞り込む処理を追加 ([fbc0882](https://github.com/YumNumm/EQMonitor/commit/fbc0882ab440c09c4debbcf25a4fcfa266e14ead))
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
* 推計震度MVTをclass別meshへ変換 ([d2814c4](https://github.com/YumNumm/EQMonitor/commit/d2814c4898bd37831a99ff8c43eaeec0bac2a165))
* 推計震度PMTiles headerを検証 ([cbe6b5b](https://github.com/YumNumm/EQMonitor/commit/cbe6b5be1b4313136de2c2fdf2758980b958f3a3))
* 気象庁の都道府県境界データと再生成手順を同梱 ([8f57a0d](https://github.com/YumNumm/EQMonitor/commit/8f57a0d6276589a65d20733f9a2e9ee429dcca55))
* 現在地の警報対象と震度の表示条件を統一する ([85130b3](https://github.com/YumNumm/EQMonitor/commit/85130b3b77294bdcd10e47d7ff18148245501367))
* 現在地の警報帯と到達予想の表示部品を追加する ([8539eea](https://github.com/YumNumm/EQMonitor/commit/8539eeadb63cf160d0b0ef0145db94d74562ad7e))
* 現在地震度がない場合に地震発生検知時刻を表示する ([9057958](https://github.com/YumNumm/EQMonitor/commit/9057958f8a3409e4fb30ad01b49e33712029bd4d))
* 現在地震度と最大震度の表示部品を分離する ([2065e73](https://github.com/YumNumm/EQMonitor/commit/2065e73a801b51080933cd160d32910ee9ad715e))
* 端末IDに結び付けた課金SDK操作を直列化 ([48e3d8b](https://github.com/YumNumm/EQMonitor/commit/48e3d8b18899f2dee615a8a5c015ae954727f466))
* 統合Live ActivityのWidget実装をdevelopへ統合 ([ea57158](https://github.com/YumNumm/EQMonitor/commit/ea57158ff71291136c3624c78f8215542d9c2439))
* 緊急地震速報一覧の詳細選択と二画面表示に対応 ([e8c9cda](https://github.com/YumNumm/EQMonitor/commit/e8c9cda8ebeeac7810c39bd0ed6d5e07348778e6))
* 表示幅とヒンジ方向から履歴ペインの配置を決定 ([c5b7ee6](https://github.com/YumNumm/EQMonitor/commit/c5b7ee60de1809b583dadf4b13ba9fd4828a1ae9))
* 観測点詳細を共通化してスクロール表示に対応 ([12b8d91](https://github.com/YumNumm/EQMonitor/commit/12b8d91828b1a1dab4e96bac2c347f6379a680f6))
* 購入後の権限確認と再同期を実装 ([703c0c8](https://github.com/YumNumm/EQMonitor/commit/703c0c83732e5a869563b74a4f5a5e216d7f6b37))
* 購読の同期状態と認証復旧の操作を追加 ([c29cf81](https://github.com/YumNumm/EQMonitor/commit/c29cf810022297bc88344a00292779a37a96d8c7))
* 購読同期APIと応答型の生成を追加 ([8389d4e](https://github.com/YumNumm/EQMonitor/commit/8389d4ed6ba52fea361947f153402dd017851544))
* 購読権限の取得とサーバー同期を追加 ([0f8431a](https://github.com/YumNumm/EQMonitor/commit/0f8431a1abd1579eebe4ce845204f05e06b75c3b))
* 購読状態に同期結果を追加 ([da38e92](https://github.com/YumNumm/EQMonitor/commit/da38e92dad99644df3398bfdf5a54a3f38f9f167))
* 通知設定を確認済みのプラン制限に追従 ([24e14bf](https://github.com/YumNumm/EQMonitor/commit/24e14bf27053604c5784ef4a9a21d7bc50528d6a))
* 選択状態を保持する履歴一覧と詳細の適応表示を追加 ([69627ae](https://github.com/YumNumm/EQMonitor/commit/69627aeac8d48c5d0e348be01fe978f7ce918803))
* 都道府県境界を非同期で読み込む ([416129f](https://github.com/YumNumm/EQMonitor/commit/416129f072b19f0f722154704584dea1a810cf95))
* 震源要素をGoogle Sans Codeで統一する ([22b317c](https://github.com/YumNumm/EQMonitor/commit/22b317cdc3931f2824c1819a262245a60d79df5d))


### Bug Fixes

* analyzer error ([f3c86ae](https://github.com/YumNumm/EQMonitor/commit/f3c86ae432c684b8f834959658ccffe518a0a5e7))
* analyzer error ([86bf894](https://github.com/YumNumm/EQMonitor/commit/86bf894f1a3579cff0bced4c649faa04840b03fc))
* Android前面通知の表示をリポジトリへ集約 ([d934006](https://github.com/YumNumm/EQMonitor/commit/d934006971691e4fb3ccb5e392b2274d45ec7c46))
* Android配布で未使用のCodemagic依存を除去 ([fe29945](https://github.com/YumNumm/EQMonitor/commit/fe299456fb9cd0cb9143acc557a2c510e6192b9f))
* App Intentの連続遷移と詳細表示の共通処理を修正 ([919718e](https://github.com/YumNumm/EQMonitor/commit/919718ef372d373b194e6344969a3c819f06fd10))
* Asset Pack インストール失敗カードの題名を内容に合わせる ([14cb2e7](https://github.com/YumNumm/EQMonitor/commit/14cb2e776880af6eb536ca3947ba88eeebb5057d))
* Asset Pack の解析失敗時も同梱版へフォールバック ([2111f8b](https://github.com/YumNumm/EQMonitor/commit/2111f8bd65eebee4754dd5d8a47b653a928c22b2))
* Asset Pack を Android の Auto Backup 対象から除外 ([b734947](https://github.com/YumNumm/EQMonitor/commit/b734947bdeeb52f4eadc4b8cf3a6be00c3096a2b))
* CDのmiseダウンロードを有限回再試行 ([f7d1dad](https://github.com/YumNumm/EQMonitor/commit/f7d1dadafac3f6d2a46e664c16db8268bd56787d))
* CD初期ジョブのcheckout時間に余裕を確保 ([a9c9308](https://github.com/YumNumm/EQMonitor/commit/a9c93080843cfc901f2c21acf545a37a210ffb1f))
* **ci:** zizmorの[`self-repository`](https://docs.zizmor.sh/audits/#remediation_26)ルールによる指摘事項に対応 ([6aad416](https://github.com/YumNumm/EQMonitor/commit/6aad4160df3c416f56cdfd01c685c20305f6fb78))
* Control Centerから地震履歴を開く処理を修正 ([192812d](https://github.com/YumNumm/EQMonitor/commit/192812dfa3850490d6ab9d8501b5788163148a78))
* Deploy Appの準備段階の失敗を解消 ([ef75f62](https://github.com/YumNumm/EQMonitor/commit/ef75f6287d48af11e2c728ccd9c18cc83847ac8b))
* design ([e8bbb99](https://github.com/YumNumm/EQMonitor/commit/e8bbb99d6f661466276fbe8285debfdc0bdc81af))
* device-id読み取り失敗でAPIリクエストを失敗させない ([7fec3fd](https://github.com/YumNumm/EQMonitor/commit/7fec3fd809334f17043a9cf14eca6ec98caec705))
* Dynamic IslandのEEW表示を共通化し展開表示の情報を整理 ([ce3cc6d](https://github.com/YumNumm/EQMonitor/commit/ce3cc6d84bd172ab2cd3312f2d46a489a62a3651))
* EEW Live Activityのheadlineをライトモードでも白文字にする ([136f742](https://github.com/YumNumm/EQMonitor/commit/136f74218971c38cda9ff9a9164f20775930557f))
* EEW再取得中の表示消失を防ぐ ([112971c](https://github.com/YumNumm/EQMonitor/commit/112971c6d7e2fa5f51a771ecfc9489fffd0789b2))
* EEW再取得中も受信済みデータの表示を維持する ([7045043](https://github.com/YumNumm/EQMonitor/commit/704504386e22672df6c5a9f29a843e3a3b2f6fcd))
* EEW取消報でカードが消え取消表示が出ない問題を修正 ([0260e00](https://github.com/YumNumm/EQMonitor/commit/0260e000db9e359b4a4bb1aecdafbc95798dad10))
* EEW履歴とイベント別EEWで報の上書き・欠落が起きる問題を修正 ([727f18c](https://github.com/YumNumm/EQMonitor/commit/727f18c43cf29a77e36d70eea79462acda8c4580))
* EEW履歴の発表中セクションに終了済みのEEWが残る問題を修正 ([3c9058a](https://github.com/YumNumm/EQMonitor/commit/3c9058a1b4f395b8bd66f2cb4fe86df25e34bcab))
* Expandedの上段高と外周に沿う角丸を調整する ([adfc62b](https://github.com/YumNumm/EQMonitor/commit/adfc62b17e22e813e79f44d6ce3f7fb57ab21003))
* Expandedの高さ不足と警報名の省略を解消する ([3c07045](https://github.com/YumNumm/EQMonitor/commit/3c070457097a62b31af3c0c1d43907ce3d85f6e2))
* Expanded上部を拡大し警報名の行高を確保する ([0ca1ff1](https://github.com/YumNumm/EQMonitor/commit/0ca1ff1638b8189c9b2a30bbd94f0c8102cb7920))
* Firebase AnalyticsのObjective-Cリンク設定を補完 ([76c27d5](https://github.com/YumNumm/EQMonitor/commit/76c27d5d1a9a0086aa995532ae5a77f9a25a36da))
* Firebase通知権限の永久拒否状態を表示する ([3235f51](https://github.com/YumNumm/EQMonitor/commit/3235f51b25e0fe6c651d394c87d3d212ab2f2e1c))
* Flutter CIのツール解決と同梱アセット準備を限定 ([d338ad1](https://github.com/YumNumm/EQMonitor/commit/d338ad1bd93c814fa18af6eda8042b866945501d))
* Flutter CIの不要なツール導入を防止する ([9ceb6db](https://github.com/YumNumm/EQMonitor/commit/9ceb6dbf0490f92063bbc0517176d8b1e00beaf9))
* Flutterジョブの自リポジトリ展開エラーを回避 ([4dba613](https://github.com/YumNumm/EQMonitor/commit/4dba6139a2a07edcb2fd94c4a7049301b1ef87d1))
* foreground復帰時もPro確認値を保持し通信エラーでは期限まで維持 ([1188210](https://github.com/YumNumm/EQMonitor/commit/11882108d851b8d3a839a4adad8225d96bcfc520))
* Google Playの編集処理を実行間で直列化 ([3079647](https://github.com/YumNumm/EQMonitor/commit/30796472393772cd550abdbfaa01ca34c23fce77))
* headless で保存済み Telegram URL を本体と同じ保存先から読む ([29fc904](https://github.com/YumNumm/EQMonitor/commit/29fc90435b77a4b93fd58b50b0ed074076a73127))
* headless 位置処理で有効なダウンロード版 Asset Pack を読む ([f7e1e65](https://github.com/YumNumm/EQMonitor/commit/f7e1e657bc635bd1e0d73c59107c2baf8b837148))
* Intentの通信エラーを日本語案内へ正規化する ([9a1c2c5](https://github.com/YumNumm/EQMonitor/commit/9a1c2c58990b62faa5e771bcd929b2f7a0a08c4c))
* iOS 26.1未満のLive Activity対応判定を修正 ([c119f85](https://github.com/YumNumm/EQMonitor/commit/c119f85b830de3fe55dce6ba23e7383d036556a4))
* iOSの未使用トラッキング許可説明を削除 ([783f919](https://github.com/YumNumm/EQMonitor/commit/783f91914fb2acedc8a5305424b77b5434c7ded1))
* iOSの署名済みIPA書き出し時間を確保 ([73f9cea](https://github.com/YumNumm/EQMonitor/commit/73f9cea5a189c089e9196632d968b5ecf3cd9eb0))
* iOS拡張へproductionフラグと機能制限を反映 ([9a557b9](https://github.com/YumNumm/EQMonitor/commit/9a557b9b3220d39798806d34bcc7283c273dd2da))
* iOS配布CIをXcode 27対応runnerへ切り替え ([95bbe51](https://github.com/YumNumm/EQMonitor/commit/95bbe5117d905a271cefc3f1ffece4738fbd912d))
* iOS配布用のAnalytics依存をクラッシュ修正版に更新 ([509316e](https://github.com/YumNumm/EQMonitor/commit/509316ebd67df500340e75b5d157626d6547cbfa))
* **knet:** JST以外の端末でK-NETの時刻を正しく扱う ([c1a6dc1](https://github.com/YumNumm/EQMonitor/commit/c1a6dc1a70c1ae0a9282a75d5108f86c53933abf))
* layout error ([828e7b3](https://github.com/YumNumm/EQMonitor/commit/828e7b3ea1b2bf99f1e6150e0b5bc13b2f724cd7))
* Live ActivityのMAXと震度を中央揃え ([7f36177](https://github.com/YumNumm/EQMonitor/commit/7f36177ec4150b5fbb45ef46d82f2fae20a54a02))
* Live ActivityのM数値の字間を以前の値に戻す ([41e6e0f](https://github.com/YumNumm/EQMonitor/commit/41e6e0f2327c67a000c5edc626b6607c8cc3c62f))
* Live Activityの震源要素と余白を統一し表示の見切れを修正 ([11b2614](https://github.com/YumNumm/EQMonitor/commit/11b26142c40999d04e0553fd330639c9d38eaea7))
* Paywallの特典をPro限定の実機能に揃え支払い保留文言を調整 ([6e8e736](https://github.com/YumNumm/EQMonitor/commit/6e8e7365cdbbc75dce9a7d29ce26068cacda6678))
* PrivacyInfo に App Group UserDefaults の理由コード 1C8F.1 を追加 ([4a48d56](https://github.com/YumNumm/EQMonitor/commit/4a48d56509499d62603a7b6f631dbb7ad237710e))
* productionで揺れ検知処理と既存通知を無効化 ([3349db2](https://github.com/YumNumm/EQMonitor/commit/3349db221217bf2530d354e5eeda75b14762707d))
* productionのTelemetry保存と送信を停止 ([115df66](https://github.com/YumNumm/EQMonitor/commit/115df66742e3027a6d3af26d5638a5e604f60f48))
* Pro加入状態と共通の利用制限表示を整備 ([294c9d0](https://github.com/YumNumm/EQMonitor/commit/294c9d020834623ce778c0c20a419fc0f954dd4b))
* resume時に端末が未登録ならprovisionをやり直す ([79a6bd8](https://github.com/YumNumm/EQMonitor/commit/79a6bd89044189677f61abba2b4b78311ae9970f))
* Siriのアプリ名を揃えてIntentテストを登録する ([4a1fda8](https://github.com/YumNumm/EQMonitor/commit/4a1fda80b6026b2e8a93d120d8117a2568613573))
* Swift APIに歴史震度分類を追加する ([b4a94f6](https://github.com/YumNumm/EQMonitor/commit/b4a94f6143c1afe23bfba744a920eb3ffdffb6c3))
* WebSocketの無受信を検知して再接続する ([6c60626](https://github.com/YumNumm/EQMonitor/commit/6c60626840e2b7acba510f1dc8b9d773404eac8c))
* XcodeGenの基準ディレクトリをソースと一致させる ([a1f1600](https://github.com/YumNumm/EQMonitor/commit/a1f16006cda2a45d580030ccef7c16b922b483b4))
* アプリの静的解析を通し全体解析の残件を記録 ([5fc0bd6](https://github.com/YumNumm/EQMonitor/commit/5fc0bd64f29ab8281ef7c737dc349fbe4e3df4ac))
* アプリ設定に合わせてマップ配色を切り替える ([52cd267](https://github.com/YumNumm/EQMonitor/commit/52cd267bdee1651cd8f481a2d789ddae59ab1cf9))
* カタログと通知の時刻表示をJSTに統一 ([73fd37a](https://github.com/YumNumm/EQMonitor/commit/73fd37a549ea6d9b3cb5f9ad5f65f81ea23f0c63))
* コールドスタートの通知タップ遷移先喪失と計測失敗時のタップ不能を修正 ([1ab5c34](https://github.com/YumNumm/EQMonitor/commit/1ab5c3416c4710e14f3002d602a18889acb7d296))
* コントロールセンターから地震履歴を開く導線を修正 ([bbf5c76](https://github.com/YumNumm/EQMonitor/commit/bbf5c768934cab4287f52d6cb757a716c7ee710e))
* ストアの支払い保留を購入失敗ではなく保留中として表示 ([0835b2a](https://github.com/YumNumm/EQMonitor/commit/0835b2a0c22b4e3b07e908c3f3c37042a4a5b5aa))
* デバッグと診断の時刻表示をJSTに統一 ([5487580](https://github.com/YumNumm/EQMonitor/commit/5487580cba7d259faeeebd543f3ca49925f3ffa7))
* デバッグメニューを開けないときは加速度センサーを購読しない ([fb0941d](https://github.com/YumNumm/EQMonitor/commit/fb0941db80a5b3457084a3db0cf6c1970ac12709))
* テレメトリ DB のパス解決に失敗しても起動を継続する ([99deb5c](https://github.com/YumNumm/EQMonitor/commit/99deb5ccb68b23b8a8499876ef88c43b5504ef66))
* ネイティブ検証の全ソースを絶対パスで参照する ([8c7d1f5](https://github.com/YumNumm/EQMonitor/commit/8c7d1f5bba897e42c41b47bfd0d9ccb55183b0ad))
* ネットワーク変化時にジッタ付きでWebSocketを再接続する ([e881429](https://github.com/YumNumm/EQMonitor/commit/e8814291193153922ca82f4814968bba998af1be))
* プッシュトークン更新が破棄済みのNotifierへ渡る問題を修正 ([38cf109](https://github.com/YumNumm/EQMonitor/commit/38cf109e6ca974df1edbceaaa99e6e97739013bf))
* プレビュー用Bundleをライブアクティビティに限定 ([4212482](https://github.com/YumNumm/EQMonitor/commit/4212482c188d7453a747083a6fc76b758393a5ba))
* モニターの既定取得元と長周期画像URLを修正 ([eb5319a](https://github.com/YumNumm/EQMonitor/commit/eb5319ac2938e7e2224682ea9b1d19ebfc6d2fa6))
* もろもろ ([1dea151](https://github.com/YumNumm/EQMonitor/commit/1dea1519dbf4e03dd3ff874309a5af8bdf1ee768))
* リプレイ終了時にEEWのRESTを取り直す ([03f30ef](https://github.com/YumNumm/EQMonitor/commit/03f30ef8460fa99d3e38fc7cbfe89d4337096984))
* レイアウトバグを修正 ([d9d3b0d](https://github.com/YumNumm/EQMonitor/commit/d9d3b0d51ab70f0dc08d3cacd98ccff8bdd5fe28))
* ローカル通知のデータ変換と起動待機を追加 ([e06d5b0](https://github.com/YumNumm/EQMonitor/commit/e06d5b0437a7b91f8dbe92b6c104c6358b9ff95f))
* 一時Xcodeプロジェクトからローカル依存を解決する ([05f5b14](https://github.com/YumNumm/EQMonitor/commit/05f5b14d59978a7c5c568cba7f73444407bd620a))
* 再接続時のreadyイベントが下流へ通知されない問題を修正 ([c646105](https://github.com/YumNumm/EQMonitor/commit/c6461053fd68f714515af3eb4c897120b3f4d882))
* 再試行間隔の計算をRetryBackoffPolicyに移しトップレベル関数の lint 違反を解消 ([005ef45](https://github.com/YumNumm/EQMonitor/commit/005ef45d816a9a5cb5f6987efcd1a44b1f178111))
* 最近の地震の再読み込み中も既存一覧を維持 ([6cac7d0](https://github.com/YumNumm/EQMonitor/commit/6cac7d0920142abb01e8b36670e5c33a288d193b))
* 前面通知の受信とタップ遷移を接続 ([233e047](https://github.com/YumNumm/EQMonitor/commit/233e04762aea2a48c8fdddb66ff3cb5eaef8bab3))
* 取消メッセージに先ほどの地震であることを明記する ([651f1b2](https://github.com/YumNumm/EQMonitor/commit/651f1b271f4e947441b66fa570bc4e0888e67a70))
* 取消時の種別と不要な説明文を整理する ([c88ba77](https://github.com/YumNumm/EQMonitor/commit/c88ba77788c51a9b8498bf6c11592c112577e282))
* 地図設定の保存値を解釈できない場合は既定値を使う ([3587455](https://github.com/YumNumm/EQMonitor/commit/35874551140c167964b3e8effeb4c1f2de5909e1))
* 地域選択地図に都道府県の外周レイヤーを接続 ([85cb1f5](https://github.com/YumNumm/EQMonitor/commit/85cb1f5d2f1f79f3f5fac25a07127a9c48beacff))
* 地域選択地図の非表示フィルターによるクラッシュを修正 ([66b4516](https://github.com/YumNumm/EQMonitor/commit/66b4516558df7d7f78e6e2a6ce9d6115555d6198))
* 地震Entityの状態と型付きプロパティを公開する ([f2fd1d7](https://github.com/YumNumm/EQMonitor/commit/f2fd1d752a495b4299ded1b94f1ffce852511087))
* 地震Intentの地域検証と取得結果保持を共通化する ([ed2da22](https://github.com/YumNumm/EQMonitor/commit/ed2da222518dc6a00a60fe783f11686239d1d2be))
* 地震Snippetの詳細導線と保存地域の表示を修正 ([003eb24](https://github.com/YumNumm/EQMonitor/commit/003eb24633908ce916ab7e29c9fa0e81e94c0e67))
* 地震カードの再描画と明示更新を分離する ([6d184f4](https://github.com/YumNumm/EQMonitor/commit/6d184f4886557527437c5c51202b1461becab8e4))
* 地震履歴の再取得失敗と再試行を表示 ([5973e41](https://github.com/YumNumm/EQMonitor/commit/5973e41e8441453458013d099051c909deac76ab))
* 地震履歴の分割表示では詳細の戻るボタンを隠す ([a0ab6d4](https://github.com/YumNumm/EQMonitor/commit/a0ab6d4b32c082ce1f2eebb734b7fdae4756227a))
* 地震履歴の分割表示で詳細の戻るボタンを非表示にする ([3f92e94](https://github.com/YumNumm/EQMonitor/commit/3f92e9468cb351948759b320db61da1c602b78f8))
* 地震履歴の観測点をSymbolのみで描画 ([c225512](https://github.com/YumNumm/EQMonitor/commit/c2255120ddb3d56944aeca7af63820429d7631e8))
* 地震履歴一覧のグループ検索で要素がない場合に例外にしない ([8ceac80](https://github.com/YumNumm/EQMonitor/commit/8ceac80f0cfab3779cf30002117e8994e952d2e2))
* 地震履歴一覧を作り直さず先頭ページの差分反映で新着に追従 ([0823b1f](https://github.com/YumNumm/EQMonitor/commit/0823b1f40fc862579c1532d7208d8f3fb0694185))
* 地震履歴地図で観測のない区域の「観測なし」表示を復元 ([0915404](https://github.com/YumNumm/EQMonitor/commit/0915404c64d53b851cae4c5896afd441dffafd83))
* 地震履歴地図のLPGM観測点タップと震度DB読み込み中の区域タップを修正 ([de5634e](https://github.com/YumNumm/EQMonitor/commit/de5634e7eca512179de486112aaa48558b9b52d1))
* 地震履歴詳細で表示範囲の算出に失敗しても震源か既定位置で地図を表示 ([a20ee28](https://github.com/YumNumm/EQMonitor/commit/a20ee2812111064f177b5346ec889dab9c5e7031))
* 地震活動ページで終了日当日の地震が欠落する問題を修正 ([f2198aa](https://github.com/YumNumm/EQMonitor/commit/f2198aa6ff90713fd18df20ac18d19ff7f24968f))
* 地震詳細のSwift API型を最新契約に揃える ([68628cb](https://github.com/YumNumm/EQMonitor/commit/68628cb926a93b027229b2d33f3e4a118d1a906c))
* 地震詳細の復元と地域震度の保持を実装する ([6123a08](https://github.com/YumNumm/EQMonitor/commit/6123a08b872f2bc955b5ca68dd9cb505308d8b9c))
* 実Widgetの色定義をネイティブテストへ含める ([45daa44](https://github.com/YumNumm/EQMonitor/commit/45daa445b14ccdc6eda49550361ce372a4740172))
* 市区町村別最大震度の選択枠を地域選択UIに合わせる ([88c8b0c](https://github.com/YumNumm/EQMonitor/commit/88c8b0c5b4d91b1a1b1d17f70b9369adba5a261d))
* 強震モニタの取得失敗時は遅延表示にし表示時刻を観測時刻に ([8d65b72](https://github.com/YumNumm/EQMonitor/commit/8d65b72b7f65164aac6afed9de6673a5fbdc1187))
* 強震モニタの遅延詳細設定を非表示にする ([7eae640](https://github.com/YumNumm/EQMonitor/commit/7eae640e643a367f1fe3ee003da27c40134f2916))
* 強震モニタを inactive では停止しないように ([3826928](https://github.com/YumNumm/EQMonitor/commit/3826928cd3a6e1d870ca5c225401a24b96e9c376))
* 強震モニタ画像解析 worker に6秒のタイムアウトと再起動を追加 ([17f9388](https://github.com/YumNumm/EQMonitor/commit/17f9388614420cff1c0755f77640f53ee41d5f50))
* 強震モニタ解析の座標範囲外と worker 終了時の応答待ちを処理 ([7d3e16a](https://github.com/YumNumm/EQMonitor/commit/7d3e16a72b5b5dc3b16390858d7d46352b8a42f6))
* 強震モニタ設定の読み込み中に requireValue で落ちないように ([2008825](https://github.com/YumNumm/EQMonitor/commit/2008825ac384395870fc913eeba7949788db0956))
* 復元元のない304応答をエラーとして扱う ([bb83e6a](https://github.com/YumNumm/EQMonitor/commit/bb83e6a2138b143f29692ccc1387e358c15be604))
* 推計震度archive取得の停止処理を強化 ([cdbb7c1](https://github.com/YumNumm/EQMonitor/commit/cdbb7c1bb523e527acd3290796f32cf34ddb9713))
* 旧版 Asset Pack の削除を次回起動時まで遅らせる ([b4f7ea8](https://github.com/YumNumm/EQMonitor/commit/b4f7ea8adc2e3f78495801f6047aec5227706de7))
* 月額商品のID不一致時に購入を停止する ([7696803](https://github.com/YumNumm/EQMonitor/commit/76968038be623e3c42bd0ae8d1a689f8f926d5ad))
* 権限付与後の現在地監視と初回同期を復旧 ([d2c3146](https://github.com/YumNumm/EQMonitor/commit/d2c314602d542b321c7678bab18132d519db84d3))
* 権限要求後に再取得した最新の権限状態を返す ([89e8ce8](https://github.com/YumNumm/EQMonitor/commit/89e8ce8dcca1b35c4494b3d2d67f975bb33988ba))
* 気象庁XMLがある地震だけ電文一覧を表示 ([b3e5c06](https://github.com/YumNumm/EQMonitor/commit/b3e5c0656cdb08b62166808bdf21ef85bc35b7a2))
* 気象庁XMLがある地震だけ電文一覧を表示 ([1acf8af](https://github.com/YumNumm/EQMonitor/commit/1acf8af80ce18c49d264fb6aa836ae781e4b8dc1))
* 津波詳細のポーリング失敗時に前回値を保持して表示 ([b5fc8c4](https://github.com/YumNumm/EQMonitor/commit/b5fc8c4af850f3a65d799568598c98a7dc0ec5f3))
* 無料プランのEEW履歴と近傍地震へのアクセスを制限 ([ddd1eda](https://github.com/YumNumm/EQMonitor/commit/ddd1eda7e9597de1ae6a806f43e66da17cf3b07a))
* 現在地の弱い揺れを薄い蒼の注意帯で表示する ([591d53d](https://github.com/YumNumm/EQMonitor/commit/591d53d647d50ffad917b3b30ea29753e97225ee))
* 確定報の区域ポップアップで速報バッジを出さない ([1ac212e](https://github.com/YumNumm/EQMonitor/commit/1ac212ec95337da1c680d1aa0c5f50e592e6d899))
* 細かいUI崩れの修正 ([f8b57a6](https://github.com/YumNumm/EQMonitor/commit/f8b57a683a89c16be38b8de8caf856c2fa12677f))
* 統合Live ActivityのEEW表示モデルと地震情報の扱いを修正 ([fea4458](https://github.com/YumNumm/EQMonitor/commit/fea4458fc88f4b9a36ede51ff97e434591c207e0))
* 統合Live Activityの不要なプレビュー状態を削除 ([3f6e7a9](https://github.com/YumNumm/EQMonitor/commit/3f6e7a9a7d50385278b14ac5a1e860d19e17fc61))
* 統合Live Activityの重複表示を省きロック画面を小型化 ([edc8d79](https://github.com/YumNumm/EQMonitor/commit/edc8d79fe8da6df8f10edeeadee6ee38b0e9ab46))
* 統合Live Activityの震源表示をEEWに統一 ([7949b67](https://github.com/YumNumm/EQMonitor/commit/7949b6749d6e205eb592d32c9c2f115bba9fd58b))
* 緊急地震速報履歴のAppBar配置を地震履歴と統一 ([0ed0075](https://github.com/YumNumm/EQMonitor/commit/0ed00759b9beaf2205fe06a32345d337b5159b61))
* 観測点詳細シートのはみ出しと表の文字色を修正 ([eabfcf6](https://github.com/YumNumm/EQMonitor/commit/eabfcf6263060de71de05aa9c939e62fc90aedd2))
* 訓練報・試験報のEEWを全画面警報と振動の対象外にする ([5735173](https://github.com/YumNumm/EQMonitor/commit/57351733a144aed392733aca5ad8bf776be98a84))
* 購入直後の同期が409 pendingのとき端末登録と同じ間隔で再試行 ([603c64d](https://github.com/YumNumm/EQMonitor/commit/603c64d30ac26a1ffadc2315170708eb2156d271))
* 購読APIの端末認証と資格情報変更の通知を追加 ([d8d91ea](https://github.com/YumNumm/EQMonitor/commit/d8d91eac4ff05271d2e364a019c31b1a13f3da30))
* 起動失敗時のエラー画面に既定テーマを渡す ([85ffbef](https://github.com/YumNumm/EQMonitor/commit/85ffbefefd86eb7909d9a9353228addbb9a1b008))
* 通知設定の保存応答を再取得前に反映 ([a9501a3](https://github.com/YumNumm/EQMonitor/commit/a9501a379266c19f52aedcfdf77355883677b1f5))
* 通知配信ログの本文を左寄せに修正 ([de65217](https://github.com/YumNumm/EQMonitor/commit/de6521760e4cc00145ec44a3b817555ec37b9825))
* 都道府県選択を市区町村へ展開せず専用境界で強調 ([241e8b7](https://github.com/YumNumm/EQMonitor/commit/241e8b7578afd3867a7d32adbd25093c9c7a3b04))
* 配布ビルドをXcode 27.0正式版に固定 ([2704a5f](https://github.com/YumNumm/EQMonitor/commit/2704a5fb968ecff8385da1fe9723356ccd25d14f))
* 配布ビルドをXcode 27.0正式版に固定 ([1859019](https://github.com/YumNumm/EQMonitor/commit/1859019fd3dc7e25f4ad098736f7c6c510d661aa))
* 長周期データのない観測点詳細で長周期の解説リンクを出さない ([6ea47db](https://github.com/YumNumm/EQMonitor/commit/6ea47db42743ccb7707cfab8645449516a7176ee))
* 長周期画像の解析例外と誤った震度換算を修正 ([bb8fd5c](https://github.com/YumNumm/EQMonitor/commit/bb8fd5c8f89dfdb746469514ee7ab7966588a0ff))
* 電文一覧の緊急地震速報カードの押下表示を修正 ([afa8ae8](https://github.com/YumNumm/EQMonitor/commit/afa8ae8d7736ec5df91fc820928c3296426d0524))
* 電文一覧の緊急地震速報カードの押下表示を修正 ([d742128](https://github.com/YumNumm/EQMonitor/commit/d7421285ca9f12f2cb9905e6d7aea64baed6758f))
* 震度速報の対象地域から地図の初期表示範囲を設定する ([4cb8cac](https://github.com/YumNumm/EQMonitor/commit/4cb8cac716c9792a7bd0caf82cd567592966d068))
* 震度速報の重複バッジを抑止し巨大地震のM表記を修正 ([9532bc1](https://github.com/YumNumm/EQMonitor/commit/9532bc165ee7d11d26b8a1b395e83a18b9c3458b))
* 音声応答と地震カードで同じ取得結果を表示する ([0528882](https://github.com/YumNumm/EQMonitor/commit/0528882e2a3a7921b605c0c2c3c152fab663f49d))


### Reverts

* api-stub結合テストの削除を別ブランチへ移すため取り消し ([68b7328](https://github.com/YumNumm/EQMonitor/commit/68b7328df873b4120548723161e21a2f00a0271a))


### Miscellaneous Chores

* 次のリリースを3.0.0に固定する ([7f67b65](https://github.com/YumNumm/EQMonitor/commit/7f67b65afaf110bca689c86dfb56a2a9d2770e23))

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
