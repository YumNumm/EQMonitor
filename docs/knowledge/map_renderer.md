# eqmonitor_map の設計・GPU 検証

確認日: 2026-09-21。対象: `packages/eqmonitor_map` と `third_party/flutter_scene`。
本書は維持する設計契約と検証方法の要約であり、全 surface の移行・実機性能の完了記録ではない。
詳細設計は [レンダラ設計](../superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md)、参照実装は [固定参照](map_renderer_references.md) を読む。

## 所有境界

- 公開 API は不変の `MapNode` ツリー、内部 `MapElement` が key/type で mount/update/unmount する。Flutter 内部 Element API に依存しない。
- foundation は Widget・network client・GeoJSON・Style JSON・Flutter Scene 型を所有しない。GPU/HTTP/controller は DTO に入れず、Scene 型は adapter に閉じる。
- 動的描画は typed snapshot/delta/packed payload を使い、hot path の JSON serialization や geometry の deep equality を避ける。
- full snapshot は完全な集合。source instance、revision、digest と deep ownership を検証して atomic commit する。同 revision は同一 identity のときだけ no-op。
- delta の stale/duplicate/gap/branch、重複 upsert/removal は atomic に拒否し、より新しい authoritative full による resync を要求する。別 source の delta で現在値を変えない。
- frame ごとに wall/monotonic clock を一度 capture し、camera・viewport・DPR・revision・context generation と共に snapshot へ固定する。
- freshness と load state は分離する。receipt age は monotonic、未来 skew/expiry は version 付き policy で判定する。expired hazard/location は描画・animation を止め、typed unavailable にする。
- async completion は element/source incarnation を確認する。GPU resource は submission completion または検証済み frames-in-flight 方式で退役させる。

## 座標・順序・データ契約

- 初期 surface は iOS/Android、北固定・真上視点。残存 MapLibre 用 `lockBearing` は移行完了まで維持する。
- Geographic/Mercator/Tile Local/Camera-relative World/Screen を分ける。高度は地表 0・地下負・地上正。GPU は origin rebasing で精度を保ち、3D は projection/renderer を拡張する。
- P/S 波は geodesic meter radius から計算する。Mercator 平面上の円で置換しない。
- 基図は layer が宣言する extent を用い、tile-local geometry を再利用する。camera 行列は CPU double で `viewProjection * tileMatrix` を合成し、identity projection の `NodeCamera` と node transform に一度だけ渡す。
- line extrude は clip/NDC 空間、半線幅も viewport に対応する単位へ揃える。spike の未確認 camera 経路を可視出力の根拠にしない。
- canonical `RenderSortKey` を描画・逆順 hit test の正本にする。phase 内だけ宣言順を使う。label/leader line は `labelForeground`。
- overlay は base 0 → region 100 → city 200 → observation 300 → label 400 を共通 policy で定義する。region/city の切替は zoom 6 境界で確認する。
- Filament fill には straight alpha（opacity は alpha だけへ）、raw observation fragment は `vec4(rgb * alpha, alpha)` を出す。二重 premultiply を避ける。
- label asset は Point の地理 anchor を一つ持つ。実測文字サイズと DPR による screen placement 候補・leader line は renderer が生成する。
- label rollout 前に schema・producer validator・digest-bound signed sidecar を用意する。archive 全走査を runtime に課さず、既存 asset ID の隣に version 付き sidecar を配布する。
- app が manifest trust/size/hash、key rotation/revocation、sequence rollback、期限を検証し、immutable descriptor を package へ渡す。未検証・期限切れの新 renderer は fail closed とする。詳細な実装状況は TODO と照合する。

## メモリ・性能

- tile cache key は source instance/revision/digest、Z/X/Y、world wrap を含む。hazard は revision を跨いで last-good tile を表示しない。
- tile/layer/material 単位で batch する。packed packet は version・layout・pipeline・material・phase が適合する連続 packet だけをまとめ、transform table は immutable に保持する。
- 大量静的点群は `Matrix4` オブジェクトを各 frame で再 pack せず、固定長 record と永続 GPU buffer を用いる。球表示は共有 quad の impostor とし、投影 pixel 径で LOD を選ぶ。
- observation は単一 instance stream/node（28-byte stride）。camera-only で snapshot が同一なら再利用し、snapshot identity・context generation・background・dispose で旧 generation を retire する。
- 候補の preflight/submit 失敗時は commit せず base-only に戻す。GPU completion 待ちを「次 frame が来た」ことだけで代用しない。
- metrics は bounded/rate-limited。queue 待機、実行、submission/completion、current/peak memory を分ける。valid sample は detailed sampling/drop の前に aggregate へ入れる。

## shader と platform 検証

- shader/material は build hook の Dart Data Assets。`.shaderbundle`・`.fsceneb`・`.fstex` は commit や `flutter.assets` 列挙をせず、source と hook を管理する。
- app は `app/pubspec.yaml` の `flutter.config.enable-dart-data-assets` で有効化済み。example など project 設定のない実行対象は `mise exec -- flutter config --enable-dart-data-assets` または明示的な環境設定が必要。
- `dataAssetsRequired` の hook は `config.config.buildDataAssets` が true の場合だけ動かす。通常テストと data-assets 有効時の shader compile を両方確認する。
- Data Assets を有効にした直後は `AssetManifest.bin` が古い場合がある。ファイル実在だけでなく manifest 登録を確認し、再 build・必要なら対象 package の clean 後に再起動する。hot restart だけでは直らない。
- 実 API event と verified Asset Pack を照合し、production decoder で source layer・extent・region/city code・decode error を分けて調べる。station→city は metadata で解決する。
- source-layer 欠落や invalid code は coverage 不完全として扱い、水域・国外だから完全と推測して banner を消さない。
- iOS/Android の profile/release で mesh、material、TextPainter、partial update、resize、background 復帰、context rebuild、dispose/remount、例外 counter を確認する。GPU skip や unit test 成功はこの証拠にしない。
- 過去の Simulator region fill 成功は city/observation、zoom 5.999/6、実機復帰の成功を意味しない。未確認項目は TODO へ集約する。

`packages/eqmonitor_map/` で関連する既存テストを実行する例:

```sh
mise exec -- flutter test test/foundation test/geo/tile_matrix_test.dart --dart-define=CI=true
FLUTTER_DART_DATA_ASSETS=true mise exec -- flutter test test/renderer/observation_point_batch_builder_test.dart --dart-define=CI=true
```

関連: [PMTiles](pmtiles.md) / [MapLibre](maplibre.md)
