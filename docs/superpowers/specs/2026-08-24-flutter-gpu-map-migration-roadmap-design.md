# Flutter GPU Map Migration Roadmap Design

## 1. Purpose

EQMonitor の既存 MapLibre レイヤーを、段階的に Flutter Scene / Flutter GPU
ベースの地図へ置換する。

移行中は既存 MapLibre 実装を正本として残し、デバッグ地図で同一データを
並行表示して parity を確認する。iOS / Android の profile runtime gate を
通過した surface だけを本番画面へ切り替え、未確認の MapLibre レイヤーを
先に削除しない。

本ロードマップは次の利用者向け完成順を固定する。

1. 地震履歴の震度 Fill、震源、観測点
2. event `20260823020050` の推計震度分布図
3. 緊急地震速報の予想震度、警報範囲、震源、P/S 波
4. 強震モニタ観測点
5. 強震モニタ観測点ラベル
6. surface ごとの MapLibre 削除

## 2. Current Baseline

2026-08-24 時点の作業ブランチでは、次の経路が実装済みである。

```text
signed Asset Pack
  -> verified PMTiles
  -> bounded MVT decode
  -> Fill / Line mesh
  -> packed geometry cache
  -> Flutter Scene / GPU
```

地震 overlay は、地域・市区町村の震度 Fill と、単一 GPU instance batch の
観測点まで接続済みである。実 API event の地域 Fill と pan 追従は iOS
Simulator / Metal で確認した。市区町村 Fill、観測点、zoom 6 境界、
background / foreground は未確認であり、完成扱いにしない。

現行 `MapSceneFrameSubmission` は base map、地震 Fill、観測点に固定されて
いる。EEW、推計震度、強震モニタを domain 固有 field として追加し続けず、
本ロードマップで package-neutral な overlay submission へ一般化する。

## 3. Architectural Direction

### 3.1 Package boundary

`packages/eqmonitor_map` は EQMonitor app の API model、Riverpod provider、
MapLibre、GeoJSON、app asset path に依存しない。

app は外部データを検証し、次の package-neutral primitive へ変換する。

- coded polygon Fill / Line
- static circle point
- texture-atlas sprite
- live updatable point batch
- geodesic ring / dynamic Line / Fill
- foreground text label candidate
- camera command
- component coverage / freshness

app asset を使う sprite は、app が decode した immutable atlas descriptor と
pixel data を package へ渡す。package から asset path を参照しない。

### 3.2 Frame contract

一つの画面 frame は、一つの camera / viewport / clock capture と、canonical
phase 順に並んだ typed overlay submission list から構築する。list は logical
source と component key を持ち、同じ phase の複数 batch を安定順で保持できる。

```text
base background / land Fill
  -> underlay hazard Fill
  -> underlay hazard Line
  -> base administrative Line
  -> overlay hazard Fill / Line
  -> dynamic wave Fill / Line
  -> live point
  -> sprite
  -> foreground label
```

material reflection、ABI、geometry、uniform、resource ownership を Scene mutation
前に検証する。全 preflight と submit が成功した場合だけ、描画状態、coverage、
previous batch、active material を一括 commit する。

同一logical sourceの一部componentだけが新version stampになり、他componentが
古いversion stampのまま残るmixed frameを禁止する。

各domain specはunderlay / overlayのどちらを使うかMapLibre正本から固定する。
推計震度のFillとLineはともにunderlayで、行政境界線より下へ置く。EEW warning等の
overlay phaseは各subprojectで既存layer順をfixture化して決める。

### 3.3 Identity and version acceptance

各 full snapshot は data version と render version を分離して持つ。

- source identity: event ID、verified content digest、catalog digest 等
- source incarnation: provider / pipeline の再生成を区別する token
- data sequence: incarnation 内で canonical source data が変わるたび app が進める
  単調値
- data digest: canonical source data 全体の digest
- render generation: theme、atlas、setting 等、data を変えない render 入力の単調値
- render digest: data version と全 render 入力から作る canonical digest
- async generation: source、replay、background 復帰を含む非同期処理世代

次は Scene mutation 前に拒否する。

- 古い generation
- 低い data sequence / render generation
- 同じ data sequence で異なる data digest
- 同じ render generation で異なる render digest
- source switch 後に完了した旧 request
- context generation の異なる GPU resource

同一 version / digest は idempotent とする。theme-only 変更は data sequence / data
digest を変えず、render generation を進める。同一 upstream reportedAt でも source
data が置換された場合は app が新しい data sequence を発行する。reportedAt や EEW
serialNo を単独で受理 sequence に使用しない。

時刻 tick だけで version を増やさない。連続 animation は immutable timeline と
frame clock から renderer が補間する。

### 3.4 Clock boundary

`BaseMapView` は内部で wall clock を生成せず、package-neutral `MapClock` を必須入力
として受け取る。app は `AppClock` の NTP / time-shift / replay 時刻と、単調経過時間
を一つの adapter へ渡す。

- wall time: EEW timeline、freshness、KMON target time の評価に使う
- monotonic time: animation delta、timeout、performance 計測に使う
- 一 frame で各時刻を一度だけ capture し全 component が共有する
- replay seek / clock source switch は source incarnation と async generation を進める
- replay pause は continuous frame を停止する
- background は tick を停止し、foreground で wall time と expiry を再評価する

### 3.5 Coverage and failure

coverage は component ごとに、少なくとも次を区別する。

- complete
- loading
- authoritative empty
- incomplete
- stale
- expired
- disabled
- invalid input / schema
- source / decode / Scene failure

正常な空 tile と、source layer / schema / required property の欠損を混同しない。
debug 診断と利用者向け banner を分け、表示内容を欠損させる問題だけを利用者向け
`incomplete` とする。

`authoritative empty` は source 固有の verified evidence がある場合だけ使う。

- PMTiles directory に canonical tile entry がない: authoritative empty
- tile entry があり必須 source layer がない: invalid schema
- signed semantic sidecar が tile / layer の空を明示する: authoritative empty
- evidence のない source layer 不在: incomplete

Asset Pack v0.0.9 には per-tile semantic empty attestation がないため、単なる layer
不在を complete へ緩和しない。debug diagnostic では水域等の可能性を表示できるが、
利用者向け complete を推測しない。

固定値、ランダム値、異なるsource / version stampのlast-good geometryへfallback
しない。base map の視覚的親 tile fallback は維持できるが、hazard overlay は
exact canonical tile だけを使用する。

### 3.6 GPU resource lifecycle

GPU resource は `(contextGeneration, resourceGeneration)` で所有する。

- camera-only update は uniform だけを更新する
- static topology は ABI / material version 変更時だけ再生成する
- live value は bounded ring buffer へ更新する
- background では request、decode、upload、continuous frame を停止する
- resource は renderer completion fence 後に一度だけ retire する
- foreground では freshness と source identity を再評価してから再構築する

Flutter Scene の self-instancing 制約により、一つの self-instanced geometry を
複数 node から参照しない。一 batch / 一 geometry / 一 node を維持する。

texture、quad topology、instance、node の寿命を分離する。

- texture key: `(contextGeneration, atlasDigest)`
- topology key: `(contextGeneration, ABI version, material version)`
- instance key: `(contextGeneration, batchGeneration)`
- node ownership: committed frame

共有 texture / topology は pin または参照数で所有し、一 consumer の更新 / 削除で
他 consumer が使用中の resource を retire しない。failed candidate は committed
resource の pin を解放しない。

## 4. Subprojects

### 4.1 Earthquake history parity

既存地震 overlay に texture sprite の震源を追加し、観測点を runtime で確認する。
programmatic camera command、coverage の user-facing / diagnostic 分離もこの段階で
実装する。

### 4.2 Estimated intensity PMTiles

観測震度 overlay と独立した remote PMTiles source として実装する。

- API の完全 URL を source of truth とする
- HTTPS、host allowlist、event path、URL digest を検証し、redirect を拒否する
- caller 指定の byte 上限内で archive 全体を一時領域へ download する
- download 完了後に SHA-256 を URL digest と照合する
- digest 一致した local bytes だけを `VerifiedPmTilesSource` として open する
- `seismic_intensity` Polygon と既知の `name` class だけを受理する
- 既知 class は app theme 色を使う
- visible source coverage が揃うまで部分表示しない

現行 range reader の digest field は cache identity であり、content attestation では
ないため、初回描画前の全体 download / hash を省略しない。将来 backend が署名済み
size と per-chunk digest / Merkle proof を提供した場合だけ range 検証へ置換できる。

content identity は `estimated:<eventId>:<verifiedSha256>` とする。hash 変更は同一
event でも source switch とし、旧 overlay を即時 clear する。theme 変更は content
identity / data sequence を変えず render generation を進める。

estimated display mode は既存 MapLibre と同じく観測震度 Fill と観測点を隠し、
推計震度 Fill / Line と同じ event の震源 sprite を残す。app は observed / estimated
を一つの full display candidate として選び、frame compositor は mode 間の混在を
禁止する。

base source と event source は header 由来の独立 zoom range、bounds、canonical
tile cover、repository、cache、scheduler を持つ。同じ camera / viewport transform
へ合成し、event source は z14 超で z14 を明示 overscale する。event bounds 外は
directory / bounds evidence に基づく authoritative empty とする。viewport 変更で
新 event cover が揃うまでは推計震度を一枚も表示しない。

event `20260823020050` の archive は実データで SHA-256 と URL digest の一致、
PMTiles v3 / MVT / gzip、`seismic_intensity` Polygon、class 4 / 5- / 5+ を
確認済みである。

### 4.3 EEW

REST latest と WebSocket upsert を event ごとの canonical record へ集約し、active
event 集合全体を一つの full snapshot にする。

- `areaForecastLocalE.code` の予想震度 Fill
- `areaForecastLocalEew.code` の警報 Fill
- normal / low-precision hypocenter sprite
- AppClock による geodesic P/S wave
- cancel 時の即時 geometry 除去
- freshness / expiry / oneHz / unlimited scheduler

clock adapter、replay seek / pause、time shift、background 復帰は 3.4 の契約を使う。

最初の slice はデバッグ地図だけへ接続し、Home MapLibre を残す。

### 4.4 Kyoshin Monitor live points

Asset Pack の station catalog と NIED GIF parser を structured fixed-slot frame へ
変換する。

- catalog digest と stable slot order
- typed pixel availability / failure
- source / data type / layer / target time generation
- 1 Hz update 用 bounded `UpdatableInstanceGeometry`
- camera update 時 upload 0
- value update 時 geometry generation 0 / buffer update 1
- 1634 points を原則一 draw

GeoJSON encode / decode を GPU 経路に持ち込まない。

KMON subproject は必須の versioned `KyoshinMonitorFreshnessPolicy` を app から渡す。
policy は fetch interval、`staleAfter`、`expireAfter` を持ち、package に既定値を置か
ない。`staleAfter >= fetchInterval`、`expireAfter > staleAfter` を検証する。

- fixed slot の availability と frame coverage を別々に保持する
- known-empty と parser failure を区別する
- available point は degraded frame でも描画できるが coverage を complete にしない
- last-good は `staleAfter` 以後 stale、`expireAfter` で全点を除去する
- 同 target retry は同 digest なら no-op、異 digest なら新 value generation とする
- 古い target time、旧 source / setting / replay generation を拒否する

### 4.5 Station labels

Flutter foreground `CustomPainter` と `TextPainter` LRU を使用する。GPU glyph atlas、
MapLibre glyph PBF に依存しない。

- bounded text layout cache
- right / left / up / down candidates
- deterministic collision
- placement hysteresis
- viewport edge handling
- DPR / theme / locale / font generation invalidation
- accessibility semantics

station label の min zoom、表示可否、priority は app から渡す。初期 consumer は
高 zoom 限定とし、全 1600 点の同時配置を要求しない。

label candidate は catalog 座標を独自投影せず、committed live point frame と同じ
projected point set、world-wrap identity、camera capture を共有する。point が同frame
で hidden / unavailable になった場合、対応 label も同時に除去する。

## 5. Parallel Work Graph

利用者向け integration gate は順番を守るが、次の foundation は並行可能である。

```text
A compositor / camera / clock / coverage ----┐
B sprite atlas -------------------------------+--> earthquake history gate
C verified remote PMTiles --------------------┐
H estimated decoder / renderer / app mode ----+--> A + C + H -> estimated gate
D freshness / geodesic ring -----------------┐
I EEW warning coded geometry / app builder --+--> A + B + D + I -> EEW gate
E structured KMON parser --------------------┐
F updatable instance / projected-point set --+--> A + E + F -> KMON point gate
G label placement foundation ----------------+--> A + E + F + G -> station label gate
```

同じ worktree の同じ file を複数 agent が同時編集しない。並列 agent は独立した
file ownership または read-only audit に限定し、integration owner が順に統合する。

各 implementation task は fresh implementer、task-scoped reviewer、必要な fix round、
最終 whole-branch reviewer を持つ。

## 6. Migration Gates

各 subproject は次を満たすまで本番 surface へ切り替えない。

- pure boundary / conversion / lifecycle の自動テスト
- package と app の関連 full test
- `dart analyze --fatal-infos`
- shader / material reflection の DataAssets 経路検証
- iOS / Android profile mode の画面確認
- pan / pinch / zoom boundary
- source switch / late completion / failure injection
- background / foreground / context recreation
- GPU resource、upload、node / batch 数の上限確認
- 連続 Scene / GPU error がないこと

推計震度 gate はさらに次を必須とする。

- non-allowlist host、redirect、event / path / URL hash mismatch を描画前に拒否
- byte 上限超過、SHA mismatch、同一 validator の内容差替えを拒否
- absent tile と present-but-layer-missing を区別
- 全 visible canonical tile 完了前は一枚も表示しない
- event A -> B、同一 event hash 変更、late download / decode を巻き戻さない
- target event の 4 / 5- / 5+ を theme 色で表示し、焼き込み色へ fallback しない
- z0、z14、z14 超 overscale、event bounds 端を確認
- estimated mode で観測 Fill / station を隠し、同eventの震源を残す
- iOS / Android profile で event `20260823020050` を確認

Simulator や emulator の操作を agent が行う場合は、ユーザー操作と競合しないよう
開始前に通知し、終了時に入力を解放する。

MapLibre layer の削除は、同一 surface の全表示 mode と error / loading / lifecycle
parity を iOS / Android で確認した別 task として行う。

## 7. Out of Scope for the First Subproject

- 推計震度の renderer 実装
- EEW renderer 実装
- KMON live buffer 実装
- label foundation 実装
- Home / earthquake details の MapLibre 削除
- backend API / Asset Pack schema の変更
