# ストア画像の自動生成の残課題

仕組みは [ストア画像の自動生成](../knowledge/store_screenshots.md)。数値は優先度。

## 900: fixture の鍵と暗号化ファイルの投入

- [ ] `setup_fixture_key.sh` で鍵を作り、`.env.json` と `fixtures/recipients.txt` をコミットする。
- [ ] 端末フレーム・`noto_peninsula_2024.eqrp`・壁紙を `encrypt_fixture.sh` で暗号化してコミットする。
- 完了条件: タグの workflow で `decrypt_fixtures.sh` が全 fixture を復号できる。

## 850: Simulator / Emulator での撮影の確認

- [ ] iOS の `earthquake_detail` が 403（応答本文 `{"error": "FORBIDDEN"}` と推察）になる原因を特定する。Android では同じ API が表示される。エラー表示自体の改善は #2059。
- [ ] `eew_warning`（16:11:08）・`kyoshin_monitor`（16:10:21）が Figma の 01・04 と同じ状態（EEW カード、推定震度、ボトムシート）になるか確認し、時刻と `settle_milliseconds` を調整する。
- [ ] `earthquake_detail` で戻るボタン以外のデバッグ用アイコンが出ないことを確認する。
- 完了条件: 合成済みの 4 ページが Figma の構成と一致する。

## 800: ロック画面の撮影と壁紙

- [ ] ロックの手段を決める。Xcode 27 では Simulator.app が DeviceHub.app に置き換わり、simctl にもロックが無い。DeviceHub.app のメニュー操作（Accessibility 権限が必要）か、XCUITest の `pressLockButton` を検討する。決まったら `lock_screen_live_activity` の `experimental` を外す。
- [ ] 壁紙の設定手段を決める。simctl に手段が無いため、設定アプリの UI 操作または別方式の調査が必要。
- 完了条件: 03 通知ページが壁紙付きのロック画面と Live Activity で合成される。

## 700: Apple Watch Ultra 4 の Live Activity

- [ ] Figma の 03 通知ページに Apple Watch Ultra 4 のフレームと画面の配置を追加する（現在のファイルに Watch のノードは無い）。
- [ ] Smart Stack の表示を作る。watchOS Simulator は Live Activity を表示しない報告があるため、`EewSmallActivityView` を Ultra の `.small` 寸法でオフスクリーン描画する方式を優先して検討する。
- [ ] `figma_extract.py` と `compose.py` を 1 ページ複数端末に対応させる。

## 600: Android とストアへの反映

- [ ] Google Play 用のデザイン（長辺が短辺の 2 倍以下）を Figma に作り、Android の合成を追加する。
- [ ] App Store Connect / Google Play へのアップロードを自動化するか決める。現在は artifact の生成まで。
