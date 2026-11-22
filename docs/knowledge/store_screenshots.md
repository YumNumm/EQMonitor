# ストア画像の自動生成

2026-11-22 作成。正本は `tool/store_screenshots/` と `.github/workflows/store-screenshots.yaml`。
撮影は PR の CI で地震詳細まで確認済み。リプレイとロック画面のシーンは未確認（下記「検証状況」）。

## 全体の流れ

1. 撮影（`capture.py`）: `lib/main_store_screenshot.dart` を入口にした debug ビルドを Simulator / Emulator で起動し、
   `scenes.json` のシーンを順に表示して host 側から画面全体を撮る。
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

- host がアプリの Documents 配下 `store_screenshot/` へ `session.json` と fixture を置いてから起動する
  （iOS は `simctl get_app_container`、Android は `run-as` と `app_flutter/`）。
- アプリはシーンを表示して `ready/<scene>` を書き、host は撮影後に `captured/<scene>` を書く。全シーン後に `done`、例外時は `failed` に内容を書く。
- `session.json` の `preferences` は `SharedPreferencesKey` に存在するキーだけを受け付け、起動前に書き込む。
  オンボーディング・新機能案内・各種お知らせはここで既読にする。
- Release ビルドは Simulator で動かないため両 OS とも debug ビルドを使い、`WidgetsApp.debugAllowBannerOverride` で DEBUG 帯を消す。
- リプレイは fixture の file URI を `ReplayNotifier.open` に渡し、停止してから指定時刻へシークする。`seek` は範囲外の時刻を端へ丸めるため、EQRP の範囲外を指定したシーンは失敗させる。`scenes.json` の時刻は実時刻（JST の場合は `+09:00` 付き）で書く。EQRP の時刻の扱いは [リプレイ再生](earthquake_replay.md) を参照する。
- Live Activity はデバッグ用プリセットを撮影時刻基準で組み立てて開始する。テスト用の eventId は `【テスト】` 表示になるため使わない。
- ステータスバーは iOS が `simctl status_bar override`、Android が demo mode で 9:41 に固定する。
  Android の demo mode は起動直後に送ると反映されないことがあるため撮影ごとに送り直す。`network -e mobile hide` を送ると反映されなくなったため送らない。
- ロック画面のシーン（`lock_screen_live_activity`）は `experimental` で、`--scenes` で指名したときだけ撮影する。
  既定では撮影しないため、03 通知ページは合成されない。
- 撮影に失敗したシーンは `failure-<scene>.png` を残す。アプリのログからエラー関連の行（`http-error`、`Status: 4xx/5xx` とその直後の行）だけをジョブログへ出す。
  iOS の Flutter の出力は stdout ではなく unified logging に出るため `simctl spawn log show` で読む。

## 検証状況

2026-11-22 の PR の CI（fixture なし）で確認した結果。

- Android: Pixel 6（API 35）で `earthquake_detail` を撮影。震度分布の描画には 10 秒では足りず、30 秒の待機で表示された。
- iOS: iPhone 18 Pro（iOS 27.2）で `earthquake_detail` を撮影。ただし画面は 403 のエラー表示（`FORBIDDEN`）で、同じ API の Android とは結果が異なる。原因は調査中。
- ローカルで確認済み: fixture の暗号化・復号・鍵交換（`test_fixture_crypto.sh`）、合成（`test_compose.py`）、
  シーン設定（`test_capture.py`）、Dart の静的解析、workflow の jactionlint / zizmor / ghalint / pinact。
- 未検証: リプレイのシーン（fixture 未投入）、ロック画面の撮影。残件は [TODO](../todo/850_store_screenshots.md)。

## 制約

- simctl には壁紙の設定とロックの操作が無い（Xcode 27 の `simctl help` で確認）。壁紙は設定アプリの UI 操作が必要と考えられる。
- Xcode 27 の runner には Simulator.app が無く、`Xcode.app/Contents/Applications/DeviceHub.app` がある。
  ロックはこのアプリのメニュー操作を試す実装だが、メニュー名と runner の Accessibility 権限は未確認。
- simctl で作れる端末はランタイムによって異なる。iOS 27.2 のランタイムが 2 つあり、片方では iPhone 18 Pro / 17 Pro が `Incompatible device` になった。
- watchOS Simulator の Smart Stack には、ペアリングした iPhone Simulator の Live Activity が表示されないという報告が複数ある
  （[Developer Forums](https://developer.apple.com/forums/thread/759153)）。Apple は Smart Stack 表示の確認に Xcode Preview を案内している。
- Google Play のスクリーンショットは長辺が短辺の 2 倍以下である必要があり、iOS の 1290×2796 の背景をそのまま使えない。
