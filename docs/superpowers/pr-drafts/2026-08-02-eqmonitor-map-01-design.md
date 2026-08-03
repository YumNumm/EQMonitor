# Summary

- Base: `develop`
- Head: `codex/eqmonitor-map-01-design`
- EQMonitor専用Flutter地図レンダラーの設計正本、package README、運用知見、将来TODOを整備します。
- 設計成果は8ファイルで、すべてdocumentation-onlyです。このPRではFlutter packageやrendererの実装、既存MapLibre surfaceの変更は行いません。

# Why

緊急地震速報など生命に関わる表示を扱うため、MapLibre Nativeからの段階的な移行に先立ち、描画・データ鮮度・入力検証・GPU resource lifecycle・障害時挙動の契約を固定する必要があります。

特に、Flutter Sceneの成熟度を実機で確認するgate、PMTiles/MVTとAsset Packの信頼境界、動的hazard dataのatomic updateとexpiry、既存MapLibre pathを維持した段階移行を、実装着手前のreview対象として明文化します。

# Scope

- [`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md`](../specs/2026-08-02-eqmonitor-map-renderer-design.md): 公開境界、座標系、tile pipeline、label、hit test、cache/error、性能観測、移行gate、stacked deliveryを定義します。
- [`packages/eqmonitor_map/README.md`](../../../packages/eqmonitor_map/README.md): packageの目的、初期スコープ、設計原則、delivery graphを記録します。package自体はまだ作成しません。
- [`docs/knowledge/20260802_eqmonitor_map_renderer_constraints.md`](../../knowledge/20260802_eqmonitor_map_renderer_constraints.md): 今後の実装で維持する安全・互換性・性能上の制約を記録します。
- [`docs/knowledge/20260802_kevi_map_renderer_reference.md`](../../knowledge/20260802_kevi_map_renderer_reference.md): KEViから参照した知見と、採用しない境界を固定します。
- `docs/todo/`の4ファイル: 初期PRに含めないsurface拡張、3D camera、MapLibre surface移行、追加検証を追跡します。

# Architecture / safety highlights

- 公開APIは不変かつ型付きの`MapScene` / `MapNode`ツリーとし、内部の`MapElement` / `MapRenderObject`がkeyとnode型でreconcileします。描画hot pathではGeoJSONやJSON serialization、geometryのdeep equalityを使いません。
- Flutter Scene型はadapter内へ隔離し、Flutter SDKとFlutter Scene revisionを固定します。foundation実装前にiOS/Android実機spikeを通し、gateを満たせない場合は実装を進めず設計を更新します。
- PMTiles/MVTはlocal/remoteを問わずuntrustedなbounded inputとして扱います。appがmanifest、archive size/hash、署名済みsidecarを検証したimmutable descriptorだけをpackageへ渡し、missing/unknown/invalid/expiredなattestationでは新rendererをmountしません。
- remote range取得はidentity encodingとstrong validatorを必須とし、validatorやtotal length、`Content-Range`、body lengthが不一致なら取得済みbyteを破棄します。壊れた入力を空tileや固定値へfallbackしません。
- 動的sourceは`sourceInstanceId`とrevisionを持ち、full snapshot / deltaを完全検証後にatomic commitします。gapやbranchではdelta受付を止め、より新しいauthoritative full snapshotでのみ復旧します。
- freshnessはload stateから分離し、注入したmonotonic clockで`fresh` / `stale` / `expired`を評価します。expiredなhazardと現在地はanimationを止めて描画せず、typed unavailableへfail closedします。
- 描画順とhit test順はphaseを含むcanonical `RenderSortKey`を唯一の正本とし、async continuation、source identity、GPU completion/context generationを分離して古い結果やresourceを再利用しません。
- Home移行で新rendererの回転gestureは無効化しますが、既存MapLibre pathと共有`lockBearing`設定/UIは全surfaceのparity確認が完了するまで残します。

# KEVi research attribution

設計上の先行調査として、MIT License（Copyright © 2019 ingen084）の[`ingen084/KyoshinEewViewerIngen`](https://github.com/ingen084/KyoshinEewViewerIngen/tree/5a2bf513b6b9c93ee06473f70b6d27ee96070b3f)を固定commit `5a2bf513b6b9c93ee06473f70b6d27ee96070b3f`で参照しています。

UI/render間state snapshot、phase内のordered layer、array-backed point data、実測文字サイズに基づくscreen label placementを参考にします。一方、Web Mercator、tile cover、overzoom、world wrap、MVT/PMTiles処理や、EQMonitor固有のrevision/freshness/fail-closed policyはKEVi由来とせず、Miller projection、全`SKPicture` invalidation、次frameでのGPU resource disposeなども採用しません。

# Stacked follow-ups

先に別repositoryの`eqmonitor-backend`で`B1-label-asset-release`を独立して完了し、後方互換なlabel Point layer、global validator、署名済みsidecar、release fixtureを提供します。これはGit ancestryではなくrelease artifact contractとして依存します。

EQMonitor側はこのDesign PRを起点に、次の順でstackします。

1. `02-scene-spike`: minimal compilable scaffold、adapter prototype、iOS/Android実機gate
2. `03-foundation`: 型付きモデル、座標、reconciler、frame/render契約、性能観測
3. `04-tile-pipeline`: verified source、PMTiles/MVT、remote range fixture、worker/cache
4. `05-label-asset-integration`: backend fixture、sidecar検証、Asset Pack境界
5. `06-scene-renderer`: Flutter Scene adapter、Fill/Line、GPU lifecycle
6. `07-labels`: placement、collision、TextPainter overlay、semantics
7. `08-dynamic-interaction`: atomic delta、camera、現在地、hit test
8. `09-home-integration`: Home Mapの並行検証と北固定移行

# Validation

- Final subagent reviews: clean（最終指摘なし）
- Branch hook: 設計成果8ファイルに対して完了
- Gitleaks: branch上の3コミットを検査済み
- `git diff --check`: pass
- Flutter tests: documentation-onlyのため該当なし。Flutter/Dart実装の動作確認は後続stackで実施します。

# Deferred work

- [`450_eqmonitor_map_future_surface.md`](../../todo/450_eqmonitor_map_future_surface.md): Performance HUD、desktop/Web、線上ラベル、汎用package化
- [`650_eqmonitor_map_3d_camera.md`](../../todo/650_eqmonitor_map_3d_camera.md): bearing/pitch、透視投影、3D地形、地下震源、断層
- [`780_eqmonitor_map_maplibre_surface_migrations.md`](../../todo/780_eqmonitor_map_maplibre_surface_migrations.md): Home以外を含む全MapLibre surfaceのparity確認と段階移行
- [`800_eqmonitor_map_deferred_verification.md`](../../todo/800_eqmonitor_map_deferred_verification.md): Widget/Golden test、iOS/Android実機性能・復帰・memory pressure・context rebuild検証

これらは本PRで実装・検証済みという意味ではありません。各後続PRでcompile、生成、format、analyze、対象test、fixture、実機gateをその時点のscopeに合わせて実行します。
