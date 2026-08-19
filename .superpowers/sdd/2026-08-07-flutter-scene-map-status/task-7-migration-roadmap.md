# Task 7: MapLibre Native 完全撤去までの移行ロードマップ

調査日: 2026-08-07

## 前提

現在の `packages/eqmonitor_map` は foundation / alpha 手前である。PMTiles → MVT decode → Fill/Line mesh → Flutter Scene への縦切りと debug page の `BaseMapView` は存在するが、本番 surface は 11 面すべて `MapLibreMap` を直接 host している。`EqmonitorMapView`、`EqmonitorMapController`、`MapScene`、typed `MapNode`、reconciler は未実装であり、Home Map や EEW 表示面を置き換えられる公開 API ではない。

設計正本 `docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md` は、初期対象を iOS / Android、北固定・真上視点、MapLibre Style JSON 非互換、型付き独自レイヤー、`MapScene` 宣言と `EqmonitorMapView`、typed snapshot/delta、fresh/stale/expired、PMTiles signed sidecar attestation、性能観測基盤を必須としている。このロードマップはその設計を正本とし、`docs/todo/780_eqmonitor_map_maplibre_surface_migrations.md` と `docs/todo/800_eqmonitor_map_deferred_verification.md` の gate を移行順へ展開する。

## EEW 表示面を移行する前に必ず満たす条件

Home Map、Live Monitor、EEW details など EEW を表示する surface は、次を満たすまで移行しない。

- renderer correctness debt のうち、MVT extent 伝搬、tile buffer clip/scissor、ancestor fallback 重複描画、Line flood 修正後の視覚証跡は解消済みであること。line join/cap は MapLibre parity の不足を fixture と visual evidence で評価し、miter/butt 継続でよい product 承認、または bevel/round/cap 実装のどちらかを完了すること。
- `EqmonitorMapView`、`EqmonitorMapController`、`MapScene`、typed `MapNode` tree、reconciler、`MapFrameSnapshot` が実装され、描画中に JSON や固定 fallback を通らないこと。
- EEW 推定震度、警報区域、強震観測点、P/S 波、揺れ検知、震源、現在地が、設計正本の full snapshot / delta、revision、digest、fresh/stale/expired、expired fail closed 契約を満たすこと。
- camera / controller / event parity として、保存・復元、`fitBounds`、`getVisibleRegion` 相当、gesture policy、map event delivery、北固定と legacy `lockBearing` 維持方針が fixture 化されていること。
- labels、Light/Dark、loading/degraded/error、semantics、性能観測、物理 iOS / Android profile/release smoke が通り、EEW hazard が古い revision や expired 状態で描かれ続けないこと。
- Asset Pack の PMTiles と label Point layer について、manifest digest/size、signed sidecar、semantic summary、rollback/replay 拒否が検証済みであること。

## Product decision blockers

- 最初の本番移行 surface を「低リスク debug/simple surface」から始めるか、「初期 renderer の主対象である Home Map」から始めるか。推奨は後述のとおり Home 表示範囲 selector を production canary、Home Map を最初の EEW production migration とする。
- Line join/cap parity をどこまで初期移行 gate に含めるか。miter + butt のまま進めるなら、行政界・海岸線・警報区域での見た目劣化を product が明示承認する必要がある。
- labels の leader line policy、重要 label の semantics 対象、Light/Dark の視認性閾値。
- `lockBearing` 設定/UI の削除タイミング。設計正本と todo 780 は、legacy MapLibre consumer が残る間は維持し、全 surface 移行後に別途承認としている。
- Performance regression threshold。例: frame build/raster、decode、mesh build、GPU upload、cache memory、event drop の許容値は未決定であり、HUD と benchmark 実装時に product/engineering gate として固定する。
- Seismicity / Hi-net seismicity の 2D 移行を先に行うか、`docs/todo/650_eqmonitor_map_3d_camera.md` の bearing/pitch/地下表示まで待つか。MapLibre 削除を優先するなら 2D parity で先に移行し、3D は future scope に残す判断が必要。

## Phased roadmap

### Phase 0: Baseline and gate freeze (S)

**Goal:** 今日の状態から移行判定に使う正本を固定し、古い README / TODO 記述と実装状態の不一致を消す。

**Deliverables:**

- `status-report-draft.md`、task 1-4 report、設計正本、todo 780 / 800 を移行 checklist へ統合する。
- renderer claim を「Base layer PMTiles drawing has a solid unit-tested foundation, but post-fix visual verification pending」として固定する。
- MapLibre surface 11 面の owner、risk、必要 API、EEW 有無、`queryLayers` 有無、camera/controller 依存を matrix 化する。

**Exit criteria:**

- 各 surface について、移行に必要な `MapNode`、controller API、dynamic layer、hit test、label、verification が列挙されている。
- stale な flood/Line 記述が「修正コミットあり、修正後 visual evidence 未取得」に更新されている。
- EEW surface migration precondition が承認済み gate として扱える。

**Risks:**

- checklist だけを更新して renderer confidence が上がったように見えること。実装・検証の gate ではない。

### Phase 1: BaseMapView stabilization slice (M)

**Goal:** debug/foundation renderer のベース地図 correctness debt を閉じ、以降の公開 API 実装の土台にする。

**Deliverables:**

- `BaseMapTileGeometry` へ MVT layer extent を伝播し、設計正本の「MVT extent は固定値ではなく tile ごとに layer 宣言値を読む」を満たす。
- Fill/Line の tile buffer clip/scissor を実装し、tile 境界・buffer・hole 実 tile fixture を追加する。
- ancestor fallback が同一 geometry を複数 visible tile で重複描画しない render set を実装する。
- Line flood 修正後の simulator / device screenshot evidence を取得し、line width、background、tile boundary、pinch zoom、fallback を確認する。
- line join/cap の不足を visual fixture 化し、miter + butt 継続可否を product decision に上げる。

**Exit criteria:**

- `packages/eqmonitor_map` の unit tests に extent 4096 以外、実 tile hole、tile boundary clip、fallback duplicate 排除が入っている。
- iOS と Android の少なくとも物理端末 profile/release で manual smoke checklist が記録されている。
- flood/Line 修正後の evidence があり、README / TODO / report が同じ状態を説明している。

**Risks:**

- Flutter Scene / Flutter GPU の pre-1.0 挙動に依存するため、device ごとの差が出る可能性がある。
- clip/scissor や fallback 排除で性能・メモリ budget が変わる。

### Phase 2: Verification layer and observability (L)

**Goal:** 生命に関わる表示の移行可否を、目視だけでなく自動・計測で判断できる状態にする。

**Deliverables:**

- `BaseMapView` / future `EqmonitorMapView` の widget tests: pan、pinch、loading、degraded、failed、background/resume。
- Golden tests: 固定 PMTiles、viewport、DPR、Light/Dark、text scale、Fill/Line/label、tile boundary。
- Performance benchmarks: frame、queue wait、decode、mesh build、GPU upload、cache、label placement。
- Regression thresholds: p50/p95、max frame budget、memory budget、event drop、instrumentation overhead。
- Performance HUD: 設計正本の `ValueListenable<MapPerformanceSnapshot>` と `Stream<MapPerformanceEvent>` を可視化する debug UI。
- CI gate: unit/widget/golden/benchmark smoke と Android/iOS profile/release build の関係を明確化する。

**Exit criteria:**

- renderer PR が描画結果、操作、性能の regression を検出できる。
- performance HUD の metrics と benchmark metrics が同じ項目名・単位で追える。
- threshold 超過時に PR を止める項目と、手動確認に回す項目が明示されている。

**Risks:**

- Golden は Flutter Scene / GPU / font / DPR 差分で flake しやすい。
- thresholds を甘くすると生命安全 surface の性能劣化を見逃し、厳しすぎると開発が止まる。

### Phase 3: Production public API and reconciler (XL)

**Goal:** debug `BaseMapView` から脱却し、本番 surface が使う宣言的 API を実装する。

**Deliverables:**

- `EqmonitorMapView(controller: scene:)`、`EqmonitorMapController`、`MapScene`、typed `MapNode` tree。
- `MapNode → MapElement → MapRenderObject` reconciler、key/type/revision による mount/update/unmount。
- `MapFrameSnapshot`: `MapClock` 注入、wall/monotonic capture、camera、viewport、DPR、source/layer revision、lifecycle、context generation。
- render phase と canonical `RenderSortKey`。描画順と hit test 順の正本を設計どおり固定する。
- controller API: camera save/restore、animate/jump、`fitBounds`、`getVisibleRegion` 相当、screen/geographic conversion、event delivery、dispose。
- gesture policy: 初期は北固定・真上視点、rotation gesture 無効。legacy MapLibre consumer が残る間は `lockBearing` 設定/UI を維持する。

**Exit criteria:**

- fake adapter を使った reconciler tests で mount/update/reorder/unmount、async cancellation、source交換、dispose、context generation rebuild が検証されている。
- 既存 MapLibre controller 依存のうち、Home 表示範囲 selector と Home Map に必要な API が parity fixture を持つ。
- `BaseMapView` は debug/foundation として残せるが、本番実装は `EqmonitorMapView` に集約されている。

**Risks:**

- 公開 API を早く固定しすぎると、dynamic layer や labels の要求で破壊的変更が必要になる。
- Flutter Widget lifecycle と renderer lifecycle の境界を誤ると、古い async 結果が hazard state を復活させる。

### Phase 4: Asset Pack, PMTiles labels, and attestation (L)

**Goal:** base PMTiles と label Point layer を信頼できる source として扱い、未検証 archive を新 renderer に mount しない。

**Deliverables:**

- backend 側 prerequisite: 既存 `BASE_MAP_PMTILES` に versioned label Point layer を後方互換追加し、semantic validator と signed sidecar を生成する。
- app 側: sidecar discovery/download/readback、Ed25519 signature、keyId、expiry、sequence、rollback/replay、manifest/archive digest binding を検証する。
- package 側: verified source descriptor と PMTiles header/metadata/semantic summary の整合確認。
- label Point layer の schema fixture: anchor、stable ID、text、priority、zoom range、property type。

**Exit criteria:**

- missing/invalid/revoked/expired sidecar、digest mismatch、rollback、同一 sequence 異 digest が typed verification error になり、新 renderer が fail closed で unavailable を表示する。
- 旧 client は manifest v1 と既存 asset ID のまま動作し、新 client は sidecar なしに base/label source を mount しない。
- release artifact digest と attestation fixture が CI で検証される。

**Risks:**

- backend release sequence と app rollout がずれると、production renderer を有効化できない。
- key rotation / rollback policy を誤ると、古い地図データを信頼してしまう。

### Phase 5: Label renderer (L)

**Goal:** PMTiles label anchor を `TextPainter` overlay と semantics へ接続し、MapLibre label 依存を外す。

**Deliverables:**

- PMTiles Point layer から label candidate を収集し、source/layer/stable ID/world wrap で重複排除する。
- `TextPainter` measurement cache: text direction、locale、font generation、TextScaler、DPR、theme を key に含める。
- right/left/up/down placement、collision、screen edge adjustment、hysteresis、leader line policy。
- label foreground phase と canonical `RenderSortKey` による描画 / hit test ordering。
- decoration label と防災上重要 label の semantics policy。

**Exit criteria:**

- label overlap、priority、zoom 境界、Light/Dark、text scale、DPR、locale/theme invalidation の golden/widget tests がある。
- leader line と semantics の product decision が確定している。
- Home Map label と debug base map label が MapLibre なしで表示できる。

**Risks:**

- label collision は目視品質と性能の両立が難しい。
- 重要 label の semantics 対象を誤ると、アクセシビリティ上のノイズまたは情報欠落になる。

### Phase 6: Typed dynamic layers and freshness contract (XL)

**Goal:** EEW / 地震 / 現在地の動的表示を GeoJSON / MapLibre children から typed snapshot/delta へ移す。

**Deliverables:**

- dynamic source model: `sourceInstanceId`、`snapshotRevision`、digest、stable Feature ID、full snapshot、delta upserts/removals、gap/branch latch。
- freshness model: `observedAtUtc`、`receivedAt`、`staleAfter`、`validUntil`、`fresh/stale/expired`、expired fail closed。
- typed layers:
  - EEW estimated intensity。
  - EEW warning regions。
  - Kyoshin Monitor observation points。
  - P/S wave circles with geodesic radius。
  - Shake detection polygons/points。
  - Hypocenter and error/uncertainty。
  - Current location with accuracy/course/pulse/unavailable reason。
- renderer update path: point projection cache、flat grid index、instance buffers、Feature ID range update。
- stale/expired UI, semantics, performance event, reduced motion / background behavior。

**Exit criteria:**

- full snapshot / delta の duplicate、stale、gap、branch、conflicting equal revision、sourceInstanceId 交換失敗がすべて fixture 化されている。
- fake `MapClock` で fresh/stale/expired、wall clock skew、background/resume、expired animation stop が検証される。
- expired hazard と expired current location は描画されず、typed unavailable state が UI に公開される。
- Home Map に必要な全 dynamic layer が `MapScene` で表現できる。

**Risks:**

- revision / digest / expiry の扱いを誤ると、古い EEW 情報を新しい情報として表示する。
- P/S 波を Mercator 平面円で代用すると距離表示が不正確になる。設計正本どおり geodesic meter radius を使う必要がある。

### Phase 7: Hit testing and `queryLayers` parity (M)

**Goal:** MapLibre `queryLayers` に依存する 2 surface を移行できる query API を作る。

**Deliverables:**

- `MapQueryRequest`: logical pixel point/box、target layer keys、hit tolerance。
- committed `MapFrameSnapshot` と空間 index だけを同期検索し、network/decode を開始しない query 実装。
- Fill hole、Line width、icon/label bounds、visibility、min/max zoom、filter、render sort key に基づく hit 判定。
- `MapQueryResult`: source/layer/Feature ID、typed properties、provenance、deduplicated tile/wrap。
- parity fixtures:
  - Intensity History: city/region source layer hit、tap 地理座標から最寄り JMA region/city、drill-down/modal。
  - Earthquake History details: station、Shindo DB station、city/region hit、popup。

**Exit criteria:**

- Intensity History と Earthquake History details の既存 `queryLayers` caller が、新 API の fixture で同じ user-visible result を返す。
- Home migration gate には含めないが、全 MapLibre 削除前には必ず完了している。

**Risks:**

- 描画 geometry と hit geometry がずれると、タップ対象が表示と一致しない。
- properties / feature ID decode が未完成だと query result が作れない。

### Phase 8: Non-EEW production canary: Home 表示範囲 selector (M)

**Goal:** 最初の production migration として、EEW hazard を表示しないが controller parity が必要な surface を移す。

**Deliverables:**

- `home_map_bounds_selector_page.dart` を `EqmonitorMapView` へ切り替える feature flag / debug rollout。
- pan/zoom、custom bounds overlay、`getVisibleRegion` 相当、保存 flow、loading/degraded/error。
- Light/Dark と physical device smoke。

**Exit criteria:**

- MapLibre と Scene で同じ initial camera、visible region、保存 bounds が fixture と manual smoke で一致する。
- EEW dynamic layer なしで本番 UI に `EqmonitorMapView` を載せた lifecycle / controller 問題が解消されている。

**Risks:**

- 低リスク surface だが、Home Map 本体の dynamic layer risk はまだ下がらない。
- canary 用 feature flag が恒久化すると分岐が増える。

### Phase 9: First EEW production migration: Home Map behind gated rollout (XL)

**Goal:** 初期 renderer の主対象である Home Map を、MapLibre path を残したまま gated rollout で移行する。

**Deliverables:**

- Home Map の base map、labels、EEW estimated intensity、warning regions、Kyoshin observation points、P/S waves、shake detection、hypocenter、current location を typed `MapScene` に接続する。
- camera save/restore、layer/debug control、map event delivery、現在地 permission/lifecycle/error、Light/Dark、loading/degraded/error。
- rotation gesture disabled / north fixed。legacy `lockBearing` は残す。
- parallel parity mode: same input snapshots を MapLibre path と Scene path に流し、camera/event/hazard freshness/performance を比較する。
- staged enablement: debug only → internal dogfood → limited production flag → default on。MapLibre fallback はこの phase では削除しない。

**Exit criteria:**

- todo 780 の Home Map 項目が満たす base map、dynamic layer、camera、current location、event、label gate を objective tests と physical smoke で通す。
- expired EEW / stale observation / invalid current location が fail closed になることを automated test と manual scenario で確認する。
- performance threshold を Home traffic 相当で満たし、HUD / event stream で退行を検出できる。

**Risks:**

- Home Map は最高 traffic かつ最高 stakes であり、最初に直接移行すると blast radius が大きい。
- MapLibre fallback を残す期間は二重実装となり、snapshot 変換の差分がバグ源になる。

### Phase 10: Realtime and EEW detail surfaces (L)

**Goal:** Home と同種の EEW / realtime layer を使う surface を、Home で固めた contract の再利用で移す。

**Deliverables:**

- Live Monitor: Home 相当 realtime layer、earthquake history layer、automatic focus、map instance ownership、event delivery。
- EEW details: forecast region、static/simulation P/S wave、hypocenter、fit bounds。
- shared scene builders / typed layer factories。ただし hidden fallback や固定値は入れない。

**Exit criteria:**

- Home で使った dynamic snapshot/delta/freshness fixtures を再利用し、surface 固有 camera / focus / fitBounds parity が通る。
- Live Monitor と EEW details の MapLibre direct host が消える。

**Risks:**

- automatic focus や simulation P/S wave が Home より複雑な continuous frame を要求する。
- Home 用に最適化した scene composition が details surface の静的表示に過剰な可能性がある。

### Phase 11: Post-event history and query-heavy surfaces (L)

**Goal:** 地震履歴・震度履歴の詳細表示と drill-down を MapLibre query なしで移す。

**Deliverables:**

- Earthquake History details: region/city fill、estimated intensity、Shindo DB fill/station、observation station、hypocenter/error、display mode、fitBounds、tap popup。
- Intensity History: prefecture/city fill、click/long-click、drill-down/back、fitBounds、detail modal。
- Phase 7 の `MapQueryRequest` / `MapQueryResult` parity を production caller に接続する。

**Exit criteria:**

- 既存 user flow の tap target、popup content、drill-down/back、fitBounds が parity fixtures で一致する。
- `MapController.queryLayers` の app production caller が 0 になる。

**Risks:**

- query result と JMA nearest resolver の二段階処理が surface ごとに違う。
- hit test の tiny geometry / overlapping label / station ordering が見た目と一致しないと誤選択につながる。

### Phase 12: Remaining production surfaces (L)

**Goal:** MapLibre direct host を残りの production surface から順に消す。

**Deliverables:**

- Region picker: tap geographic coordinate から JMA region resolve、loading、選択確定。
- Tsunami details: warning coastline、hypocenter、observation station、station state、fitBounds、style resource lifecycle 相当。
- Shake Detection history details: event polygon fill/line、fitBounds、typed Polygon。
- Seismicity: epicenter points、color/span変更、矩形選択、screen/geographic conversion、analysis panel。

**Exit criteria:**

- 各 surface で base map、layer order、Light/Dark、loading/degraded/error、camera、gesture、fitBounds、必要な hit test が fixture 化されている。
- production route から `MapLibreMap` host が消える。

**Risks:**

- Tsunami coastline や Shake Detection polygon は EEW とは別の防災情報であり、同じ freshness / error policy を無批判に流用できない。
- Seismicity は将来 3D scope と重なる。MapLibre 削除を優先する 2D parity と、将来 3D の product 期待を分離する必要がある。

### Phase 13: Debug and future-scope surfaces (M)

**Goal:** MapLibre 削除を阻む debug / future-adjacent surface を整理する。

**Deliverables:**

- Hi-net Seismicity debug: epicenter point、filter、矩形選択、screen/geographic conversion、analysis panel。
- Existing MapLibre debug routes / helper usage の棚卸し。
- `docs/todo/650_eqmonitor_map_3d_camera.md` と `docs/todo/450_eqmonitor_map_future_surface.md` の範囲を、MapLibre removal blocker と future enhancement に分離する。

**Exit criteria:**

- debug route、test、example を含め `MapLibreMap` import が production app から消える。
- 3D camera、desktop/Web、線上ラベル、汎用 package 化は MapLibre removal の blocker ではないと明示されている。

**Risks:**

- debug-only と見なした surface が運用調査に使われている可能性がある。
- Seismicity debug を急いで 2D 移行すると、後の 3D seismicity 設計と重複する。

### Phase 14: MapLibre removal endgame (M)

**Goal:** 全 surface 移行後にだけ MapLibre 依存、provider、operation queue、platform assets を削除する。

**Deliverables:**

- repo-wide search で `package:maplibre`、`MapLibreMap`、`MapController` MapLibre methods、style/source/layer helper、GeoJSON update helper の production reference が 0。
- `MapLibreEventProvider` と `MapOperationQueueScope` の全 consumer 移行後削除。
- `maplibre` package dependency、dependency override、platform asset/config、iOS/Android integration の削除。
- `lockBearing` 設定/UI は、全 surface の rotation policy 決定と別途承認後に削除する。
- CI / tests / docs / debug menu から MapLibre 前提を除去する。

**Exit criteria:**

- app build、analyze、tests、profile/release build が MapLibre なしで通る。
- MapLibre platform artifacts が iOS / Android bundle に残っていない。
- rollback plan が「MapLibre path へ戻す」ではなく、`eqmonitor_map` feature flag / release rollback / asset attestation rollback policy で成立する。

**Risks:**

- 1 つでも hidden import / platform asset / test helper が残ると削除 PR が不安定になる。
- MapLibre fallback を削除した後は、`eqmonitor_map` 側の degraded/failed 表示と rollout control が唯一の安全弁になる。

## Recommended first production surface

最初の production migration は **Home 表示範囲 selector** を推奨する。理由は、EEW hazard を表示せず、必要能力が pan/zoom、visible region、bounds 保存、loading/error、Light/Dark に限られるため、`EqmonitorMapController` と lifecycle の本番投入を小さく検証できるからである。

ただし、最初の **EEW production migration** は **Home Map** とする。todo 780 と設計正本はいずれも Home Map を初期 renderer の対象としており、Home を避けて Live Monitor や EEW details を先に移すと、結局 Home と同じ EEW dynamic layer / camera / label / current location 契約を別 surface で先に作ることになる。Debug/simple surface を最初に選ぶ案は blast radius は低いが、すでに debug page の `BaseMapView` が存在するため、次に必要なのは本番 controller/lifecycle canary であり、EEW layer の安全性を証明する代替にはならない。

Home Map を最初に直接移行しない理由は、最高 traffic かつ最高 stakes で、未実装の production API、dynamic freshness、labels、attestation、performance regression が同時に露出するためである。したがって順序は、Home 表示範囲 selector で production shell を検証し、その後に Home Map を gated rollout する。

