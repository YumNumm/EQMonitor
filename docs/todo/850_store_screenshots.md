# ストア画像の自動生成の残課題

仕組みは [ストア画像の自動生成](../knowledge/store_screenshots.md)。数値は優先度。

## 900: fixture の鍵と暗号化ファイルの投入

- [ ] `setup_fixture_key.sh` で鍵を作り、`.env.json` と `fixtures/recipients.txt` をコミットする。
- [ ] 端末フレーム・`noto_peninsula_2024.eqrp`・壁紙を `encrypt_fixture.sh` で暗号化してコミットする。
- 完了条件: タグの workflow で `decrypt_fixtures.sh` が全 fixture を復号できる。

## 850: Simulator / Emulator での撮影の確認

- [x] Patrol 移行後の `capture-android` が `patrol test` の完了まで進むことを確認する。
- [ ] `capture-ios` が `patrol test` の完了まで進むことを確認する（`RunnerUITests` のビルドとテストの起動は確認済み）。
- [x] iOS の 403 の原因を特定する。prerelease の version が iOS で `3.1.0.4` になり、User-Agent が Cloudflare Snippets の許可形式に合わなかった。`--build-name` に `x.y.z` を渡す。エラー表示自体の改善は #2059。
- [ ] Android のステータスバーに Wi-Fi アイコンが出ない原因を調べる（demo mode の `network` コマンドが反映されていない）。
- [ ] `eew_warning`（16:11:08）・`kyoshin_monitor`（16:10:21）が Figma の 01・04 と同じ状態（EEW カード、推定震度、ボトムシート）になるか確認し、時刻と `settle_milliseconds` を調整する。
- [ ] `earthquake_detail` で戻るボタン以外のデバッグ用アイコンが出ないことを確認する。
- 完了条件: 合成済みの 4 ページが Figma の構成と一致する。

## 800: 通知センターの撮影と壁紙

- [ ] Patrol の `openNotifications()` で開いた通知センターに Live Activity が表示され、host 側の `simctl io screenshot` で撮れることを CI で確認する。
- [ ] 壁紙の設定手段を決める。simctl に手段が無いため、`simctl addmedia` で写真を入れ、Patrol のネイティブ操作で設定アプリから設定する方法を検討する。
- 完了条件: 03 通知ページが壁紙付きの通知センターと Live Activity で合成される。

## 700: Apple Watch Ultra 4 の Live Activity

- [ ] Figma の 03 通知ページに Apple Watch Ultra 4 のフレームと画面の配置を追加する（現在のファイルに Watch のノードは無い）。
- [ ] Smart Stack の表示を作る。watchOS Simulator は Live Activity を表示しない報告があるため、`EewSmallActivityView` を Ultra の `.small` 寸法でオフスクリーン描画する方式を優先して検討する。
- [ ] `figma_extract.py` と `compose.py` を 1 ページ複数端末に対応させる。

## 600: Android とストアへの反映

- [ ] Google Play 用のデザイン（長辺が短辺の 2 倍以下）を Figma に作り、Android の合成を追加する。
- [ ] App Store Connect / Google Play へのアップロードを自動化するか決める。現在は artifact の生成まで。
