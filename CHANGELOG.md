# Changelog

## [3.1.0](https://github.com/YumNumm/EQMonitor/compare/v3.0.6...v3.1.0) (2026-11-24)


### Features

* Androidにdevアイコンを追加しベータ配布ビルドで使う ([a7e100a](https://github.com/YumNumm/EQMonitor/commit/a7e100a8a47e27e0ef12cf1c4e30bb388e706b7f))
* Androidのdevアイコンを iOS の AppIcon-dev の書き出しに差し替え ([bc8a1f1](https://github.com/YumNumm/EQMonitor/commit/bc8a1f13021a35492ed31bb40a4a5386d6960b9c))
* Androidのdevアイコンを全面背景のadaptive iconに作り直す ([4f517b5](https://github.com/YumNumm/EQMonitor/commit/4f517b522869ba838675493ca4b07372cc4e5071))
* background復帰時に時刻を測り直しWebSocketをPingで確認する ([4088439](https://github.com/YumNumm/EQMonitor/commit/40884391f2570091220583f98ebba490a1f1c521))
* betaタグのAndroidビルドもdevアイコン・常時無料版にする ([103d78b](https://github.com/YumNumm/EQMonitor/commit/103d78b71f53bcaf6b05a472339dca6bd5e8f94c))
* betaタグのiOSビルドでdevアイコンを使う ([b90d3fe](https://github.com/YumNumm/EQMonitor/commit/b90d3fe296a6a21bb0c958f8d26c4bce8465f3b6))
* EEWカードのヘッダーの最大震度をMAX＋震度アイコンにする ([1bf8d2b](https://github.com/YumNumm/EQMonitor/commit/1bf8d2bba5e73162a07af57bf5209e56ae7e879a))
* EEWカードのヘッダーの最大震度をMAX＋震度アイコンにする ([15f0b18](https://github.com/YumNumm/EQMonitor/commit/15f0b18fbd65fc80da4a11189d98af25b7369393))
* EEWカードの最大震度アイコンの白枠を外す ([8156aaf](https://github.com/YumNumm/EQMonitor/commit/8156aaf57969a97b856a99ba14ed819d818ccf8e))
* EEWカードをLive ActivityのLock Screen表示に合わせる ([f53d60a](https://github.com/YumNumm/EQMonitor/commit/f53d60a3e74ebcaeef34a791f984dda18a82b964))
* EEWカードをLive ActivityのLock Screen表示に合わせる ([50029c8](https://github.com/YumNumm/EQMonitor/commit/50029c8f6d2f871f26d6acb6664a5b662d6ad6fe))
* EEWと結合した揺れ検知の範囲を自動フォーカスに含める ([f7fe509](https://github.com/YumNumm/EQMonitor/commit/f7fe50985ff5e4af3d2e4a41403e9df91693f64c))
* EEWの表示終了に最終報から30秒経過の条件を追加 ([933d961](https://github.com/YumNumm/EQMonitor/commit/933d961ba336ea2db2d3552235359f9e1c8f99dd))
* EEW中も揺れ検知を表示するデバッグ設定を追加 ([5517c87](https://github.com/YumNumm/EQMonitor/commit/5517c87b656535fa7fb59ada1ed6be39231c2ec2))
* EQRP の書き出しを追加する ([8d93b84](https://github.com/YumNumm/EQMonitor/commit/8d93b84b98d1ce005615bff834c2cd6b89e500e7))
* EQRPの時刻をJSTの壁時計として読み込む ([c212db5](https://github.com/YumNumm/EQMonitor/commit/c212db5637f18b47f1ebd5b696f72f79ce19c51b))
* Figma からストア画像の背景と端末フレームの配置を抽出する ([1c8c71e](https://github.com/YumNumm/EQMonitor/commit/1c8c71e0ddb8d88db58f882258c38ecdd082149d))
* iOS 地震履歴 Widget の表示と取得を作り直す ([6fcd918](https://github.com/YumNumm/EQMonitor/commit/6fcd918bb9729216cbba20579ebd56c3bb0f0d55))
* iPad 13 インチとプロダクトページのヘッダ・検索結果の画像を作れるようにする ([935fe8e](https://github.com/YumNumm/EQMonitor/commit/935fe8ef525d64b6429ca7811286a2aeb3021051))
* iPhone Duo と Pixel 11 Pro のストア画像を撮影・合成できるようにする ([17251fe](https://github.com/YumNumm/EQMonitor/commit/17251feb77363f345c2ad4fd7b9d30ad8e27ca0d))
* Live Activity の到達までの秒数と点滅を固定できるようにする ([7036272](https://github.com/YumNumm/EQMonitor/commit/7036272719f21073ab12ecf94095ebb8bb62fd45))
* Live Activityの点滅を0.5秒おきにし到達カウントダウンを0.1秒単位にする ([1f6f18c](https://github.com/YumNumm/EQMonitor/commit/1f6f18cf2eef1faccd57b6ce6506d2cde3d9844a))
* Live Activityの点滅を0.5秒おきにし到達カウントダウンを0.1秒単位にする ([22ac2d7](https://github.com/YumNumm/EQMonitor/commit/22ac2d716f68319166312cfedd822114b425ef5a))
* MapLibre を 0.4.0 へ移行する ([e255656](https://github.com/YumNumm/EQMonitor/commit/e2556569db333ac83980bf83142647aaa0f9e6b7))
* OSのファイルで開くから.eqrpを再生できるようにする ([12cb03e](https://github.com/YumNumm/EQMonitor/commit/12cb03eebee8de74940a9626aa8b81659e0ec35e))
* PaywallのPro機能一覧から揺れ検知の通知を外す ([a592ad1](https://github.com/YumNumm/EQMonitor/commit/a592ad1912c370f31d8991117308b0a87c2f6cfd))
* Proの機能一覧に揺れ検知の通知を追加し、購入画面の表示を調整する ([ab09dfe](https://github.com/YumNumm/EQMonitor/commit/ab09dfeaf7f534cf7062ee53ad155ef130c70ea8))
* Proの機能一覧に揺れ検知の通知を追加し、購入画面の表示を調整する ([46cc13b](https://github.com/YumNumm/EQMonitor/commit/46cc13b381e8dc7e67cdc978eb87ac6164f31f36))
* Simulator と Emulator でストア画像のシーンを撮影するスクリプトを追加する ([f2d14a6](https://github.com/YumNumm/EQMonitor/commit/f2d14a68a42415d970bfe114116d99a3d7e80988))
* WebSocket未接続中にEEWと地震履歴をETag付きで定期取得する ([399975b](https://github.com/YumNumm/EQMonitor/commit/399975bebf39d50ce175ea81770f8d45ccae3795))
* アップデート後のホームに新機能の案内を表示する ([3feed9e](https://github.com/YumNumm/EQMonitor/commit/3feed9e764966c9621058e275303fd3a023d0e1e))
* カスタム設定に揺れ検知 Beta の案内カードと注意事項への導線を追加 ([fc3bb27](https://github.com/YumNumm/EQMonitor/commit/fc3bb278b0a281d0d43b57352420bde711ce87c0))
* グラデーション配色の凡例を計測震度のスケールで表示 ([cfec6ed](https://github.com/YumNumm/EQMonitor/commit/cfec6ede5e395dd06c3a7873a48bc3005ad67e6a))
* ストア画像の 2 枚目を履歴一覧と詳細の 2 台重ねにし、詳細の地震を 20260823020050 にする ([8edb033](https://github.com/YumNumm/EQMonitor/commit/8edb033f93a86a7cde4f47caef15bbee400fbc5a))
* ストア画像の EEW のシーンで現在地を切り替え、警報と到達までの時間を同時に表示する ([f8efb2b](https://github.com/YumNumm/EQMonitor/commit/f8efb2bac92cf2e175bd2f6adb516a54a524c7a3))
* ストア画像の fixture を age で暗号化・復号するスクリプトを追加する ([5a757f6](https://github.com/YumNumm/EQMonitor/commit/5a757f64f13bb63a299a751f304fce90159ac2c0))
* ストア画像のシーンを Patrol テストで表示する ([9e55253](https://github.com/YumNumm/EQMonitor/commit/9e5525381b84b325edf0410801d22670da63c11f))
* ストア画像のフレームを黒にし、通知のページに Apple Watch を合成する ([d863a30](https://github.com/YumNumm/EQMonitor/commit/d863a30a0fd53be25717a33ca1be26e3a9e1b430))
* ストア画像の撮影で壁紙を設定し、現在地の予想震度と到達までの時間を表示する ([8c503b9](https://github.com/YumNumm/EQMonitor/commit/8c503b9902529f27b967f7120c6271f0efc244ac))
* ストア画像の通知センターに緊急地震速報の通知を表示する ([359a479](https://github.com/YumNumm/EQMonitor/commit/359a47979ebd4b7f8c05319fa28d7e92f4343d73))
* ストア画像を Simulator / Emulator で撮影し Figma の背景と合成する仕組みを追加する ([f118aa6](https://github.com/YumNumm/EQMonitor/commit/f118aa61fe07b1f4f0c9925cf02c349b17ff17a7))
* ストア画像を固定表示で撮り、通知と履歴のページを入れ替える ([52686cd](https://github.com/YumNumm/EQMonitor/commit/52686cd496dc9811e27fa705a2a53d53436c009c))
* ストア画像を日本語の端末で撮り、Apple Watch の Live Activity と点灯中のハイライトを撮る ([5ced2d5](https://github.com/YumNumm/EQMonitor/commit/5ced2d5b0a4813f54155e58ec2d38d3c374b8e17))
* ストア画像撮影用のエントリポイントとシーン制御を追加する ([2bff083](https://github.com/YumNumm/EQMonitor/commit/2bff083cdd89e19733c69063f481e68793496123))
* デバッグ画面から EQRP リプレイファイルを作成する ([4dfe963](https://github.com/YumNumm/EQMonitor/commit/4dfe963bcdb27fc5c76a2dba1122131e07b284fe))
* デバッグ画面にリプレイファイルの作成画面を追加する ([3ec96b8](https://github.com/YumNumm/EQMonitor/commit/3ec96b8a402b6aae9cb6c1b6d7d65c30734894a6))
* デバッグ画面をビルド番号の10回タップと同意で有効にし、Admin以外は制限付きにする ([b673c1f](https://github.com/YumNumm/EQMonitor/commit/b673c1f794fcbe9f6994a56a4a8f5fe979703246))
* トグルと画面遷移以外のボタンにハプティックフィードバックを追加 ([48b43a8](https://github.com/YumNumm/EQMonitor/commit/48b43a80f7048e8e660f8cf1c7dc21af0dc5b133))
* フォーカス範囲を赤の点線で表示するデバッグレイヤーを追加 ([087cbd0](https://github.com/YumNumm/EQMonitor/commit/087cbd00c088787fb2b0b70e12e82232f0779af1))
* ベータ提供中の機能に付ける BETA チップを追加 ([eb3fc0f](https://github.com/YumNumm/EQMonitor/commit/eb3fc0f26441c21500105123ebdc1702b2677635))
* ベータ配布ビルドを常に無料版として扱う ([0fc0e2a](https://github.com/YumNumm/EQMonitor/commit/0fc0e2a8a540dc46958bbb701d3b53b76c1f05f3))
* ホーム・地域選択・震央分布・震度履歴にハプティックを追加 ([39e2902](https://github.com/YumNumm/EQMonitor/commit/39e29026603e96dadc032236d12f13953a394946))
* ホームに端末登録とトークン同期の状態を表示しない ([dd2afe9](https://github.com/YumNumm/EQMonitor/commit/dd2afe988188e81cdebde3c13b25dcc84b697c8b))
* ホームのシートを操作していない間は 1 つ目の EEW カードの高さに合わせる ([e6b6cef](https://github.com/YumNumm/EQMonitor/commit/e6b6cef9e75a3b1523ebf33029760e333cb5c3bf))
* リプレイ・EEW・オンボーディングほかの操作にハプティックを追加 ([0d85db9](https://github.com/YumNumm/EQMonitor/commit/0d85db9b570bddc8823b03e4a28ff63a20269a42))
* リプレイのフォルダを自由に作成・名前変更・移動・削除できるようにする ([1e62a7a](https://github.com/YumNumm/EQMonitor/commit/1e62a7ac8411a468efa7ce627196f443d77cbe22))
* リプレイファイルの読み込み層を追加する ([724ab13](https://github.com/YumNumm/EQMonitor/commit/724ab131959973346f467660831851cccf7bf250))
* リプレイファイルを年/月のフォルダで保存・再生・管理できるようにする ([013e77b](https://github.com/YumNumm/EQMonitor/commit/013e77bffa929aff1a7986c2c8f56d9320d75500))
* リプレイファイルを年/月のフォルダへ好きな名前で保存できるようにする ([cb6cc4a](https://github.com/YumNumm/EQMonitor/commit/cb6cc4a4baadeff38fb63cfd1fa9944b88986f05))
* リプレイファイルを開く画面とデバッグメニューの導線を追加する ([fd1fe8d](https://github.com/YumNumm/EQMonitor/commit/fd1fe8da40965b756b4b85c6ed7e0ec880a0635d))
* リプレイ再生を再生時刻基準で進める ([19a1ec5](https://github.com/YumNumm/EQMonitor/commit/19a1ec58d7607f99b57e5ec7c833f19ebaaa0187))
* リプレイ再生中も端末内の揺れ検知を動かす ([278f655](https://github.com/YumNumm/EQMonitor/commit/278f65514d1801f17dd99ba7a53e2daf80c08a5c))
* リリースごとの新機能の案内の定義と選択ロジックを追加 ([2be385d](https://github.com/YumNumm/EQMonitor/commit/2be385da1e5df8b42580359c06581243d0bea0dd))
* ローカルの推計震度 DEM PMTiles を確認するデバッグページを追加 ([e752680](https://github.com/YumNumm/EQMonitor/commit/e752680a9a2fa4fa0f54fbb4720fdb40548962e5))
* 保存済みのリプレイをフォルダから選んで再生・追加・複数削除できる画面を追加する ([dcde8e6](https://github.com/YumNumm/EQMonitor/commit/dcde8e6face098cd1772bd876f08836905b91066))
* 共通コンポーネントのトグル・選択・操作にハプティックを追加 ([c61d6dc](https://github.com/YumNumm/EQMonitor/commit/c61d6dc8fef5f4062f83fb1117c57968bafa4605))
* 再生中の表示を過去の地震を再生中に切り替えて操作できるようにする ([5e8b318](https://github.com/YumNumm/EQMonitor/commit/5e8b318e7b26e835b1c38b2b44c6f3d710fb8626))
* 区域アイコンの表示と切り替え縮尺を設定シートから変更できるようにする ([94c571b](https://github.com/YumNumm/EQMonitor/commit/94c571baf755dc525719609b773472b6809c42ed))
* 区域アイコン用のアンカーレイヤーをベースマップに追加する ([c1a76f1](https://github.com/YumNumm/EQMonitor/commit/c1a76f1ae4c46b0406e3fe73f858e915fcb7b4bf))
* 地図に重ねるデバッグ表示とマップレイヤー設定のデバッグ項目を追加 ([369293e](https://github.com/YumNumm/EQMonitor/commit/369293eef5a3f3ee266977dabea71e6e2243acd0))
* 地震履歴 Widget の表示と取得を作り直す ([b3a4bdf](https://github.com/YumNumm/EQMonitor/commit/b3a4bdfac2bb55db9898098abe04e157f807ae47))
* 地震履歴とEEW履歴からリプレイファイルの作成へ進めるようにする ([ce34954](https://github.com/YumNumm/EQMonitor/commit/ce349541209765b51c03dea994d3caf8fe5113a9))
* 地震履歴のトグル・操作ボタンにハプティックを追加 ([b69be7f](https://github.com/YumNumm/EQMonitor/commit/b69be7f5fb49d45a6c935c592cceb34dac520537))
* 地震履歴の詳細から強震モニタの過去画像を再生 ([55db57d](https://github.com/YumNumm/EQMonitor/commit/55db57d1adffd49434401cc6bed54482e83495c6))
* 地震履歴の詳細から強震モニタを再生する導線と展開式の操作パネルを追加 ([e9e1068](https://github.com/YumNumm/EQMonitor/commit/e9e10688453d116387a78b0640000244261cce98))
* 地震履歴詳細の細分区域・市区町村に震度アイコンを表示する ([0a5560d](https://github.com/YumNumm/EQMonitor/commit/0a5560d8e180b03893fe704346585ed67437faeb))
* 地震履歴詳細の観測点に観測点名ラベルを表示する ([59ff013](https://github.com/YumNumm/EQMonitor/commit/59ff013d7a89a4c3333fb560635db1ee4b69d203))
* 強震モニタの観測点に観測点名ラベルを表示する設定を追加する ([67fb58c](https://github.com/YumNumm/EQMonitor/commit/67fb58c9d131bc5c32d599331ac3ce2b9d6ee12b))
* 強震モニタの過去画像をリプレイの供給元に追加 ([8a69a63](https://github.com/YumNumm/EQMonitor/commit/8a69a6329d995d8f24991729d3c2831c83f4b8f4))
* 強震モニタ画像と EEW から EQRP を作成して保存する ([d35276a](https://github.com/YumNumm/EQMonitor/commit/d35276a20a59f4d2b1e7e708d8c00563e2bd4012))
* 強震モニタ配色の凡例に計測震度3.5以上のスケールを表示 ([6db2bb8](https://github.com/YumNumm/EQMonitor/commit/6db2bb8aed2e6f62b9f720834918b81bff2de153))
* 微弱な揺れの通知を非推奨と表示し、選んだときに確認する ([296f463](https://github.com/YumNumm/EQMonitor/commit/296f46355a6989dfdd8100554701780bf7108a9f))
* 必須でない起動ステップの失敗を記録して継続するクラスを追加 ([4a5b06e](https://github.com/YumNumm/EQMonitor/commit/4a5b06e8da0a9fb20a19088828c8b34dbec3561c))
* 推計震度の 0.1 単位表示に合わせた凡例を表示 ([a9099ef](https://github.com/YumNumm/EQMonitor/commit/a9099efcd6e6ed2948413ea5ed93ecbb196450b5))
* 推計震度の0.1単位表示に強震モニタ配色を追加 ([380d21a](https://github.com/YumNumm/EQMonitor/commit/380d21ae6f4a6e184ad23cb989a2f878c57e6837))
* 推計震度のグラデーションをテーマ色にし、震度階級のプレビューに震度を表示 ([71a198e](https://github.com/YumNumm/EQMonitor/commit/71a198e3c1c20617d9deec492ea4827d0ae34ea2))
* 推計震度のグラデーション配色をテーマの推計震度色から作る ([0bc42be](https://github.com/YumNumm/EQMonitor/commit/0bc42be8b6a2c402abec11b054542295b79611d9))
* 推計震度の表示設定をカードへ移し、強震モニタ配色を追加 ([5d11219](https://github.com/YumNumm/EQMonitor/commit/5d11219927a503f39ac5cb31745eea594cf40d01))
* 推計震度の表示設定を推計震度カードへ移動 ([a978f3a](https://github.com/YumNumm/EQMonitor/commit/a978f3ae6645b453af7a510a09a174e4e41d3d59))
* 推計震度を raster-dem で描画し 0.1 単位表示へ切り替え可能にする ([af3120b](https://github.com/YumNumm/EQMonitor/commit/af3120b6d901727d869fceee32293c864d1fdfb0))
* 推計震度分布図を raster-dem で描画し、計測震度 0.1 単位表示へ切り替え可能にする ([d4fa377](https://github.com/YumNumm/EQMonitor/commit/d4fa37734d91bc13922ffd921b3bbc084623bc7e))
* 揺れ検知エンジンが観測点ごとの表示用の状態を返す ([40c648e](https://github.com/YumNumm/EQMonitor/commit/40c648e84b5eb1d902ec463cf87d18f56adf16d2))
* 揺れ検知カードから地点数と強さの表示を外し、余白を広げる ([e4fa0be](https://github.com/YumNumm/EQMonitor/commit/e4fa0be5629f846725702187dc2b6a86a48b5cb1))
* 揺れ検知カードの再設計・地図のデバッグ表示・観測点のイベント終了までの保持 ([71f3db2](https://github.com/YumNumm/EQMonitor/commit/71f3db20ffd8ee064be6168f73b4a54f3c5d9f47))
* 揺れ検知カードをEEWカードと同じ構成にし、都道府県と地域を表示する ([c9cebb6](https://github.com/YumNumm/EQMonitor/commit/c9cebb6ce42e7eed2ea3d022b03443d4d5f6c861))
* 揺れ検知のグリッドを地図上で正方形の0.5°幅に変更 ([4fa63c1](https://github.com/YumNumm/EQMonitor/commit/4fa63c1c3ef6584410df8710bde422269f9e608b))
* 揺れ検知のグリッドを地図上で正方形の0.5°幅に変更 ([f9f5dc3](https://github.com/YumNumm/EQMonitor/commit/f9f5dc34b231359f317c58b4d4357f046d8fa4a5))
* 揺れ検知のデバッグ用レポートを追加 ([311ed79](https://github.com/YumNumm/EQMonitor/commit/311ed79ade6b94f3253b8c46610aa2f0613bd619))
* 揺れ検知の最小レベルの選択肢に震度の目安を表示する ([549c94a](https://github.com/YumNumm/EQMonitor/commit/549c94a66f38f7e703bd21750139bc8cb1690b22))
* 揺れ検知の範囲を全域・地方単位で要約する ([034365f](https://github.com/YumNumm/EQMonitor/commit/034365fe06e1504f7a9c8f1a9a1ea2793b1e2b30))
* 揺れ検知の通知のPro制限を撤廃 ([722f2dc](https://github.com/YumNumm/EQMonitor/commit/722f2dcdf9e38def255c60077c913129b4a6734e))
* 揺れ検知の通知のPro制限を撤廃 ([eb0493d](https://github.com/YumNumm/EQMonitor/commit/eb0493da467fe5e705f54ebfb029b0b07fa03934))
* 揺れ検知レベルの境界を震度階級に合わせる ([ee1fe5d](https://github.com/YumNumm/EQMonitor/commit/ee1fe5d7e186cdc8c290c75c7ad8a489e5358b24))
* 揺れ検知レベルを配信側に合わせ、最小レベルに震度の目安と非推奨を表示する ([68f8094](https://github.com/YumNumm/EQMonitor/commit/68f80948ab4be242a2cb5b7e3f79acd0438cd0ea))
* 揺れ検知通知を production ビルドでも利用できるようにする ([8e0f481](https://github.com/YumNumm/EQMonitor/commit/8e0f4815408e896af37f4ef9d388fe922ee7e62a))
* 揺れ検知通知を production ビルドでも利用できるようにする ([6134cd1](https://github.com/YumNumm/EQMonitor/commit/6134cd1a50a8148639b01bc82fd1c91f7a816fad))
* 止まったままの端末登録とトークン送信を10分ごとにやり直す ([51a1325](https://github.com/YumNumm/EQMonitor/commit/51a1325e57c9040e7ccc54bd048b4ed7e8afbe30))
* 異常値の観測点を非表示にし、欠測中の観測点を灰色の枠線で描く ([06ccd72](https://github.com/YumNumm/EQMonitor/commit/06ccd723beefadf2ec267142c7cb7b2875c680ce))
* 異常値の観測点を非表示にし、欠測中の観測点を灰色の枠線で描く ([b8fcf02](https://github.com/YumNumm/EQMonitor/commit/b8fcf02695d4cb4c0c2350792d9879e9d7946985))
* 端末の容量を FFIgen・JNIgen で取得する native_plugin を追加する ([15ca91c](https://github.com/YumNumm/EQMonitor/commit/15ca91c41942d88925ea579508730d8d54a808f8))
* 背景・スクリーンショット・端末フレームからストア画像を合成する ([4824a57](https://github.com/YumNumm/EQMonitor/commit/4824a5749c52c199f609e8a0e28ea4ce820ef09b))
* 色分けの選択肢を縦に並べ、震度階級のプレビューに震度を表示 ([607b0e5](https://github.com/YumNumm/EQMonitor/commit/607b0e52c394313588ab8907a8299519200ca00a))
* 設定画面のトグル・操作ボタンにハプティックを追加 ([241818d](https://github.com/YumNumm/EQMonitor/commit/241818dba31dc0877e46e8d81b9184731f6f0e92))
* 購入情報の反映の自動再試行が終わったら同期ボタンを出す ([b295943](https://github.com/YumNumm/EQMonitor/commit/b295943b2bc732514b8c3904575cf0480ce058e2))
* 通知設定のカスタムに揺れ検知の BETA チップを表示する ([9869b49](https://github.com/YumNumm/EQMonitor/commit/9869b4989afbcb677cd38d79c1e7f986f577be3e))
* 震度DBと強震モニタの観測点に観測点名ラベルを表示する ([bc2442b](https://github.com/YumNumm/EQMonitor/commit/bc2442b6d9a1e3af8dc88f0c1f60a7a973ad96d2))
* 震度DBの観測点に観測点名ラベルを表示する ([9e83f4f](https://github.com/YumNumm/EQMonitor/commit/9e83f4f9b6de436aaeda3c51e82478749b11f937))


### Bug Fixes

* 0.5 倍速でも再生中に過去画像が削除されないよう余裕を区間の長さにする ([994340b](https://github.com/YumNumm/EQMonitor/commit/994340b2417b136ce946fcb71f25711c2752518a))
* 2度格子に揃える前の余白を外して広がりすぎを防ぐ ([eb5c9e7](https://github.com/YumNumm/EQMonitor/commit/eb5c9e7d5c059c4ae6f36c11b9095a2301222d85))
* Android の demo mode を撮影ごとに適用し直す ([19332a3](https://github.com/YumNumm/EQMonitor/commit/19332a3d617e8096de4553e57316f638bbfcb43e))
* Android のストア画像から Patrol のラベルとデバッグ用ボタンを外し、震度分布の描画を待つ ([e3bff7a](https://github.com/YumNumm/EQMonitor/commit/e3bff7ae51beaf889724566efaa32f524f7c0a19))
* Android のストア画像撮影では build-name を変えない [skip ci] ([8429d61](https://github.com/YumNumm/EQMonitor/commit/8429d6194730adfa39ede8a6797288455701703a))
* Asset Pack の取得に端末 ID などの自前 API 用ヘッダーを付けない ([08ec5ef](https://github.com/YumNumm/EQMonitor/commit/08ec5ef0391ce08aaa0e39b56cd30af80aacf5ad))
* background復帰時に生きているWebSocketを維持する ([a7a8ef0](https://github.com/YumNumm/EQMonitor/commit/a7a8ef08cc8e23219e71539de7b56650cccf185c))
* CI の撮影結果に合わせて Simulator の作成と待機時間を直す ([069a885](https://github.com/YumNumm/EQMonitor/commit/069a885cdc117445878bf32afee52dfc1677f103))
* cli_launcher を 0.3.4+1 へ更新し Dart 3.15 で melos を起動できるようにする ([32bd18d](https://github.com/YumNumm/EQMonitor/commit/32bd18dc3b905556bfe6994dcd7482640f60fe48))
* create-github-app-token の入力名を client-id に更新 ([a3be053](https://github.com/YumNumm/EQMonitor/commit/a3be053e073e6c84418b1b4083540202fe733819))
* Deploy Appのビルドをrun間で並列化し配信順は待機jobで保つ ([98adedd](https://github.com/YumNumm/EQMonitor/commit/98adedd7c54ee9158802f0541308b1dbb2ae0c21))
* Deploy Appのビルドをrun間で並列化し配信順は待機jobで保つ ([ec6f8ba](https://github.com/YumNumm/EQMonitor/commit/ec6f8baf147afe95a9989d73fc4c46c52155b5be))
* develop 取り込み後もストア画像の撮影用ビルドが通るようにする ([839e1ad](https://github.com/YumNumm/EQMonitor/commit/839e1ad762414121bd7f48128ede844351cdbab4))
* Dynamic Island Expandedの現在地震度バッジを角丸にする ([22c8ba5](https://github.com/YumNumm/EQMonitor/commit/22c8ba5db04c541ba11f90cdca73208ce1d73f31))
* EEWカードの取消時の余白と間隔を詰め、1点検知でM・深さを薄く表示する ([8e2aedd](https://github.com/YumNumm/EQMonitor/commit/8e2aeddf32ac81b4d51fc9b65b14f0a821df71a9))
* EEW履歴と幅を狭めた履歴詳細もルートのpushへ揃える ([94713d0](https://github.com/YumNumm/EQMonitor/commit/94713d0a5300df2a698d3b2097ce87c9970efdd0))
* EEW詳細とリプレイで到達カウントダウンの0.1秒の桁が進まない問題を直す ([22a88d2](https://github.com/YumNumm/EQMonitor/commit/22a88d27cea7a7714b32b65bbaecab3da6364b5a))
* EQRPリプレイ中のP/S波予想円を毎フレーム更新する ([f78967c](https://github.com/YumNumm/EQMonitor/commit/f78967c9b60156a89bd5ccfe5c0cfee4f7518fc4))
* FlutterError.onErrorでParallelWaitErrorを二重にhandleしないようにする ([e89f065](https://github.com/YumNumm/EQMonitor/commit/e89f0656b51aa34c0ae340226d52e7ae271c7832))
* gcloud の asdf プラグイン指定を削除 ([53dc03f](https://github.com/YumNumm/EQMonitor/commit/53dc03f900793a1b42b46e7b38556ee29a9cd2bf))
* iOS CFBundleVersionをFLUTTER_BUILD_NUMBERへ同期 ([bfc1dd5](https://github.com/YumNumm/EQMonitor/commit/bfc1dd5950ae7b7ca51ad0ce78418256fb4b71ac))
* iOS export で network connection lost を再試行対象に追加 ([cc0de75](https://github.com/YumNumm/EQMonitor/commit/cc0de756c2239f5a5aa249a25428e8b33d508215))
* iOS ウィジェットと App Intents の文言の表記を揃える ([e0d7be1](https://github.com/YumNumm/EQMonitor/commit/e0d7be1ec3e66cb5b84546ec21916fef8442c21f))
* iOS のストア画像撮影で API が 403 になる問題を直す ([b4c1be7](https://github.com/YumNumm/EQMonitor/commit/b4c1be777d67f444ae31e4d4efcf16a2783307f7))
* iOS 拡張の API 通信に EQMonitor の User-Agent を付ける ([45adeb1](https://github.com/YumNumm/EQMonitor/commit/45adeb10119da78424701f9869417a9ef2d35497))
* iOSシミュレータでタイル境界に直線が出ないようmaplibre_native_ffiをforkへ向ける ([a48ea3d](https://github.com/YumNumm/EQMonitor/commit/a48ea3d3feb89395559c7e638ebad9252558c625))
* iPhone Duo の内側で地震履歴の詳細を選んでから撮る ([1807044](https://github.com/YumNumm/EQMonitor/commit/180704493a5a0a5dad010c7a27774d46b4930ee4))
* Live Activity テストで現在地の警報表示と点滅が出ない問題を直す ([4fec8fe](https://github.com/YumNumm/EQMonitor/commit/4fec8fed530a838016cbaae7bf1c992291bf3a66))
* Live Activity テストで現在地の警報表示と点滅が出ない問題を直す ([77d7d6a](https://github.com/YumNumm/EQMonitor/commit/77d7d6a11308bec2f3acd6b9e44a351920ec5a29))
* Live Activityのロック画面表示とテスト表示を調整 ([7f5a32d](https://github.com/YumNumm/EQMonitor/commit/7f5a32d2f06cc839be6e58619bab2d31d8a9fcf4))
* MapLibre を dispose 後のデリゲートコールバックを無視する版へ更新する ([48c5dcb](https://github.com/YumNumm/EQMonitor/commit/48c5dcba36f7618e93329edfbf6859b47991fc2c))
* material_ui 1.8 以降と衝突する m3e_core を 1.1.5 へ更新する ([9d207e8](https://github.com/YumNumm/EQMonitor/commit/9d207e88c83074564ef17abee7a79304836a15de))
* mise installのbackendとlockfile警告を解消 ([a0d20b5](https://github.com/YumNumm/EQMonitor/commit/a0d20b5aae9892e5911c5e5aa4e0f6738289f4a6))
* msgpackのtimestamp 64・96を正しく読み込む ([3ba537b](https://github.com/YumNumm/EQMonitor/commit/3ba537b994dc1c167f7025bfb20967844c01fc4e))
* release-please の本番・beta ジョブを直列化 ([714b7eb](https://github.com/YumNumm/EQMonitor/commit/714b7eb8a07b8e493958802365ab0723c4849d71))
* release-please を直列実行して GitHub API 制限を回避する ([b6a7b47](https://github.com/YumNumm/EQMonitor/commit/b6a7b47550a2bd14fe458292364dbf38c22118e3))
* sheet をリポジトリ内へ取り込み Dart 3.15 の pub get を通す ([0b8981f](https://github.com/YumNumm/EQMonitor/commit/0b8981fd6412907596417428f5f3810cb4bd5188))
* Simulator.app を Xcode 内のパスで起動する ([9381e77](https://github.com/YumNumm/EQMonitor/commit/9381e77af01183683da63091a6d585e198ab4180))
* Simulator.app をロック時に探索し、Android の demo mode からモバイル回線の操作を外す ([c6d57e3](https://github.com/YumNumm/EQMonitor/commit/c6d57e3593d9f70f74b26aad2e5db866134e26e6))
* アプリリンク処理の例外で以降のリンクが無反応になる問題を修正 ([6e9a4eb](https://github.com/YumNumm/EQMonitor/commit/6e9a4ebe85b662e2551b9cde4f59e069bf9a0334))
* アプリ内文言の表記揺れを統一する ([78e465f](https://github.com/YumNumm/EQMonitor/commit/78e465f85b97a7b85fd9ff1f647bec7421844adc))
* エラー表示と設定画面の文言の表記を揃える ([d670ba4](https://github.com/YumNumm/EQMonitor/commit/d670ba4962ade2630fd9a28d98690ef8c5a65fc2))
* オンボーディングの通知設定保存で例外以外の失敗時も処理中表示を解除する ([5439397](https://github.com/YumNumm/EQMonitor/commit/5439397170ca3f344a1ca0516304f364c5c666eb))
* シートの自動調整が初期位置より低くならないようにする ([ddb6917](https://github.com/YumNumm/EQMonitor/commit/ddb6917d3d7b8743cc2635445cd48c24a84a5c74))
* ストア画像の上端に描かれるテスト名を消す [skip ci] ([03061b3](https://github.com/YumNumm/EQMonitor/commit/03061b32c319cc64142112a895426b042eb5e0cf))
* ストア画像の地震詳細で観測点を表示し、現在地を高岡市太田にする ([19907ff](https://github.com/YumNumm/EQMonitor/commit/19907ff49f1f741ffd74abbd5c205b64b5aa07b4))
* テーマ切替・画面回転で地図とシートが崩れる問題を修正 ([c9d85fd](https://github.com/YumNumm/EQMonitor/commit/c9d85fd9283598baace8f53ed0bf17df45885ab6))
* デバッグ画面の用語を揃える ([1b4830b](https://github.com/YumNumm/EQMonitor/commit/1b4830b947d35dd6a6df2400834fa9ec3e6e8610))
* バックグラウンド中は履歴詳細をルートへ切り替えない ([880ed06](https://github.com/YumNumm/EQMonitor/commit/880ed0643d27e1cd0d6ef128f9c5495c6d8feda5))
* ハプティックの完了を待たずに操作を即時実行する ([a2ef2df](https://github.com/YumNumm/EQMonitor/commit/a2ef2df919f54c7677f333968f4b785eed19c987))
* ホームシートの情報優先度・権限導線・操作性を改善する ([e8fc4ec](https://github.com/YumNumm/EQMonitor/commit/e8fc4ec494485a929bbceb844cfe96916e752e8e))
* ホーム地図のEEW震源の点滅を復活し不透明度を100%⇔50%にする ([5b041f6](https://github.com/YumNumm/EQMonitor/commit/5b041f64108c0da42fcceb84917d557b5fcd699d))
* ホーム地図の震度スケールの左端と間隔を他のカードに揃える ([84999de](https://github.com/YumNumm/EQMonitor/commit/84999dee2dec3205d60516a428bf2e8c056a468f))
* ホーム地図の震度スケールの左端と間隔を他のカードに揃える ([519a671](https://github.com/YumNumm/EQMonitor/commit/519a671b6b404067b0c354ac9644b069751a47ec))
* マグニチュード表記の光学サイズと字間をiOSに揃える ([8b7c7ed](https://github.com/YumNumm/EQMonitor/commit/8b7c7ed2f59b48e4b8ae522aff4fa0baa186d9fa))
* リプレイとprovider起動中の破棄でworkerの終了を握りつぶさず扱う ([f37529d](https://github.com/YumNumm/EQMonitor/commit/f37529d77650199a5eebd284b81af775ef953414))
* リプレイの一時停止と速度変更で時刻を巻き戻さない ([4b7f5ec](https://github.com/YumNumm/EQMonitor/commit/4b7f5ec7f44ebe3140a3ce8992c1985600e887ea))
* リプレイの位置計算を切り出し、解析中の一時停止で時刻を戻さない ([0ebd20c](https://github.com/YumNumm/EQMonitor/commit/0ebd20c0c9a73a5f8c4979aa92a40f0569b85836))
* リプレイ中のAppClockを再生速度で補間する ([c0f8358](https://github.com/YumNumm/EQMonitor/commit/c0f83580793c55aab994704dc483873086dfd011))
* リプレイ中はP/S波に強震モニタの公開遅延を適用しない ([6c002a0](https://github.com/YumNumm/EQMonitor/commit/6c002a0bc00530e05d7c89aac87b15287ad8840e))
* リプレイ時計の補間を注入可能にし、相対シークを表示位置基準にする ([30eacbf](https://github.com/YumNumm/EQMonitor/commit/30eacbfe8fbd9b1cfd4ac8e26a88518ff40d7bb4))
* リプレイ読み込みの新しい API に撮影シーンを合わせる ([32de21d](https://github.com/YumNumm/EQMonitor/commit/32de21d5a6e8613ddb224ed011a2f1f525c4e37b))
* ロールを取得できたときだけ触覚を返す ([4ae5ba7](https://github.com/YumNumm/EQMonitor/commit/4ae5ba7792ba6f4768af99f11a43b3ed1e65cc39))
* ロック画面のシーンを実験扱いにし、iOS のアプリログを unified logging から読む ([a0c1fd3](https://github.com/YumNumm/EQMonitor/commit/a0c1fd3a312af51542b904535c359dab3cd47eca))
* 位置情報・App Check・強震カラーマップの初期化失敗で起動を止めない ([cd9eb74](https://github.com/YumNumm/EQMonitor/commit/cd9eb74eb4fdc74ecb5e6ede72f0b3d383735ffc))
* 再生中のバッジから時刻を外す ([b65da44](https://github.com/YumNumm/EQMonitor/commit/b65da446cece48f6dc92b289c57e4b084e553da7))
* 再生開始前に強震モニタ設定と購読状態の読み込みを待つ ([60fd44a](https://github.com/YumNumm/EQMonitor/commit/60fd44a107a7b7a449491481cc943b2dc708f076))
* 再生開始直前の EEW 再確認と過去画像の取得方針の分離 ([86e7cd3](https://github.com/YumNumm/EQMonitor/commit/86e7cd3bae1253ab8b4a761caef1855476842f76))
* 最小レベルの震度の目安を新しい境界に合わせる ([572c490](https://github.com/YumNumm/EQMonitor/commit/572c49003abab966e2d57fb6d011ecad8a3a3b39))
* 初回の時刻同期中に復帰した場合も測り直す ([461cfcd](https://github.com/YumNumm/EQMonitor/commit/461cfcdbb4f04319152d12ab2e59a423bcce898d))
* 前置き区間をリプレイの再生範囲に含めない ([0535306](https://github.com/YumNumm/EQMonitor/commit/05353069d2f37807695089eed43fdb557bc6c325))
* 同名のリプレイファイルを上書きせず連番で保存する ([2b3ecaf](https://github.com/YumNumm/EQMonitor/commit/2b3ecaf964de16cff1de76bbdc0bbdbd53ae715d))
* 地図の初期ズームを MapLibre の 512px タイル基準で計算する ([dfafb2c](https://github.com/YumNumm/EQMonitor/commit/dfafb2c134d7a8cdbf879e1274d23f9261b4d199))
* 地図を閉じた直後の MapLibre イベントで例外が記録される ([ca5809d](https://github.com/YumNumm/EQMonitor/commit/ca5809dbfbfe48dbf441ed55aa36ba75b99f81a3))
* 地図操作ボタンのアイコン色と位置情報バナーの見出しの折り返しを直す ([6449ec1](https://github.com/YumNumm/EQMonitor/commit/6449ec1062dce3fb944c879e413c45f6d98e9078))
* 地図操作ボタンを 48dp の IconButton にする ([5e84029](https://github.com/YumNumm/EQMonitor/commit/5e84029748fca98b9958b70978bd1c50fa1f98df))
* 地域選択でテーマ切替後に地図が読み込めない表示になる問題を修正 ([937729c](https://github.com/YumNumm/EQMonitor/commit/937729c438b5bb40469f4a988c9684f5c5e8f805))
* 地震履歴・電文・EEW 表示の文言の表記を揃える ([7694a77](https://github.com/YumNumm/EQMonitor/commit/7694a77cd25bb5bbba46ca90ca029bb86440eaf6))
* 地震履歴APIのリクエストにタイムアウトを設定する ([0ae0017](https://github.com/YumNumm/EQMonitor/commit/0ae00170a605695df74b120523878063e7efa9bb))
* 地震履歴の先頭再取得を直列化する ([4c7eb4e](https://github.com/YumNumm/EQMonitor/commit/4c7eb4e106f92b58ea2c925c275d4d45ed568d13))
* 地震履歴詳細のデータソース表記を気象庁防災情報XMLに修正する ([3e54b93](https://github.com/YumNumm/EQMonitor/commit/3e54b93b291dd7d046796e6ace0c74e2e84563cb))
* 地震履歴詳細の地図を閉じた直後のイベントで例外が発生する ([9e51316](https://github.com/YumNumm/EQMonitor/commit/9e5131614db8221b9b0a1f7e2f7412fa06dd94e1))
* 地震履歴詳細の地図を閉じた直後のイベントで例外が発生する ([ddb27f0](https://github.com/YumNumm/EQMonitor/commit/ddb27f01d5dc14d2fce53cdd9077cd262b8d33af))
* 地震詳細から開いた市区町村別最大震度で選択枠をシートの上に収める ([86f6e28](https://github.com/YumNumm/EQMonitor/commit/86f6e28d237017e64720fa1e8a2d6099ac971b4c))
* 壁紙の保存領域の準備を待ってから書き込み、位置情報の許可待ちに上限を付ける ([384cbe4](https://github.com/YumNumm/EQMonitor/commit/384cbe4aaeeaee8e4a4a960429d87763ccd02ee0))
* 市区町村コードだけのディープリンクでは市区町村へ寄せない ([a9d6ec5](https://github.com/YumNumm/EQMonitor/commit/a9d6ec5bcd04f10e2d5d84cde259e5c2714f4eef))
* 市区町村タップ時はカメラ移動を待たずに選択枠と詳細シートを出す ([aa8d2e5](https://github.com/YumNumm/EQMonitor/commit/aa8d2e59be586f7989936eac7ccfa600b8a33683))
* 市区町村の選択枠を一度だけ追加し filter の更新で切り替える ([830c7d4](https://github.com/YumNumm/EQMonitor/commit/830c7d44f40cf686879ebb865c0c3d2b93274e0c))
* 市区町村別最大震度でテーマ切替時に地図と詳細シートが崩れる問題を修正 ([6af1294](https://github.com/YumNumm/EQMonitor/commit/6af12943c65ce08650401da1885a4b6bb071f88c))
* 市区町村別最大震度の再描画で追加直後のレイヤーを消さない ([c6752ad](https://github.com/YumNumm/EQMonitor/commit/c6752ade625adb03a536bcbcf9cdd1c19de50787))
* 強震モニタが復帰時に自分自身を invalidate して debug assert で落ちる問題を直す ([f97cbea](https://github.com/YumNumm/EQMonitor/commit/f97cbea8aee38c9cd35e21717fd980069f174a7f))
* 強震モニタの初回測定の前からlifecycleを監視する ([e906e3d](https://github.com/YumNumm/EQMonitor/commit/e906e3dc052113dbebf781482a6972dc103344d8))
* 強震モニタの測定中に復帰した場合は完了後に検証する ([0c9e80c](https://github.com/YumNumm/EQMonitor/commit/0c9e80c63507b3a8412dd615c4365886cc71eb3b))
* 強震モニタの説明ページの括弧と空白を揃える ([69c6ed4](https://github.com/YumNumm/EQMonitor/commit/69c6ed46463d7a60e2bffd5895fa1e45fe3d9641))
* 強震モニタ観測点レイヤーのテストにhasIconを渡す ([814a4a3](https://github.com/YumNumm/EQMonitor/commit/814a4a384e2febfb00d34a178a049dcb33b78268))
* 復帰時の確認と初回のNTP取得の競合を防ぐ ([1a34ca5](https://github.com/YumNumm/EQMonitor/commit/1a34ca5530d1427d82f50f331cd60a2cdbfcc511))
* 必須でないSDK初期化の失敗で起動を止めない ([79aa4f5](https://github.com/YumNumm/EQMonitor/commit/79aa4f504b47787054029ebb4ae8143fc82d4f2c))
* 推計震度カードの見出しを震度配色に変更 ([dc51827](https://github.com/YumNumm/EQMonitor/commit/dc51827985507fcec8e7ddc45f364810bd758f1c))
* 揺れ検知カードの地域名を半角にそろえる ([ec85d98](https://github.com/YumNumm/EQMonitor/commit/ec85d98a85e3cce8ddebaa473ed661327c99af1d))
* 揺れ検知カードの揺れた範囲がイベントの更新のたびに一瞬消える問題を直す ([d533718](https://github.com/YumNumm/EQMonitor/commit/d533718a0385f75b79ad47cf0fc0827c6cbaa90f))
* 揺れ検知カードの揺れた範囲がイベントの更新のたびに一瞬消える問題を直す ([d50e9c9](https://github.com/YumNumm/EQMonitor/commit/d50e9c93bfd5c47de2bca0500d682f83127128ca))
* 揺れ検知とEEWの結合を観測点ごとの検知時刻で判定する ([ef95242](https://github.com/YumNumm/EQMonitor/commit/ef95242ccb9a24efb3cf870f33a93508b1511ef7))
* 揺れ検知とEEWの結合判定を修正し、結合した揺れ検知の範囲を自動フォーカスに含める ([2d43b5f](https://github.com/YumNumm/EQMonitor/commit/2d43b5f12a38fbcf93c2b9964be7af074b74b196))
* 揺れ検知のフォーカス範囲を2度格子に揃えて再フォーカスを抑える ([18470ce](https://github.com/YumNumm/EQMonitor/commit/18470ce474e57dd8dc52a113a988012f30c790ca))
* 揺れ検知のみのフォーカスを EEW と同じくホームボタンと地図操作で制御する ([557182f](https://github.com/YumNumm/EQMonitor/commit/557182fe5d1983b1db4b2729bbc9b885007e4aba))
* 揺れ検知レベルの境界と名称を配信側の検知サービスに合わせる ([fcc9b36](https://github.com/YumNumm/EQMonitor/commit/fcc9b36585489b15b6f4a393f66f7c991cb7e653))
* 揺れ検知を緊急地震速報の直後に置き、位置情報バナーの導線を通知設定と揃える ([f7105c7](https://github.com/YumNumm/EQMonitor/commit/f7105c76e362dfb23b515a04d6f5fd9f2faed654))
* 撮影失敗の原因を追えるようアプリのエラー出力と Xcode の構成を記録する ([9b0254c](https://github.com/YumNumm/EQMonitor/commit/9b0254c511325682d7a41175b3c181902a46ba70))
* 未捕捉エラーをCrashlyticsのissueとして記録する ([c1fe3d9](https://github.com/YumNumm/EQMonitor/commit/c1fe3d9cd374541a8d0e76b8583bf7d451848b92))
* 未捕捉エラーをCrashlyticsのissueとして記録する ([a31628f](https://github.com/YumNumm/EQMonitor/commit/a31628f9d87605c44cd6bca15e02b0929cfcf0b0))
* 残っていた権限表記・句点を揃え、気象庁の引用文は原文に戻す ([0c732d7](https://github.com/YumNumm/EQMonitor/commit/0c732d74adadd387547770d94c156f31b90083df))
* 狭い画面の地震履歴は詳細ルートをpushしてスワイプバックを有効にする ([b313c45](https://github.com/YumNumm/EQMonitor/commit/b313c4548e21f904d33ae961a7a6fac63191844d))
* 画面の回転やリサイズでシートとEEW詳細を作り直さない ([9faad71](https://github.com/YumNumm/EQMonitor/commit/9faad71b3ff9fe285eefd0e8dc8711060d8ae9f3))
* 発生時刻の解決で読めない EEW フレームを読み飛ばす ([0d71a50](https://github.com/YumNumm/EQMonitor/commit/0d71a50c08d8fa38ced462514649fab8baf8d5a4))
* 細分区域のポップアップから市区町村別最大震度へ遷移しない ([62c39fe](https://github.com/YumNumm/EQMonitor/commit/62c39fe51c911a2d7135cc3be42d065a245e9d80))
* 絞り込みチップの「すべて」・範囲記号・以上/以下の表記を揃える ([0dab29d](https://github.com/YumNumm/EQMonitor/commit/0dab29d9bd2862fe63af7ef253ec03f6285535b0))
* 表示範囲の選択中にテーマを切り替えても地図を作り直さない ([55647b1](https://github.com/YumNumm/EQMonitor/commit/55647b1c8cdb1417b521b431c254dc08df9f5131))
* 複数震源の震度データベース詳細で観測点数0を表示しない ([c57eaef](https://github.com/YumNumm/EQMonitor/commit/c57eaeff57f891d701a41dd5f1db2e0a1726eebf))
* 解析中にworkerが破棄されてもエラー表示にしない ([ef97adf](https://github.com/YumNumm/EQMonitor/commit/ef97adf979c81187fc3cd70f1ecc86a7e7b8f409))
* 設定項目の説明文から句点を外し表記を揃える ([b86bbe6](https://github.com/YumNumm/EQMonitor/commit/b86bbe69fdbfd3c2e467113746c8dd918357498a))
* 認証系の API 通信にも EQMonitor の User-Agent を付ける ([a37da3e](https://github.com/YumNumm/EQMonitor/commit/a37da3e8ab13397221a1612ff5f110042885b2ff))
* 課金・オンボーディング・リプレイなどの文言の表記を揃える ([e355862](https://github.com/YumNumm/EQMonitor/commit/e3558620eec2fe4af485d8a86f1e47bde299c459))
* 購読状態が確定するまで App Group の Pro 状態を書き換えない ([a0f9d11](https://github.com/YumNumm/EQMonitor/commit/a0f9d11ca6549c0fa9fe70117cb157748970b580))
* 購読状態の再構築で打ち切った自動再試行の印を消す ([06adda3](https://github.com/YumNumm/EQMonitor/commit/06adda32ef203d0608a594f4a3807c9ec20ad4c2))
* 購読状態の再構築で打ち切った自動再試行の進行中フラグを解除する ([c144260](https://github.com/YumNumm/EQMonitor/commit/c1442600fa99aee21dcb96e890c059ef6dbb83de))
* 通知センターの撮影で Live Activity の許可を押し、撮影用 Simulator を英語にする ([e8c3545](https://github.com/YumNumm/EQMonitor/commit/e8c3545eb8cf33dd6c7152abc8006e671b8df03b))
* 通知タップ・アプリリンク処理の例外で以降の操作が無反応になる問題を修正 ([7327421](https://github.com/YumNumm/EQMonitor/commit/7327421dde78c04e32cece84b6bf18635a6b09da))
* 通知タップ処理の例外で以降のタップが無反応になる問題を修正 ([d718fbc](https://github.com/YumNumm/EQMonitor/commit/d718fbccb42d9de2cb1876a211db46c17730f899))
* 通知プリセット適用が失敗後に別プリセットのステップを飛ばす問題を修正 ([7182b7a](https://github.com/YumNumm/EQMonitor/commit/7182b7a3cf9d03aeb06083f97d8369e6d675c3f8))
* 通知プリセット適用が失敗後に別プリセットのステップを飛ばす問題を修正 ([ef6df64](https://github.com/YumNumm/EQMonitor/commit/ef6df64051fd400763fd14e1ac5d6e58cfabf7df))
* 通知プリセット適用のステップ結果を適用先ごとの instanceId に分ける ([5bb2f47](https://github.com/YumNumm/EQMonitor/commit/5bb2f478c98c37d22be5dd85d03f829896bd8c39))
* 通知権限ダイアログの見出しを「通知権限」に揃える ([aa95cc0](https://github.com/YumNumm/EQMonitor/commit/aa95cc00d7c7b7203dfd5da6bcb04085c4af6ca6))
* 通知設定と通知テストの文言の表記を揃える ([527f436](https://github.com/YumNumm/EQMonitor/commit/527f43698e262159a0f1998d7e982f4bed9449b9))
* 過去画像の削除周期の実測に合わせて再生できる範囲の端を避ける ([3eefbde](https://github.com/YumNumm/EQMonitor/commit/3eefbde83270a36f298398e97e354b5834fef198))
* 選んだ期間の画像が無い場合と書き出し後の中止でファイルを保存しない ([52be620](https://github.com/YumNumm/EQMonitor/commit/52be620d23766eb20ba1c453145e93adf7bcc280))
* 配色変更後も地震履歴詳細の観測点アイコンが旧配色のまま残る問題を修正 ([b2582e1](https://github.com/YumNumm/EQMonitor/commit/b2582e144c5d64e1dd0c79d5462a9f8bfe6fdd37))
* 震度データベースの震源の詳細情報を色付きカードの下に表示する ([65e7c0d](https://github.com/YumNumm/EQMonitor/commit/65e7c0d0b94beb32bfd375c13bc2f5674fc7068b))
* 震度データベース詳細の震源情報表示を調整する ([691aec9](https://github.com/YumNumm/EQMonitor/commit/691aec95aa7fceb1684eab4e9c244b864276c1bb))
* 高負荷の iOS runner でも撮影の同期が timeout しないようにする ([af8f2f5](https://github.com/YumNumm/EQMonitor/commit/af8f2f5b5dd416bb0f8f0206639a2eb4758b1620))


### Performance Improvements

* デバイスのロールを端末に保存し毎起動での取得をやめる ([1a899ff](https://github.com/YumNumm/EQMonitor/commit/1a899fffad63faf7d5dca7e7bb74c13b6add8974))
* 強震モニタで取得済みの対象時刻の画像を取り直さない ([5d58c3a](https://github.com/YumNumm/EQMonitor/commit/5d58c3ac0eaa2b40e3b1f3262acdf391a237f439))
* 揺れ検知通知の設定を起動時に取得しない ([72c9be6](https://github.com/YumNumm/EQMonitor/commit/72c9be6fd6807b48fa5688e6727653bf7f4ef419))
* 端末トークンをメモリに保持し全リクエストでの secure storage 読み取りをやめる ([871840c](https://github.com/YumNumm/EQMonitor/commit/871840c4d32280c7dc55dd8bde2932943ebbeba3))
* 起動時の API 通信を減らす ([49b790f](https://github.com/YumNumm/EQMonitor/commit/49b790fe15862efc295fa8291e2997aa363e321c))
* 通知スロットを前回値で進め裏でサーバーへ確認する ([cd02652](https://github.com/YumNumm/EQMonitor/commit/cd026523a114fb1268f866a7de78c1e966f6a919))
* 通知トークンを送り直す間隔を72時間に延ばす ([4be3f71](https://github.com/YumNumm/EQMonitor/commit/4be3f71740b6ddebb7b5ad48bab345ed98e847dc))


### Reverts

* シートのスナップ位置を 4 段に減らす ([2ba156d](https://github.com/YumNumm/EQMonitor/commit/2ba156dfbc1f693431732b9eb79ff9558e397c3d))

## [3.0.6](https://github.com/YumNumm/EQMonitor/compare/v3.0.5...v3.0.6) (2026-10-31)


### Bug Fixes

* Admin端末の揺れ検知通知設定を許可 ([1d87d4a](https://github.com/YumNumm/EQMonitor/commit/1d87d4a611c08cb1085bf0f0d99be8f1030e4d9c))
* 揺れ検知通知の画面と前面表示を権限に連動 ([e200aaf](https://github.com/YumNumm/EQMonitor/commit/e200aaf0b3e53b055fadb73ab4ff765bc7f04475))

## [3.0.5](https://github.com/YumNumm/EQMonitor/compare/v3.0.4...v3.0.5) (2026-10-29)


### Bug Fixes

* Android CIでNDK 28.2を事前インストールする ([b7f89f1](https://github.com/YumNumm/EQMonitor/commit/b7f89f1f004a9789dd470df779324b09e144a402))
* CDでCrashlyticsへiOSのdSYMを送信 ([3b5a670](https://github.com/YumNumm/EQMonitor/commit/3b5a67074132497ad745520535468e690feab0dc))
* CDでCrashlyticsへiOSのdSYMを送信 ([f23f07e](https://github.com/YumNumm/EQMonitor/commit/f23f07efc6e2c92adc1765ec499011b494848a80))
* Dependabot セキュリティ更新の失敗を解消 ([f28a742](https://github.com/YumNumm/EQMonitor/commit/f28a742fcc17fed106306389698c791cef91d702))
* EEW詳細の報更新と震度5弱以上の塗り潰しを修正 ([9b8dc4f](https://github.com/YumNumm/EQMonitor/commit/9b8dc4fe341d9af5d9711192623da65efb4deb37))
* EEW詳細の報更新と震度5弱以上の塗り潰しを修正 ([9c99052](https://github.com/YumNumm/EQMonitor/commit/9c99052860d1e2bb6f27a39106c98059f268255c))
* EEW通知から地震詳細へ誤遷移する不具合を修正 ([ceabefb](https://github.com/YumNumm/EQMonitor/commit/ceabefb300ba0bcc6804e82f71f9971d0805af69))
* jactionlintのカラーフラグを--colorに修正 ([7ed4243](https://github.com/YumNumm/EQMonitor/commit/7ed4243abb98d27be58731dbea75dc2a903944fc))
* ローカルセットアップで既存のmiseロックを使用 ([8d9f85d](https://github.com/YumNumm/EQMonitor/commit/8d9f85d95d9147372f877fbbd33f71cd46674522))
* ローカルセットアップで既存のmiseロックを使用 ([f250a8e](https://github.com/YumNumm/EQMonitor/commit/f250a8e75ba97e098ae43ea33b27572911231b76))
* 推計震度の既定色で震度4と5弱を入れ替え ([e060dae](https://github.com/YumNumm/EQMonitor/commit/e060dae7d6b72dad6095b2ba37af64716e6c3944))
* 揺れ検知のデバッグ通知設定へのアクセスを許可 ([3b05904](https://github.com/YumNumm/EQMonitor/commit/3b05904db23962573a037e3df64b6cf0893cae7e))
* 緊急地震速報の予想震度塗り潰し色を修正 ([f26634c](https://github.com/YumNumm/EQMonitor/commit/f26634c98b69fb36c24d95a2a07cf3cb65ad3b89))
* 長周期地震動電文の地域一覧を階級表示に修正 ([38b1e2c](https://github.com/YumNumm/EQMonitor/commit/38b1e2caf199f8e88ec578ea5b9746e508c5f543))
* 長周期地震動電文の地域一覧を階級表示に修正 ([3af293d](https://github.com/YumNumm/EQMonitor/commit/3af293d0bc0ae0f2bd6d6da59368971d5b07e9f8))

## [3.0.4](https://github.com/YumNumm/EQMonitor/compare/v3.0.2...v3.0.4) (2026-10-23)


### Features

* Androidのロック画面表示を設定値に連動 ([66cc86d](https://github.com/YumNumm/EQMonitor/commit/66cc86d95aeb9bfb78c68fd2346eeaf24a24a1d5))
* API接続先の手入力とSharedPreferencesへの保存を追加 ([4cc90d9](https://github.com/YumNumm/EQMonitor/commit/4cc90d9c5cc7b88c0a93b4d1ae8f9253a9f6dd24))
* API接続先の手入力と保存画面を追加する ([5d3e345](https://github.com/YumNumm/EQMonitor/commit/5d3e345c0f4599cd858d8321990283b7d01c38bf))
* WebSocketのHeartbeatを固定のペイロードにし、WebSocket Hibernetesに対応 ([c1244ca](https://github.com/YumNumm/EQMonitor/commit/c1244ca09ff33a0f24c7fcb6e0bf02007f5660e4))
* WebSocket固定heartbeatで休眠配信に対応 ([8346abc](https://github.com/YumNumm/EQMonitor/commit/8346abc3db62fdcb2c196b48a9b7354e0a45239e))
* デバッグの通知設定に言語選択を追加 ([fa25fa2](https://github.com/YumNumm/EQMonitor/commit/fa25fa296f204258aebdb7d3f0fca7782598d08a))
* 接続先の保存とWebSocket再接続を連動させる ([3648e85](https://github.com/YumNumm/EQMonitor/commit/3648e854bb0594973c961f96746a3e2d8444143b))
* 画面動作設定の保存と状態管理を追加 ([a91b23c](https://github.com/YumNumm/EQMonitor/commit/a91b23cde1b2daddfc28f2fa26e7ef78dfcf6572))
* 画面点灯維持とAndroidロック画面表示を設定可能にする ([0a046a2](https://github.com/YumNumm/EQMonitor/commit/0a046a2dec4b9afbe8edce893ffa3f251cbcc5e4))
* 表示設定に画面動作の切替を追加 ([8ffad2e](https://github.com/YumNumm/EQMonitor/commit/8ffad2e4b4911fc43e1ee500d891773cc64099ae))
* 通知言語の更新APIクライアントを生成 ([5b5e325](https://github.com/YumNumm/EQMonitor/commit/5b5e3256cb74c59354c4a0d555354ad96a26bdf3))
* 通知言語を保存する状態管理を追加 ([453ac2a](https://github.com/YumNumm/EQMonitor/commit/453ac2abb4640d5354cd787fae41783f7c80aa99))


### Bug Fixes

* Androidで強震モニタのHTTP通信をホスト限定で許可 ([5f5a2f4](https://github.com/YumNumm/EQMonitor/commit/5f5a2f4b36c4488c2e127715a245eafd297290ad))
* Android通知アイコンをリリースビルドで保持 ([123f071](https://github.com/YumNumm/EQMonitor/commit/123f071786a3b83a219d52f3476c2efbc306af94))
* CIワークフローの権限と同時実行制御を修正 ([01dd74f](https://github.com/YumNumm/EQMonitor/commit/01dd74f825ce2432298100750d557d131e2e8970))
* EEW履歴と報一覧に取消報の表示を追加 ([52731e2](https://github.com/YumNumm/EQMonitor/commit/52731e275d692694be398a6ec1ac0c45ace05069))
* iOS提出バージョンを3.0.3へ進める ([0b04c1a](https://github.com/YumNumm/EQMonitor/commit/0b04c1a375a18d2d9010add86e2893aeed732266))
* jactionlint のフラグを --color に修正 ([ecf03c2](https://github.com/YumNumm/EQMonitor/commit/ecf03c2ce8b7f7f753479650c895a9ec55a27a38))
* jactionlint のフラグを --color に修正 ([00f6c4d](https://github.com/YumNumm/EQMonitor/commit/00f6c4d279172cb0cb033b59b3f248c2547d8743))
* PR更新後も必須の作成者チェックを実行 ([88ffe3c](https://github.com/YumNumm/EQMonitor/commit/88ffe3c0372fa4078b2f7ba4aa92900b07a16cc3))
* realtime ticketの再接続オーバーフローと未登録時の送信を修正 ([ff5e548](https://github.com/YumNumm/EQMonitor/commit/ff5e548b2debbd1447cdb94059de6cbfeafd54ac))
* realtime ticketの再接続オーバーフローと未登録時の送信を修正 ([23037d2](https://github.com/YumNumm/EQMonitor/commit/23037d25491e92939a6369b5ec9fccabe157036b))
* TestFlight内部配信の処理完了を検証 ([04cc52a](https://github.com/YumNumm/EQMonitor/commit/04cc52ac979036e1b6977a7d8d6d3b609157e3d8))
* TestFlight内部配信の処理完了を検証 ([3f41b21](https://github.com/YumNumm/EQMonitor/commit/3f41b2117da5b7b65baa256da3c9faa9c193d2d0))
* TestFlight再配信で署名済みIPAのビルド番号を使う ([4c8a61b](https://github.com/YumNumm/EQMonitor/commit/4c8a61b3f40334f95e64e900d1393afc2b60e3b9))
* UIテストと色選択のMaterial境界を修正 ([6e2ccca](https://github.com/YumNumm/EQMonitor/commit/6e2ccca69ab0d9c9b507bd84b2e1eb8c358bdea6))
* アーカイブ検証テストの時間制御を安定化 ([acec4b2](https://github.com/YumNumm/EQMonitor/commit/acec4b226e4aba659cb95903aba2be7953ba8943))
* テーマ設定の下端に安全領域を確保 ([ae00f7a](https://github.com/YumNumm/EQMonitor/commit/ae00f7adf8879331210cb21191c292c497e59e12))
* マグニチュード表示テストをRichTextに合わせる ([b6b3e95](https://github.com/YumNumm/EQMonitor/commit/b6b3e955d10d696bc9b5c3100ba34c12cc2203bc))
* ルート検証を現行のページ生成と構文に合わせる ([c205759](https://github.com/YumNumm/EQMonitor/commit/c205759835ba6019d82c1575ee9ed7383399f604))
* 同一AABをGoogle Playテストへ配信して検証 ([1500362](https://github.com/YumNumm/EQMonitor/commit/1500362657d530342d5082ee4d3e1c5b6d1fa7aa))
* 地震デバッグ編集テストと完了TODOを整理 ([dfe0afe](https://github.com/YumNumm/EQMonitor/commit/dfe0afe0ad54e20a111392874179ee0c3a896772))
* 必須のFlutter解析チェックを全PRで実行 ([627a73a](https://github.com/YumNumm/EQMonitor/commit/627a73acd3a3b640593e397c298e1ede61bd95d6))
* 既存テストの地震fixtureと環境依存を修正 ([ffbf038](https://github.com/YumNumm/EQMonitor/commit/ffbf038f6d5d4dd6dbb428a484769d30429cd321))
* 通知配信ログの既存テストを現行表示に合わせる ([02594e1](https://github.com/YumNumm/EQMonitor/commit/02594e1af6e856ce80f99542be10fac3445e3ba9))

## [3.0.1](https://github.com/YumNumm/EQMonitor/compare/v3.0.0...v3.0.1) (2026-10-02)


### Features

* 地震履歴のマーカー描画順を固定位置で制御 ([c90d976](https://github.com/YumNumm/EQMonitor/commit/c90d9762eb15eaa177ac4a4a6af3f17b19c09cd2))
* 地震履歴詳細の表示設定を保存 ([153ed9a](https://github.com/YumNumm/EQMonitor/commit/153ed9a619041df4fc6e53f62487f337ad7a536f))
* 地震履歴詳細の設定シートを追加 ([2405ceb](https://github.com/YumNumm/EQMonitor/commit/2405cebab150158c240e69701e2a6174e9830f43))
* 詳細地図から表示設定を切り替え ([f2a9b0b](https://github.com/YumNumm/EQMonitor/commit/f2a9b0bbdf77dea21d04db06d00d801669142017))


### Bug Fixes

* アプリ名からβを削除して3.0.1を準備 ([d3f0471](https://github.com/YumNumm/EQMonitor/commit/d3f04715a7dcd88fe0e49e0915c48a3ab7117482))
* アプリ名からβを削除して3.0.1を準備 ([7c04ea7](https://github.com/YumNumm/EQMonitor/commit/7c04ea79a8d0c7bab964ef06ed7cc74954150230))
* カタログ時刻と加速度を原資料の精度で表示する ([b28f39d](https://github.com/YumNumm/EQMonitor/commit/b28f39dd7d8e23abe53c18599ebd94f6e41d0514))
* カタログ時刻と加速度を原資料の精度で表示する ([6f112ac](https://github.com/YumNumm/EQMonitor/commit/6f112ac77aadbe10303d5ce038e12b8bf7f6b86c))
* 推計震度の観測点表示設定を分離 ([2d94323](https://github.com/YumNumm/EQMonitor/commit/2d94323f7be6bedd5e1a4692bad9722fe19c5fde))
* 電文一覧と関連画面の深さをごく浅い表記に統一 ([2ca95dc](https://github.com/YumNumm/EQMonitor/commit/2ca95dcb4d23765c9ac529e02c10e80887de63d2))

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
