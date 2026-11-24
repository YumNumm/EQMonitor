# ストア画像の自動生成の残課題

仕組みは [ストア画像の自動生成](../knowledge/store_screenshots.md)。数値は優先度。

## 900: fixture の鍵と暗号化ファイルの投入

- [x] `setup_fixture_key.sh` で鍵を作り、`.env.json` と `fixtures/recipients.txt` をコミットする。
- [x] `noto_peninsula_2024.eqrp` と壁紙（`wallpaper_lock_screen.jpg`）を `encrypt_fixture.sh` で暗号化してコミットする。
- [x] 端末フレーム（`bezel_iphone_18_pro_glacier_portrait.png`）を暗号化してコミットする。
- 完了条件: タグの workflow で `decrypt_fixtures.sh` が全 fixture を復号できる。

## 850: Simulator / Emulator での撮影の確認

- [x] Patrol 移行後の `capture-android` が `patrol test` の完了まで進むことを確認する。
- [ ] `capture-ios` が CI で `patrol test` の完了まで進むことを確認する（手元の Mac では 2026-11-23 に完了を確認済み）。
- [x] iOS の 403 の原因を特定する。prerelease の version が iOS で `3.1.0.4` になり、User-Agent が Cloudflare Snippets の許可形式に合わなかった。iOS だけ `--build-name` に `x.y.z` を渡す。エラー表示自体の改善は #2059。
- [ ] Android のステータスバーに Wi-Fi アイコンが出ない原因を調べる（demo mode の `network` コマンドが反映されていない）。
- [ ] `eew_warning`（16:11:08）・`kyoshin_monitor`（16:10:21）が Figma の 01・04 と同じ状態（EEW カード、推定震度、ボトムシート）になるか確認し、時刻と `settle_milliseconds` を調整する。
  手元の Mac では両シーンとも EEW カードと推定震度・観測点が表示され、ボトムシートは最小の高さで撮れた（2026-11-23）。Figma との照合が残る。
- [x] `earthquake_detail` で戻るボタン以外のデバッグ用アイコンが出ないことを確認する。
- 完了条件: 合成済みの 4 ページが Figma の構成と一致する。

## 800: 通知センターの撮影と壁紙

- [ ] Patrol の `openNotifications()` で開いた通知センターに Live Activity が表示され、host 側の `simctl io screenshot` で撮れることを CI で確認する（手元の Mac では確認済み）。
- [ ] 通知センターの日付が英語（`Sat Jan 1`）になる。Patrol の操作に英語の端末が必要なため、日本語表示にする手段を決める。
- [ ] 通知センターに Dynamic Island が写る回と写らない回がある。どちらに揃えるか決めて固定する。
- [x] 壁紙の設定手段を決める。PosterBoard の保存領域へ直接書き込む（`set_ios_wallpaper.sh`）。手元の iOS 27.0 で通知センターに表示された。
- [ ] CI の iOS 27.2 のランタイムで壁紙が設定されるか確認する。保存領域の形式が違えば警告だけが出て既定の壁紙になる。
- 完了条件: 03 通知ページが壁紙付きの通知センターと Live Activity で合成される。

## 700: Apple Watch Ultra 4 の Live Activity

- [x] Watch の Simulator のスマートスタックで Live Activity を撮る（`--watch-device`、手元の iOS 27.2 / watchOS 27.2 で確認）。
- [x] 03 通知ページに Apple Watch Ultra 4 のフレームと画面の配置を追加する（配置は `layout.json` の `devices` に手で書いた仮のもの）。
- [ ] Watch のバンドを黒のミラネーゼループにする。Apple の配布物に無いため、素材の入手元を決める。
- [ ] Watch の文字盤をアナログにする。
- [x] Liquid Glass を最も不透明な設定にして撮る。
- [ ] `capture-ios` で watchOS のランタイムの用意とペアの作成を行い、CI でも撮れるようにする。
- Watch の時刻・日付は固定できない（`simctl status_bar` が watchOS 非対応）。撮影時のものが写る。点滅と到達までの秒数は固定済み。

## 650: iPhone Duo

- [x] 外側・内側の画面で撮り、背景と枠を作って合成する（`layout_duo_outer.json` / `layout_duo_inner.json`、2026-11-24 に手元で生成）。
- [x] App Store Connect に iPhone Duo のスクリーンショットを登録する（2026-11-24、iOS 3.1.0・日本語、外側 4 枚・内側 3 枚）。2027 年 4 月から iOS 27.1 SDK 以降で必須。
- [ ] 内側（横向き）で通知センターを撮る。`openNotifications()` と `closeHeadsUpNotification()` が横向きで効かなかった。
- [ ] 枠を Apple Design Resources の `Bezel-iPhone-Duo.dmg` に差し替えるか決める（使用許諾への同意が必要）。
- [ ] Figma に Duo 用のフレームを作るか決める。現在は既存の背景から `derive_background.py` で作っている。
- [ ] `capture-ios` に Duo の撮影を足す。

## 640: iPad とプロダクトページの画像

- [x] iPad 13 インチの 3 枚を App Store Connect に登録する（2026-11-24、12.9 インチの枠にも縮小版を登録）。
- [ ] iPad と Duo の内側で通知センターを撮る。重大な通知のバナーが閉じず、通知センターも開かなかった。
- [ ] iPad のステータスバーの日付を固定する（`--time` に ISO の日時を渡すと日付も変わるが、iPhone のロック画面の日付にも影響しうる）。
- [ ] プロダクトページのヘッダと検索結果の画像（`creative_assets.py`）を App Store Connect に登録する。Figma のデザインは無い。

## 600: Android とストアへの反映

- [x] Google Play 用の合成（長辺が短辺の 2 倍以下、1290×2560）を追加する。Figma のデザインは無く、iOS の背景の上側を切り出している。
- [ ] Google Play の電話のスクリーンショットを差し替える（合成は済み、未登録）。手元には Google Play の API の認証情報が無く、デプロイ用のサービスアカウントは GitHub Actions の Workload Identity からしか使っていない。
- [ ] CI の Android の撮影を Pixel 11 Pro 相当（1280×2856）にする。現在は `pixel_6` / API 35。runner の cmdline-tools 16.0 に `pixel_10_pro` があるかは未確認。
- [ ] App Store Connect / Google Play へのアップロードを自動化するか決める。現在は artifact の生成まで。
  2026-11-24 に iOS 3.1.0・日本語の iPhone 6.7 / 6.5 / 5.5 インチの各 4 枚を、手元で合成した画像（通知＋Apple Watch、履歴一覧＋詳細を含む版）へ App Store Connect API で手動で差し替えた。iPad は古いまま。
  6.5 インチは 1242×2688 へ縮小、5.5 インチは高さ 2208 へ縮小して左右に背景の端の色を延ばした（1242×2208）。この変換は `compose.py` には入っていない。
