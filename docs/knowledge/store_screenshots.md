# ストア画像の自動生成

2026-11-22 作成。正本は `tool/store_screenshots/` と `.github/workflows/store-screenshots.yaml`。
画面操作は Patrol（`app/patrol_test/`）、撮影は host 側で行う。

## 全体の流れ

1. 撮影（`capture.py`）: Simulator / Emulator を準備して `patrol test --target patrol_test/store_screenshots_test.dart` を起動する。
   Patrol テストがシーンを順に表示し、host 側が `simctl io` / `adb screencap` で画面全体を撮る。
2. 合成（`compose.py`）: Figma から抽出した背景（グラデーション＋ロゴ＋見出し）に、角丸のスクリーンショットと端末フレームを重ねる。
3. `Store Screenshots` workflow: 本番タグ（`v*`、`v*-beta.*` は除外）の push と手動実行で起動する。
   成果物は artifact `store-screenshots-ios`（合成済み）と `store-screenshots-{ios,android}-raw`（撮影のみ）。
   ストアへのアップロードは行わない。

## Fixture の暗号化

- ライセンス上リポジトリで公開できないファイル（Apple の端末フレーム、壁紙、強震モニタ画像を含む EQRP）は
  age で暗号化して `tool/store_screenshots/fixtures/*.age` に置く。平文は同ディレクトリの `.gitignore` で除外する。
- 公開鍵は `fixtures/recipients.txt`、秘密鍵は SOPS の `.env.json` の `STORE_SCREENSHOT_FIXTURE_AGE_KEY`。
  暗号化は公開鍵だけで行えるため、秘密鍵を持たない人も fixture を追加できる。
- CI は `AGE_KEY` → `.env.json` → `mise env` で秘密鍵を得て、`decrypt_fixtures.sh` が標準入力経由で age に渡す。鍵をファイルに書かない。

```sh
# 初回のみ。鍵を生成し .env.json と recipients.txt を更新する（--rotate で鍵交換と再暗号化）
mise exec -- tool/store_screenshots/setup_fixture_key.sh
# fixture 名は小文字英数と . _ - のみ
mise exec -- tool/store_screenshots/encrypt_fixture.sh <path>/noto.eqrp noto_peninsula_2024.eqrp
mise exec -- tool/store_screenshots/decrypt_fixtures.sh build/store_screenshots/fixtures
```

| fixture 名 | 用途 |
| --- | --- |
| `bezel_iphone_18_pro_black_portrait.png` | 合成の iPhone のフレーム（黒）。Apple Design Resources の `Bezel-iPhone-18.dmg` の `PNG/iPhone 18 Pro/iPhone 18 Pro - Black - Portrait.png` |
| `bezel_apple_watch_ultra_4_black_ocean_band_translucent_black.png` | 合成の Apple Watch のフレーム。`Bezel-Apple-Watch-Ultra-4-2026.dmg` の `PNG/AW Ultra 4 - Black + Ocean Band Translucent Black.png`（620×940、画面は 99,213 から 422×514） |
| `bezel_iphone_18_pro_glacier_portrait.png` | Figma のデザインが使っているフレーム。`figma_extract.py --bezel-out` で取得する。合成では使っていない |
| `noto_peninsula_2024.eqrp` | 能登半島地震のリプレイ（`eew_warning` / `kyoshin_monitor`） |
| `wallpaper_lock_screen.jpg` | ロック画面の壁紙（2576×1717 の横長）。`capture.py --wallpaper` が `set_ios_wallpaper.sh` で Simulator に設定する |

## Figma からの抽出

- 対象は Figma `EQMonitor (PUBLIC ver)` の Section `iOS Store Screenshot`（`2147:448`）。
  ページと Figma ノード・シーンの対応は `layout.json` の `pages` に手で書き、座標と背景は抽出スクリプトが更新する。
- `figma_extract.py` は frame の塗りから背景グラデーションを再計算し、ロゴ・見出しを Figma の画像書き出しで重ねる。
  端末は「画像塗り（FIT）を持ち、子に画像塗り（FILL）の枠を持つ INSTANCE」として検出する。
- 2026-11-22 に、Figma 上の現行スクリーンショットを入力にした合成結果と Figma の frame 書き出しを比較した。
  平均差は 1/255 前後で、差は文字の輪郭のサブピクセル位置に限られる。

- Figma の画像書き出し API（`/v1/images`）は Starter プランだと回数制限が厳しい。2026-11-23 は HTTP 429 で `Retry-After` が約 3.6 日だった。
  端末フレームは画像塗りの元画像（`/v1/files/<key>/images`）から取るため、この制限中でも取得できた。背景の再生成（ロゴ・見出しの書き出し）はできない。
- 2026-11-23 に端末フレームを取得して暗号化した。`layout.json` の端末の座標は Figma の現状と一致していた。

```sh
FIGMA_TOKEN=<token> mise exec -- uv run tool/store_screenshots/figma_extract.py --bezel-out build/store_screenshots/figma
```

## iPhone Duo と Android

Figma のデザインは iPhone の縦長（1290×2796）しか無い。別の縦横比は、既存の背景と自前で描いた枠から作る。

- `derive_background.py`: 既存の背景から線形グラデーションを最小二乗で推定し、白い見出し・ロゴを (画素 - 地) / (白 - 地) で抜き出して新しい寸法に置き直す。
  同じ寸法で作り直すと元との平均差は約 2%。見出しの大きさは元の幅に対する比率（`--text-scale` で調整）。
- `generate_frame.py`: 画面の寸法から黒い端末の枠を描く（画面は透明、カメラの穴とボタンは任意）。生成物は `frames/` に置き、`compose.py` は fixture に無い枠を `frames/` から読む。
  Apple Design Resources に `Bezel-iPhone-Duo.dmg` があるが、取得していない（ダウンロードと使用許諾への同意が必要）。
- `layout_*.json` の `backgroundCrop` で背景の一部を切り出せる。

### iPhone Duo

- [App Store Connect の仕様](https://developer.apple.com/help/app-store-connect/reference/app-information/screenshot-specifications)（2026-11-24 確認）:
  外側 1398×2034 / 2034×1398、内側 2007×2853 / 2853×2007。2027 年 4 月から iOS 27.1 SDK 以降を使うアプリで必須。
- Simulator は `iPhone Duo` を iOS 27.2 の専用ランタイム（`com.apple.CoreSimulator.SimRuntime.iOS-27-2-iPhone19-4`）で作る。GitHub の xcode-27 ランナーにも入っている。
  画面は `primary`（外側、1398×2034）と `primary-1`（内側）。内側は `UI Orientation: Landscape Left` で起動し、`simctl io --display=primary-1 screenshot` は 2853×2007 になる。アプリも横向きで描かれる。
- テストに `--dart-define=STORE_SCREENSHOT_FOLD_POSTURE=open|closed` を渡すと、`$.platform.ios.setFoldPosture` で開閉する（Patrol 4.11.0 では実験的。`patrol test` の host サーバー経由）。
  `capture.py --ios-display primary-1`（開いた状態）/ `primary`（閉じた状態）で撮る画面を選ぶ。
- 内側（横向き）では通知センターを開く操作が効かず、重大な通知のバナーが残ったまま撮れた。内側は通知のページを外した 3 枚にしている。
- 内側では地震履歴が一覧と詳細の 2 画面になる。`earthquake_history_list` のシーンは、詳細が空欄の表示（`一覧から表示する情報を選択してください`）を見つけたら、地震詳細と同じ地震を一覧から選んでから撮る。
- `STORE_SCREENSHOT_SCENES` は `--dart-define` でカンマが区切りとして扱われるため、`+` でも区切れる（`eew_warning+kyoshin_monitor`）。

```sh
mise exec -- python3 tool/store_screenshots/capture.py --platform ios --device <duo-udid> --ios-display primary-1 --output build/store_screenshots/duo-open -- \
  <iOS と同じ引数> --dart-define=STORE_SCREENSHOT_FOLD_POSTURE=open
mise exec -- uv run tool/store_screenshots/compose.py --layout tool/store_screenshots/layout_duo_inner.json \
  --screenshots build/store_screenshots/duo-open --fixtures <復号先> --output build/store_screenshots/composed-duo-inner
```

### Android（Pixel 11 Pro）

- Pixel 11 Pro は 1280×2856・495 ppi（[Google Store](https://store.google.com/product/pixel_11_pro_specs)）。
  手元の SDK（cmdline-tools 23.0）と Android Studio 2026.2 の端末定義には Pixel 10 Pro までしか無いため、同じ画面仕様の `pixel_10_pro` から AVD `EQMonitor_Store_Screenshot_Pixel_11_Pro` を作った（API 37 の `google_apis_playstore`）。
  Android Studio の端末画像（`device-art-resources`）も Pixel 9 までのため、枠は `frames/pixel_11_pro_black.png` を描いた。
- Play Store 付きのイメージは root が無く、エミュレーターの `-change-locale ja-JP` は `su` が無く失敗する。アプリが Noto Sans JP を同梱しているため、日本語の字形は端末の言語に依らない。
- Google Play は長辺が短辺の 2 倍以下。`layout_android.json` は iOS の背景の上側 1290×2560 を切り出したキャンバスに置く。通知のページは無い（Live Activity が iOS のみ）。
- 位置情報を要求すると、Google Play 開発者サービスの「位置情報の精度」への同意を求めるダイアログ（`No thanks` / `Turn on`）が画面に重なる。テストは同意せずに `No thanks` を押して閉じる。
- Patrol の Android の `setMockLocation` は呼ぶたびに GPS のテスト用プロバイダーを作り直す。2 回目以降の位置は Google Play 開発者サービスの位置情報に届かず、
  logcat に `FusedLocation: location delivery blocked - too close` が出た（購読を作り直しても同じ）。現在地の違うシーンは別の `patrol test` に分けて撮る。

```sh
for scenes in "eew_warning+earthquake_history_list+earthquake_detail" "kyoshin_monitor"; do
  mise exec -- python3 tool/store_screenshots/capture.py --platform android --device emulator-5560 \
    --output build/store_screenshots/android -- <Android の引数> --dart-define=STORE_SCREENSHOT_SCENES=$scenes
done
mise exec -- uv run tool/store_screenshots/compose.py --layout tool/store_screenshots/layout_android.json \
  --screenshots build/store_screenshots/android --fixtures <復号先> --output build/store_screenshots/composed-android
```

## 撮影のプロトコル

- Patrol の `takeNativeScreenshot` は iOS では何もしない（patrol 4.11.0 の docs）。通知センターやステータスバーを含めて撮るため、撮影は host 側で行う。
- テストはアプリの Documents 配下 `store_screenshot/` に `ready/<scene>` を書いて待つ。host は撮影後に `captured/<scene>` を書く
  （iOS は `simctl get_app_container`、Android は `run-as` と `app_flutter/`）。
- テストは起動前に SharedPreferences へ既読フラグ（オンボーディング・新機能案内・各種お知らせ）を書き、`AppBootstrap.run()` でアプリを起動する。
  `AppBootstrap` が差し替える `FlutterError.onError` などはテスト終了前に戻す。
- 表示の完了は Widget で待つ。リプレイは `ReplayStatusCard`（EEW のシーンは `EewCard` も）、地震詳細は `ValueKey(eventId)`。地図の描画は検出できないため、その後に一定時間待つ。
- 地震詳細が `ErrorCard` になった場合は「詳細」を開いて `failure-<scene>.png` として撮り、要求先と応答をテストの失敗理由に出す。
  ホームのお知らせ欄にも `ErrorCard` が出るため、`EarthquakeHistoryDetailsPage` の配下だけを見る。
- テスト名の表示は 2 つあり、両方を消す。Patrol のラベルは `patrol test --no-label`、`LiveTestWidgetsFlutterBinding` が画面上端に描くものは `setLabel('')`。
- 地震詳細は推計震度分布がある地震だと既定でそれを表示する。観測点を見せるため、`EarthquakeIntensityCard.onDisplayModeChanged` を呼んで「各地の震度」に切り替える（切り替えの状態はページ内の `useState` にしか無い）。
- EEW カードの「現在地」の予想震度・到達までの時間・警報の強調は、位置情報が取れるときだけ出る。テストは `Geolocator.requestPermission()` を呼んでダイアログを許可する。
- ホームのシートは、利用者が動かしていない間、1 つ目の EEW カードの下端に高さを合わせる（`SheetFitTarget`）。撮影のためのシート操作は不要。
  初期位置（画面の 2 割）より低くはしない。カードが消えると初期位置へ戻り、「動かした」状態も解除する。
- 現在地はシーンごとに `$.platform.mobile.setMockLocation` で切り替える。能登半島地震のリプレイには、1 つの現在地で全シーンの表示がそろう地点が無い。
  - `eew_warning`（16:11:08、第30報）は千葉市（千葉県北西部）。現在地が警報の対象で、震度 4、到達まで 17 秒が残る。
  - `kyoshin_monitor`（16:10:21、第10報）は高岡市太田（富山県西部）。震度 4、到達まで 12 秒。警報の強調は出ない。
  - 高岡市太田が警報の強調になるのは 16:10:45（第21報、5弱）以降で、その時点では「すぐに到達」になる。
  - 警報の対象で到達まで時間が残る地域は、第30報では兵庫県北部（20 秒）・千葉県北西部（17 秒）・埼玉県南部（14 秒）・三重県北部（13 秒）など。予想震度はどれも 4。
- 壁紙は `set_ios_wallpaper.sh` が PosterBoard の保存領域へ直接書き込む（iOS のみ）。
  - 標準の `com.apple.WallpaperKit.CollectionsPoster` に、種類が `Still` の `.wallpaper` バンドルを持つ設定を足し、SQLite（`PBFPosterExtensionDataStoreSQLiteDatabase.sqlite3`）で選択中にする。
  - 識別子は標準の壁紙と重ならない値（`99001`）にする。標準の識別子を流用した試行では標準の壁紙が描画された。
  - 保存領域の `PRPosterRoleLockScreen-switcher-index.json` ができるのを待ってから終了し、書き込んで再起動する。設定済みの Simulator では何もしない。
    新規の Simulator ではこのファイルができるまで起動から約 10 分かかった。できる前に書き込むと、SQLite には選択中と記録されるのに既定の壁紙が描画され、再起動しても変わらなかった。
  - 非公開の形式に依存する。失敗しても `capture.py` は警告を出して壁紙なしで撮影を続ける。
- 通知センターの通知は host が `simctl push` で送る（`device.json` の `push`、payload は `tool/store_screenshots/push/`）。
  - テストが `<scene>_notify` の合図を書いたとき、アプリを表示した状態で送る。通知センターを開いた状態で送ると、ペアリングした Apple Watch 側に出て iPhone に並ばない回があった。
  - 重大な通知のバナーは自動では消えず、通知センターを開く操作を妨げる。`closeHeadsUpNotification()` で閉じてから開く。
  - 文面と `aps` の形は backend（`packages/notification-message`）のテンプレートに合わせた。警報は専用の経路（重大な通知）と通常の経路（即時通知）の 2 通が届く仕様。
  - 警報対象地域・報番号・時刻・予報の数値は仮の値。
  - テストは `FirebaseMessaging.requestPermission(criticalAlert: true)` を呼び、ダイアログを許可する。
- Apple Watch の Live Activity は `--watch-device <UDID>` と `--dart-define=STORE_SCREENSHOT_WATCH=true` を付けたときだけ撮る（`watch_live_activity.png`）。
  - Watch は `simctl` でも Patrol でも操作できない。`tool/store_screenshots/watch_ui_tests/`（watchOS の UI テストだけの Xcode プロジェクト）が文字盤から上スワイプしてスマートスタックを開く。デジタルクラウンの回転では開かなかった。
  - iPhone と Watch の Simulator は `simctl pair` でつなぐ。iOS 27.0 と watchOS 27.2 の組では同期のハンドシェイクが `networkFailure` で失敗し続け、Live Activity が届かなかった。iOS 27.2 と watchOS 27.2 では届いた。
  - 届くまでの時間は数秒〜数分とばらつく。host は Watch のログ（Carousel の `received live activity element`）で到着を確かめてから進み、iPhone の通知センターを撮った直後に Watch を撮る。
    届いても Watch 側の表示が `Transaction failed. (timed out)` で出ない回があった（ほかの Simulator を同時に動かしていたとき）。その回は到着のログが出ず、10 分で失敗する。
  - 実際の到達時刻を過ぎると表示が切り替わるため、テストは到達を 30 分先に置き、表示する秒数は `fixedRemainingSeconds` で決める。
  - `simctl status_bar` は watchOS では使えない（`Status bar overrides not supported on this platform`）。Watch の時刻と日付は撮影時のものが写る。CI には watchOS のランタイムとペアの作成が無く、未対応。
- `capture.py` は開始前にアプリの `store_screenshot/` を消す。中断した実行のアプリが残っていると、古い `ready` をビルド中に撮ってしまい、テストが撮影待ちで timeout する。
- 現在地は `device.json` の `location`。富山県高岡市太田 24 番地（国土地理院の住所検索の結果。枝番までは解決されない）を設定している。
- 地震詳細のデバッグボタンは debug ビルドで既定表示になるため、SharedPreferences の `debug` を false にする。
- 撮影は日本語の端末で行う。`capture.py` は Simulator の言語が `ja-JP` でなければ変えて再起動する（`--device` で渡した Simulator も対象）。
  Patrol の `grantPermissionWhenInUse()` は iOS では英語の端末でしか動かないため、iOS の権限ダイアログは SpringBoard のボタンを日本語のラベル（`アプリの使用中は許可` / `許可`）で押す。
- 点滅と到達までの秒数は固定して撮る。撮る瞬間で変わる表示を連写や文字認識で選ぶ方式は、iPhone と Apple Watch の秒数が 0.1 秒ずれるなど安定しなかった。
  - Live Activity: ContentState の任意の項目 `fixedRemainingSeconds` を指定すると、到達までの秒数をその値で止め、「強い揺れに警戒!」の塗りを点灯のままにする（`\.fixedArrivalCountdown`）。サーバーは送らない。Dynamic Island には適用していない。
    `Runner/LiveActivityDebugMethodChannel.swift` に ContentState の写しがあり、項目を足すときは両方に足す。片方だけだと開始時に値が落ちる。
  - アプリ内: `_EewLocalWarningNotice` は `MediaQuery.disableAnimations` のとき塗ったままになる。テストは `FakeAccessibilityFeatures(disableAnimations: true)` を設定する。
- Liquid Glass は最も不透明な設定で撮る。Device Hub の「Liquid Glass」のスライダーは Simulator の `com.apple.UIKit` の `UIViewGlassTintAmount`（実数、右端が 1）を書く。`capture.py` が `device.json` の `liquidGlassTintAmount` を書き込み、変えたときは再起動する。
- ロック画面相当の画像は、Live Activity を開始して `$.platform.mobile.openNotifications()` で通知センターを開いて撮る（iOS のみ）。
  初回は Live Activity の下に許可の確認が出るため、SpringBoard の `許可` を押してから撮る。
- EQRP は CI で `app/assets/store_screenshot_fixtures/` へ復号してからビルドし、`rootBundle` で読む。このディレクトリは平文をコミットしない（`.gitignore`）。
  リプレイは fixture を一時ファイルへ書き出して `ReplayNotifier.open` に渡し、停止してから指定時刻へシークする。`seek` は範囲外の時刻を端へ丸めるため、EQRP の範囲外はテストを失敗させる。
- PR では fixture が無いシーンを飛ばし、タグでは `STORE_SCREENSHOT_REQUIRE_FIXTURES=true` で失敗させる。`STORE_SCREENSHOT_SCENES` で撮るシーンを絞れる。
- Release ビルドは Simulator で動かないため debug ビルドで撮り、`WidgetsApp.debugAllowBannerOverride` で DEBUG 帯を消す。
- API 前段の Cloudflare Snippets（`eqmonitor-backend` の `tools/cloudflare-api-guard`）は User-Agent の version が `x.y.z` か `x.y.z-<prerelease>` でないと 403 を返す。
  - iOS は `--build-name` に pubspec の version から prerelease を落とした `x.y.z` を渡す（`deploy-app.yaml` と同じ）。`3.1.0-beta.4` のままだと `3.1.0.4` になる。
  - Android は渡さない。debug ビルドは `versionNameSuffix` で `.d` が付き、`x.y.z` を渡すと `3.1.0.d` で拒否される。`3.1.0-beta.4.d` は通る。
- ステータスバーは iOS が `simctl status_bar override`、Android が demo mode で 9:41 に固定する。
  Android の demo mode は起動直後に送ると反映されないことがあるため撮影ごとに送り直す。`network -e mobile hide` を送ると反映されなくなったため送らない。
- `capture.py` は iOS の `patrol test` に `XCODE_XCCONFIG_FILE=tool/store_screenshots/ios_simulator.xcconfig` を渡す。
  - Patrol の `xcodebuild build-for-testing` は generic な Simulator 向けに全アーキテクチャをビルドする。`maplibre_native_ffi` は `ios-simulator-x64` の配布物が無くビルドフックが失敗するため、x86_64 を外す。
  - Patrol は `FLUTTER_BUILD_NUMBER` を xcodebuild に渡さない。`Generated.xcconfig` を読まない `FcmServiceExtension` の `CFBundleVersion` が空になり、Simulator へのインストールが `Invalid placeholder attributes` で失敗するため、値を補う。
- `STORE_SCREENSHOT_SCENES` にカンマ区切りで複数のシーンを渡すと、`--dart-define` がカンマで分割されて先頭のシーンしか撮られない（2026-11-23 に手元で確認）。
- Apple の配布物（2026-11 時点）の Watch Ultra 4 は、黒のケースにアルパインループ・オーシャンバンド・トレイルループの 3 種で、ミラネーゼループは無い。ディスクイメージは開くときに使用許諾への同意を求める。
- 黒の iPhone 18 Pro のフレームは Figma のグレイシャーと同じ寸法（1350×2760、画面の穴も同じ）で、`layout.json` の `bezel` を差し替えるだけで使える。`figma_extract.py` を再実行すると `device.bezel` がグレイシャーに戻る。
- 02 は iPhone（元の 86%）を左、Apple Watch（素材の 90%）を右下の手前に置いている。Figma にこの配置は無い。ページの順番は Figma と違い、通知が 2 枚目、履歴が 3 枚目。
- リプレイの EQRP は、本震（`20240101161010`）以外の EEW のフレームを `packages/earthquake_replay/tool/filter_eew.dart` で除いたもの。前後の地震の EEW カードや震央が出ない。
- CarPlay は撮れていない。`simctl io` に CarPlay 種別の画面（Screen ID 3）があり電源も入るが、iOS 27.2 のランタイムでは CarPlay のセッションが始まらず黒いまま。Device Hub は Simulator の CarPlay に対応していない（Apple Developer Forums thread/834440）。
- ページに複数の端末を置くときは `layout.json` の `devices` に手で書く（後ろの要素ほど手前）。`figma_extract.py` は `device` だけを更新し、`devices` は残す。
  03 は履歴一覧（震度 4 以上、`earthquake_history_list`）を奥、地震詳細（`20260823020050`）を手前に、元の 74% の大きさで斜めに重ねている。Figma にこの配置は無い。
- Patrol の iOS 実行には `RunnerUITests` ターゲット（`app/ios/RunnerUITests/RunnerUITests.m`、`FlutterGeneratedPluginSwiftPackage` をリンク、`User Script Sandboxing = NO`、スキームで並列実行なし）が必要。
  Android は `MainActivityTest.java` と `PatrolJUnitRunner`・Test Orchestrator を使う。

## 検証状況

2026-11-22 の PR の CI（fixture なし、Patrol 移行後）で確認した結果。

- Android: Pixel 6（API 35）で `patrol test` が完了し、`earthquake_detail` を撮影した。9:41 のステータスバー、テスト名とデバッグボタンの非表示、30 秒待機での震度分布の描画を確認した。
  ステータスバーの Wi-Fi アイコンは demo mode の指定どおりに出ていない。
- iOS: iPhone 18 Pro（iOS 27.2）で `RunnerUITests` のビルドとテストの起動までは成功した。初回は SPM の取得に約 6 分、ビルドに約 17 分かかる。
  地震詳細は上記の User-Agent の問題で 403 になった（お知らせ欄の `/v2/feeds` で確認）。iOS に `x.y.z` を渡して表示された。
  Android にも `x.y.z` を渡した回は `3.1.0.d` となり、地震詳細が 403 になった。
- iOS の runner が高負荷の回はビルドに 43 分かかり、`simctl` の呼び出しも分単位で遅れて撮影の同期が 5 分で timeout した。
  host はアプリのコンテナのパスを使い回し、テストの待機を 15 分にしている。
- 2026-11-23 に手元の Mac（Xcode 27.2、iPhone 18 Pro / iOS 27.0、fixture なし）で iOS の `patrol test` が完了した。
  - `earthquake_detail` と `lock_screen_live_activity` を撮影し、9:41 のステータスバー、テスト名・DEBUG 帯・デバッグボタンの非表示、震度分布の描画、通知センターの Live Activity を確認した。
  - 1 シーンの撮影は 0.6〜1.6 秒。ビルドは初回 920 秒、2 回目以降は約 140 秒。iOS 27.1 のランタイムでは iPhone 18 Pro / 17 Pro が `Incompatible device` になり、27.0 で作成された。
  - 初回は撮影後にテストが失敗した。通知センターを閉じてアプリが `resumed` に戻ると、`KyoshinMonitorNotifier` が自分自身を `ref.invalidate` し、Riverpod の debug assert（`A provider cannot depend on itself`）が未処理の例外になる。`ref.invalidateSelf` に直した。
  - 言語が日本語の Simulator では、許可の確認が「許可」と表示されたまま写り込んだ。
  - 撮影時の通知センターは、Dynamic Island が写る回と写らない回がある。
- 2026-11-23 に fixture の鍵を作り、`noto_peninsula_2024.eqrp` と `wallpaper_lock_screen.jpg` を暗号化して追加した。復号結果が元ファイルと一致することを SHA-256 で確認した。
  - 同じ Mac で `STORE_SCREENSHOT_REQUIRE_FIXTURES=true` の全 4 シーンが完了した（テスト 76 秒、撮影は 1 シーン 0.7〜0.9 秒）。
  - `eew_warning`（16:11:08）は警報 第30報・M7.4・最大震度 7 の EEW カードと推定震度の塗り、`kyoshin_monitor`（16:10:21）は警報 第10報・M6.2・最大震度 6強 の EEW カードと観測点が表示された。
    どちらもボトムシートは最小の高さ（EEW カードの上部が見える状態）で、Figma との照合は未実施。
  - 観測点の表示への切り替え後も全 4 シーンが完了し、`earthquake_detail` に観測点のアイコンが表示された。
  - 使用済みの Simulator と新規の Simulator の両方で、壁紙を設定した通知センター、現在地の予想震度と到達までの時間（`kyoshin_monitor` は震度 4・12.0 秒、`eew_warning` は震度 6弱・「すぐに到達」・「強い揺れに警戒!」）、カード全体が見えるシートの高さを確認した。
- ローカルで確認済み: fixture の暗号化・復号・鍵交換（`test_fixture_crypto.sh`）、合成（`test_compose.py`）、
  シーン設定（`test_capture.py`）、Dart の静的解析、workflow の jactionlint / zizmor / ghalint / pinact。
- 2026-11-23 に手元で 4 ページを合成し（1290×2796）、Figma の構成どおりにフレーム・背景・見出しが重なることを確認した。
- 未検証: CI（iOS 27.2 のランタイム）での壁紙の設定・リプレイのシーン・通知センターの撮影・合成。残件は [TODO](../todo/850_store_screenshots.md)。

## 制約

- simctl には壁紙の設定とロックの操作が無い（Xcode 27 の `simctl help` で確認）。`prefs:root=Wallpaper` も Simulator では開けない。
- 写真アプリからの壁紙の設定は使わない。操作は Patrol のネイティブ操作で最後まで通るが、試した範囲では壁紙が黒く描画された（2026-11-23、iPhone 18 Pro / iOS 27.0 の Simulator、`wallpaper_lock_screen.jpg` の 1 枚）。原因は特定できていない。
  - 手順: `simctl addmedia` → 写真アプリで写真を開く → `Share` → `Use as Wallpaper` → `Add` → `Set as Wallpaper Pair`（いずれも `appId: com.apple.mobileslideshow`）。
    写真アプリの初回は `Continue` と通知の許可（SpringBoard の alert）が出る。
  - PosterBoard のデータには切り抜いた画像（`output.layerStack/portrait-layer_background.HEIC`、792×1717）が正しく作られる。
    編集画面・ロック画面・ホーム画面・通知センターのどれも黒く、再起動しても変わらない。
  - `PhotosPosterProvider` のログには `Could not create inference context`（Vision）と `Failed to create espresso context` が出る。 画像の切り抜きは成功しているため、これが黒くなる原因かは分からない。
  - 未確認: Simulator に最初から入っている写真で同じ結果になるか、CI の iOS 27.2 のランタイムで同じ結果になるか。
- Xcode 27 の runner には Simulator.app が無く、`Xcode.app/Contents/Applications/DeviceHub.app` がある。ロック画面の代わりに通知センターを使う。
- simctl で作れる端末はランタイムによって異なる。iOS 27.2 のランタイムが 2 つあり、片方では iPhone 18 Pro / 17 Pro が `Incompatible device` になった。
- watchOS Simulator の Smart Stack には、ペアリングした iPhone Simulator の Live Activity が表示されないという報告が複数ある
  （[Developer Forums](https://developer.apple.com/forums/thread/759153)）。Apple は Smart Stack 表示の確認に Xcode Preview を案内している。
- Google Play のスクリーンショットは長辺が短辺の 2 倍以下である必要があり、iOS の 1290×2796 の背景をそのまま使えない。
