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
| `bezel_iphone_18_pro_glacier_portrait.png` | 合成の端末フレーム。`figma_extract.py --bezel-out` で取得する |
| `noto_peninsula_2024.eqrp` | 能登半島地震のリプレイ（`eew_warning` / `kyoshin_monitor`） |
| `wallpaper_lock_screen.*` / `wallpaper_home_screen.*` | ロック画面・ホーム画面の壁紙。Simulator への設定方法が未解決のため未使用 |

## Figma からの抽出

- 対象は Figma `EQMonitor (PUBLIC ver)` の Section `iOS Store Screenshot`（`2147:448`）。
  ページと Figma ノード・シーンの対応は `layout.json` の `pages` に手で書き、座標と背景は抽出スクリプトが更新する。
- `figma_extract.py` は frame の塗りから背景グラデーションを再計算し、ロゴ・見出しを Figma の画像書き出しで重ねる。
  端末は「画像塗り（FIT）を持ち、子に画像塗り（FILL）の枠を持つ INSTANCE」として検出する。
- 2026-11-22 に、Figma 上の現行スクリーンショットを入力にした合成結果と Figma の frame 書き出しを比較した。
  平均差は 1/255 前後で、差は文字の輪郭のサブピクセル位置に限られる。

```sh
FIGMA_TOKEN=<token> mise exec -- uv run tool/store_screenshots/figma_extract.py --bezel-out build/store_screenshots/figma
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
- 地震詳細のデバッグボタンは debug ビルドで既定表示になるため、SharedPreferences の `debug` を false にする。
- 権限ダイアログは `$.platform.mobile.grantPermissionWhenInUse()` で許可する。iOS は端末の言語が英語のときだけ扱える（Patrol の制約）。
- ロック画面相当の画像は、Live Activity を開始して `$.platform.mobile.openNotifications()` で通知センターを開いて撮る（iOS のみ）。
- EQRP は CI で `app/assets/store_screenshot_fixtures/` へ復号してからビルドし、`rootBundle` で読む。このディレクトリは平文をコミットしない（`.gitignore`）。
  リプレイは fixture を一時ファイルへ書き出して `ReplayNotifier.open` に渡し、停止してから指定時刻へシークする。`seek` は範囲外の時刻を端へ丸めるため、EQRP の範囲外はテストを失敗させる。
- PR では fixture が無いシーンを飛ばし、タグでは `STORE_SCREENSHOT_REQUIRE_FIXTURES=true` で失敗させる。`STORE_SCREENSHOT_SCENES` で撮るシーンを絞れる。
- Release ビルドは Simulator で動かないため debug ビルドで撮り、`WidgetsApp.debugAllowBannerOverride` で DEBUG 帯を消す。
- `--build-name` には `deploy-app.yaml` と同じく pubspec の version から prerelease を落とした `x.y.z` を渡す。
  `3.1.0-beta.4` のままだと iOS の version が `3.1.0.4` になり、User-Agent が API 前段の Cloudflare Snippets（`eqmonitor-backend` の `tools/cloudflare-api-guard`）の許可形式に合わず 403 になる。
- ステータスバーは iOS が `simctl status_bar override`、Android が demo mode で 9:41 に固定する。
  Android の demo mode は起動直後に送ると反映されないことがあるため撮影ごとに送り直す。`network -e mobile hide` を送ると反映されなくなったため送らない。
- Patrol の iOS 実行には `RunnerUITests` ターゲット（`app/ios/RunnerUITests/RunnerUITests.m`、`FlutterGeneratedPluginSwiftPackage` をリンク、`User Script Sandboxing = NO`、スキームで並列実行なし）が必要。
  Android は `MainActivityTest.java` と `PatrolJUnitRunner`・Test Orchestrator を使う。

## 検証状況

2026-11-22 の PR の CI（fixture なし、Patrol 移行後）で確認した結果。

- Android: Pixel 6（API 35）で `patrol test` が完了し、`earthquake_detail` を撮影した。9:41 のステータスバー、テスト名とデバッグボタンの非表示、30 秒待機での震度分布の描画を確認した。
  ステータスバーの Wi-Fi アイコンは demo mode の指定どおりに出ていない。
- iOS: iPhone 18 Pro（iOS 27.2）で `RunnerUITests` のビルドとテストの起動までは成功した。初回は SPM の取得に約 6 分、ビルドに約 17 分かかる。
  地震詳細は上記の User-Agent の問題で 403 になった（お知らせ欄の `/v2/feeds` で確認）。`--build-name` の修正後の撮影は未確認。
- ローカルで確認済み: fixture の暗号化・復号・鍵交換（`test_fixture_crypto.sh`）、合成（`test_compose.py`）、
  シーン設定（`test_capture.py`）、Dart の静的解析、workflow の jactionlint / zizmor / ghalint / pinact。
- 未検証: リプレイのシーン（fixture 未投入）、通知センターでの Live Activity の撮影。残件は [TODO](../todo/850_store_screenshots.md)。

## 制約

- simctl には壁紙の設定とロックの操作が無い（Xcode 27 の `simctl help` で確認）。壁紙は設定アプリの UI 操作が必要と考えられる。
- Xcode 27 の runner には Simulator.app が無く、`Xcode.app/Contents/Applications/DeviceHub.app` がある。ロック画面の代わりに通知センターを使う。
- simctl で作れる端末はランタイムによって異なる。iOS 27.2 のランタイムが 2 つあり、片方では iPhone 18 Pro / 17 Pro が `Incompatible device` になった。
- watchOS Simulator の Smart Stack には、ペアリングした iPhone Simulator の Live Activity が表示されないという報告が複数ある
  （[Developer Forums](https://developer.apple.com/forums/thread/759153)）。Apple は Smart Stack 表示の確認に Xcode Preview を案内している。
- Google Play のスクリーンショットは長辺が短辺の 2 倍以下である必要があり、iOS の 1290×2796 の背景をそのまま使えない。
