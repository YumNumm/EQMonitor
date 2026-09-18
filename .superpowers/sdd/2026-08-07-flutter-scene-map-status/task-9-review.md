# Task 9: Line width orientation fix review

**Spec compliance: ✅** — 前回残っていた `LineMesh` doc comment contractの不整合は解消済み。`LineMesh` は `LineMeshBuilder` が生成するtile-local Y-down押し出し法線を保持するproduction/output surfaceとして文書化され、`BaseMapGeometryFactory` が現行orthographic north-locked projection向けにY成分を反転して `texCoords` へ渡すこと、pitch/bearing/perspective対応時はtodo 700に従ってMapLibre-styleの行列変換ベースへ置き換えることも明記されている。

- ✅ 最小修正: `BaseMapGeometryFactory.buildLineGeometryArgs` で `LineMesh.extrudes` のY成分だけを反転し、shader式は `vertex.uv * half_width_ndc` のままにしている。MapLibre-styleの行列変換は実装していない。
- ✅ 符号反転の場所: 実際の符号反転は `packages/eqmonitor_map/lib/src/flutter_scene/base_map_geometry_factory.dart:118-121` の1箇所だけ。`packages/eqmonitor_map/assets/base_map_line.fmat:82` では追加反転していないため二重反転はない。
- ✅ 数学的正しさ: tile-local Y-down法線 `e=(-dy/L, dx/L)` をDart側で `uv=(-dy/L, -dx/L)` に変換し、shaderでclip offset `(uv.x*2h/W, uv.y*2h/H)` を足す。screen logical pxへ戻すと `h*(-dy/L, dx/L)` なので、任意の非ゼロ線分で中心線方向 `(dx/L, dy/L)` とdotが0、長さが `h` になる。
- ✅ miter join: Y反転は線形な反射変換なので、`normalize(prev+next) * miterLength` の非単位長を保つ。screen logical px上では `h * extrude` になり、miterLengthの伸長も維持される。
- ✅ Dart-level test: `packages/eqmonitor_map/test/flutter_scene/base_map_geometry_factory_test.dart:192-224` は `LineMeshBuilder -> buildLineGeometryArgs -> shader式相当 -> screen logical px変換` を通し、horizontal / vertical / 45° / 30° / 135° で直交性と長さを検証している。GPU shader自体は実行せずモデル化しているが、今回の符号反転はDart側の本番経路にあるため、修正箇所はテストで直接覆われている。
- ✅ `.fmat` との整合: `packages/eqmonitor_map/assets/base_map_line.fmat:75-82` はclip/NDC Y-upへ変換済みの `vertex.uv` をそのまま使う説明と式になっており、Dart側のY反転と整合している。
- ✅ doc comment contract: 生成側の `packages/eqmonitor_map/lib/src/mesh/line_mesh_builder.dart:258-261`、production/output surfaceの `packages/eqmonitor_map/lib/src/mesh/line_mesh.dart:3-11` / `packages/eqmonitor_map/lib/src/mesh/line_mesh.dart:29-44`、消費側の `packages/eqmonitor_map/lib/src/flutter_scene/base_map_geometry_factory.dart:40-53` / `packages/eqmonitor_map/assets/base_map_line.fmat:3-10` が同じcontractを説明している。
- ✅ TODO: `docs/todo/700_eqmonitor_map_line_extrude_projection.md` は現在のcontract、orthographic north-locked限定である理由、pitch/bearing/perspective前にMapLibre-style設計が必要なこと、`docs/knowledge/20260805_maplibre_native_renderer_reference.md` 参照を含んでいる。
- ✅ tile-boundary scope: scissor/clipやancestor fallback dedupeは触っていない。
- ✅ logic changes in review fix: `/tmp/line-mesh-doc-fix.diff` は `packages/eqmonitor_map/lib/src/mesh/line_mesh.dart` のdoc commentのみを変更しており、constructor、fields、types、runtime codeには変更がない。
- ✅ commit: report上もdiff上もcommitはしていない。

**Code quality: Approved**

## Critical

なし。

## Important

なし。

## Resolved Important

- `packages/eqmonitor_map/lib/src/mesh/line_mesh.dart:3-11`, `packages/eqmonitor_map/lib/src/mesh/line_mesh.dart:29-44` — 前回のImportant findingだった `LineMesh.extrudes` doc commentの古いMapLibre-style前提は削除され、現在のtile-local Y-down production contract、`BaseMapGeometryFactory`でのY反転、todo 700に従う将来のMapLibre-style再設計が明記された。

## Minor

- `packages/eqmonitor_map/test/flutter_scene/base_map_geometry_factory_test.dart:66-74` — testはshaderの実行ではなく、`base_map_line.fmat` の式をDartでモデル化している。今回の修正箇所はDart側なので受け入れ可能だが、将来 `.fmat` 側で符号や式が変わってもこのtest単体では検出できない。
