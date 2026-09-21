# 地図 renderer の検証・画面移行

数値は元の優先度。unit test や shader compilation の成功を GPU 可視出力の確認とみなさない。

## 820: flutter_scene の自前 instance buffer 上書き

- 対象: `third_party/flutter_scene/packages/flutter_scene/lib/src/render/instance_batching.dart`、`scene_encoder.dart`、`render/depth_prepass.dart`。fork 課題: <https://github.com/YumNumm/flutter_scene/pull/2#issuecomment-5297825484>。
- `opaqueBatchEnd` / `depthBatchEnd` で `bindsModelTransformInstance == false` の geometry を batch 対象から外す。現行 pin の実装を再確認してから fork を修正する。
- 完了条件: 同じ `StaticInstanceGeometry` を2ノードで共有しても自前 instance slot を model transform で上書きせず、`BillboardGeometry` も回帰しない。修正までは1 geometry 1ノード制約を守る。

## 800: GPU・実機・性能の延期検証

- 対象: `packages/eqmonitor_map/README.md`、`lib/src/widget/base_map_view.dart`、`lib/src/flutter_scene/`、`lib/src/renderer/`（同 package）、`packages/eqmonitor_map/example/`。
- iOS/Android 物理端末の profile/release で mesh・custom material・TextPainter overlay、縦横回転、partial position/color update の開始停止、background 復帰、resource rebuild、dispose/remount を確認する。端末/OS/build mode と frame/upload/exception counter・失敗ログを記録する。
- `FlutterSceneSpikeView` / `BaseMapMaterialPreflightView` は可視出力・resize 未確認。旧実験では NodeCamera＋正射影で黒画面となったため、production の恒等 camera/node transform 経路と切り分ける。
- `MapRenderPacket` → batch → adapter 経路の fill/line の見た目、復帰時再描画、pinch 中 upload が0へ収束することを確認する。
- pan/pinch/loading/degraded の widget test、固定 PMTiles/viewport/DPR/theme/text scale の fill/line/label golden、frame/queue/decode/mesh/GPU/cache benchmark と回帰閾値を整備する。HUD は有無を再確認し、計測自体の CPU/memory overhead と event drop も測る。
- 可視確認後に `MeshGeometry.fromArrays` の不要な法線生成、`retainCpuData` 二重保持、pack→unpack、UI isolate packer の負荷を計測して最適化する。GPU buffer の決定的解放は API が利用可能になった時点で検討する。
- 完了条件: 上記の自動検証と端末別 smoke 記録が揃い、GPU 型を使う adapter/material 適用も可視出力で確認できること。

## 800: MVT / mesh の残る機能・fixture

- 対象: `packages/eqmonitor_map/lib/src/tile/mvt/mvt_decoder.dart`、`lib/src/mesh/line_mesh_builder.dart`、関連 `test/`、`packages/pmtiles_v3/test/`。
- string properties の decode は現在実装済み。残る feature ID / 非文字列属性の必要範囲、bevel/round join・round cap・dash・linesofar、頂点間引き、extent buffer の scissor を定義し、採用項目を fixture 化する。
- 冗長 varint 拒否、実 tile の polygon hole、反転法線 fallback のテストを補う。tile ID fixture の参照 commit SHA と MVT winding コメントを確認・修正する。
- MapLibre の int16/uint8 packing は未採用。圧縮は計測で必要性を判断する。再発確認は line extrusion の GPU 出力で行う。

## 780: MapLibre 全 surface の段階移行

以下は `app/lib/feature/` 相対。各画面の現状を確認し、必要な layer と操作の parity を満たした単位で移行する。

| Surface / source | 完了条件 |
| --- | --- |
| `home/ui/component/map/home_map_view.dart` | base map、EEW推定震度/区域、強震観測点、P/S波、揺れ検知、震源/label、現在地、camera保存/復元、layer/debug control、event |
| `home/ui/page/home_map_bounds_selector_page.dart` | pan/zoom、visible region取得、bounds保存 |
| `live_monitor/ui/components/live_monitor_map_host.dart` | realtime/history layer、automatic focus、map所有権とevent |
| `eew/ui/components/eew_details_map_view.dart` | forecast region、static/simulation P/S波、震源、表示範囲 |
| `earthquake_history/ui/components/earthquake_history_details_map_view.dart` | region/city、推計震度、Shindo DB、station、震源/誤差、mode、fitBounds、popup |
| `intensity_history/ui/intensity_history_page.dart` | prefecture/city、click/long-click、drill-down/back、fitBounds、modal |
| `region_selection/ui/component/region_selection_map.dart` | 行政区域・震央地名のtap解決、単一／複数選択highlight、loading／retry、選択確定 |
| `tsunami/ui/components/tsunami_details_map_view.dart` | warning coastline、震源、station/state、fitBounds、style lifecycle |
| `seismicity/ui/seismicity_page.dart` | epicenter、color/span、矩形選択、座標変換、analysis panel |
| `settings/children/config/debug/hinet_seismicity/ui/hinet_seismicity_page.dart` | epicenter、filter、矩形選択、座標変換、analysis panel |

- 揺れ検知履歴画面は現在削除済み。再導入する場合だけ typed polygon fill/line と fitBounds を移行対象へ戻す。
- Intensity History と Earthquake History details は render hit で layer を識別した後、地理座標から最近傍 region/city/station を解決する二段階 query を fixture 化する。Home の gate にはしない。
- 全 surface 共通の完了条件: layer順、Light/Dark、loading/degraded/error、camera/gesture/fitBounds、必要な hit test が一致する。全 consumer/test/debug route 移行後に MapLibre package、event/queue/style helper、platform asset 連携を削除する。`lockBearing` 設定/UI は rotation policy 決定まで維持する。

## 780: 共通地域選択の実機確認

- `app/lib/feature/region_selection` の一覧・地図・単一／複数選択は自動テストで確認する。iOS/Android の native 地図表示と hit test は未検証。
- Asset Pack v0.1 を使い、都道府県・観測用細分区域・通知EEW区域・市区町村・震央領域のタップと選択highlightを確認する。震央の海域、境界上の複数候補、地図領域のない地名の一覧選択、旧packの案内も確認する。
- 種別・一覧／地図切替、連打、選択解除中のlookup完了、戻る、theme変更、background復帰で選択が復活せず、layer重複・例外がないことを確認する。
- 小画面・文字拡大で選択確認欄と候補ボタンが操作できることを確認し、端末・OS・build modeと結果を記録する。

## 770 / 450: Web と将来 surface

- 770: `packages/pmtiles_v3/lib/src/reader/pmtiles_v3_file_random_access_reader.dart` と `packages/eqmonitor_map/lib/src/tile/base_map_tile_repository.dart` の local/remote 両 import chain を条件分岐し、web reader を設計する。remote reader だけの stub 化では完了しない。完了条件は barrel import を含む Web CI build。
- 450: 初期 iOS/Android の性能・障害時挙動を確立後、macOS/Windows/Linux、線上ラベル・文字回転、公開可能な API 境界を定義し、対象 platform の build/smoke を追加する。

## 700 / 650: 回転・3D camera

- 700: bearing/pitch/perspective 導入前に `LineMeshBuilder` → `BaseMapGeometryFactory` / packed mesh → `base_map_line.fmat` の押し出しを中心線と同じ行列の線形部で変換する。現在の Y反転だけの契約は north-locked 正射影用。
- 650: `altitudeMeters` / XYZ を維持し、camera/projection/renderer に bearing/pitch、透視投影、地形/3D地物、地下震源、断層面を追加する。地表・地下・overlay の render phase/depth policy を先に定義する。
- 完了条件: 回転・傾斜・透視で線幅/法線、地下の depth、overlay 順序が正しい fixture と可視確認。参照: `.cursor/rules/map-renderer-references.mdc`。
