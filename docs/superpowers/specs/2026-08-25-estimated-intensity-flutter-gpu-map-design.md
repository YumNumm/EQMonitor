# Estimated Intensity Flutter GPU Map Design

## 1. Purpose

地震履歴の推計震度分布図を、既存 MapLibre 表示を正本として残したまま、
Flutter Scene / Flutter GPU のデバッグ地図へ production-grade に実装する。

最初の実データ検証対象は event `20260823020050` とする。
この event ID は contract
fixture、integration test、runtime verification の入力であり、production code が
参照する固定 URL、固定 SHA-256、fallback source にはしない。

本設計は次を一つの信頼境界として扱う。

```text
backend immutable archive descriptor
  -> generated client contract
  -> app URL / response / full-content verification
  -> verified local PMTiles lease
  -> independent event tile pipeline
  -> strict estimated-intensity MVT decode
  -> complete visible cover candidate
  -> observed / estimated atomic Scene frame
```

## 2. Scope

### 2.1 In scope

- backend/API の immutable archive descriptor 契約
- legacy `estimated_intensity_tile` との移行期間中の併存
- app の URL、host、event path、digest、size、redirect 検証
- caller-owned byte cap 内の archive 全体 download と SHA-256 検証
- verified local file の lease、bounded cache、cleanup
- PMTiles v3 header、zoom range、bounds、tile type、compression の検証
- base source と独立した event source の repository、cache、scheduler、coverage
- `seismic_intensity` Polygon と既知 `name` class のみを受理する MVT decoder
- theme 色の Fill / Line を行政境界線より下へ描画する typed submission
- observed / estimated mode の full candidate 排他
- estimated mode で同一 event の震源 sprite を維持すること
- event、hash、viewport、theme、lifecycle、renderer context の世代管理
- event `20260823020050` の deterministic contract fixture と
  iOS / Android 実機検証

### 2.2 Out of scope

- Home、地震履歴詳細、ライブモニタの MapLibre layer 削除
- remote range reader を使った初回描画
- per-chunk digest、Merkle proof、署名済み range response
- 既存 archive の min zoom を下げる backend generator 改修と過去 archive 再生成
- EEW、強震モニタ、station label の GPU 実装
- production code への target event URL、SHA-256、archive size の埋め込み

MapLibre 削除は、同一 surface の全 display mode と error / loading / lifecycle parity を
iOS / Android で確認した別 task とする。

## 3. Current Baseline and Confirmed Gaps

### 3.1 Existing MapLibre behavior

`EarthquakeHistoryDetailsEstimatedIntensityLayer` は API の full URL を
`pmtiles://` source として直接開き、source layer `seismic_intensity` を Fill と Line
の両方へ使う。

- Fill opacity: `1`
- Line opacity: `1`
- Line width: `0.5` logical pixel
- Fill / Line ともに base administrative line より下
- known class: `intensity:4`, `5-`, `5+`, `6-`, `6+`, `7`
- known class は `activeColorSet.estimatedIntensity` の背景色
- estimated mode は観測 Fill と観測点を隠す
- 震源 layer は mode 分岐の外にあり、同一 event の震源を残す

現行 MapLibre expression は unknown class で tile の `fill` property へ fallback する。
GPU 実装ではこの fallback を禁止する。焼き込み色、近い震度階級、観測 Fill、古い
archive のいずれにも置き換えず、schema failure として推計震度を描画しない。

### 3.2 Existing API contract

生成済み client では `Earthquake.estimatedIntensityTile` と
`EarthquakePartial.estimatedIntensityTile` は nullable URL string であり、app model は
それを `estimatedIntensityTileUrl` へ無検証でコピーする。現在の contract fixture は
event ID を filename に持つ URL だけを含み、content size と SHA-256 を持たない。

この legacy field だけでは URL digest と download 後 SHA-256 を照合できない。
GPU code は legacy URL から digest、size、immutable revision を推測してはならない。

### 3.3 Existing package contracts

再利用する既存 contract は次のとおりである。

- `VerifiedPmTilesSource`: app が検証済みの local path / size / SHA-256
- `PmTilesV3Archive` / `PmTilesV3FileRandomAccessReader`
- `MvtDecoder` / `MvtDecodeLimits`
- `FillMeshBuilder` / `LineMeshBuilder`
- `MapTileScheduler`
- `MapTileFallbackPolicy.hazard`
- `MapOverlayVersionStamp`
- `MapSceneFrameSubmission`
- `mapSceneUnderlayHazardFillPhaseId`
- `mapSceneUnderlayHazardLinePhaseId`
- existing Fill / Line packed mesh layout and fmat ABI

`MapRemotePmTilesRandomAccessReader` の SHA-256 field は cache identity であり、range
response 全体と digest を照合しない。strong ETag は range 間の snapshot consistency
を保証するだけで、expected archive との content attestation にはならない。このため
estimated source の初回描画には使わない。

### 3.4 Backend evidence boundary

EQMonitor checkout から確認できるのは generated OpenAPI、generated Dart model、contract
fixture、および backend submodule の消費経路である。backend repository の現在の
IXAC41 generator、object key publication、R2 response header、realtime payload producer、
schema source file の実装位置と挙動は、本設計起草時点では live source audit を行って
いない。

したがって backend P0 は変更前に対象 repository で次を read-only に確認する。

```bash
rg -n "estimated_intensity_tile|estimated_intensity_key|ixac41|pmtiles" api service packages
rg -n "openapi|contract-fixture|realtime" api service packages
```

本設計は public descriptor の意味と検証規則を固定するが、未確認の backend file path、
generator class、storage library、deployment job 名を決め打ちしない。

## 4. Chosen Approach

### 4.1 Adopted: immutable descriptor and full local verification

backend は URL、exact byte size、SHA-256 を一つの immutable descriptor として返す。
URL 自体にも event ID と digest を含め、redirect なしで同一 bytes を返す。app は archive
全体を一時領域へ download し、size と SHA-256 を照合した local bytes だけを package へ
渡す。

この方式は network round-trip と一時 disk を必要とするが、既存 package contract を
壊さず、初回描画前に content identity を証明できる唯一の現行方式である。

### 4.2 Rejected: legacy URL plus ETag

legacy URL は digest と expected size を持たない。ETag は producer が選ぶ validator で、
SHA-256 と同値とは限らない。同一 ETag で異なる content が配られる障害も検出できない。
この案は採用しない。

### 4.3 Deferred: verified range access

署名済み total size と per-chunk digest、Merkle proof、または同等の content binding が
backend contract に追加された場合だけ、全体 download を range reader へ置換できる。
現段階で range reader を estimated source の trust boundary にしない。

## 5. Backend and API Contract

### 5.1 Additive descriptor

移行期間は既存 `estimated_intensity_tile` を MapLibre consumer のために残し、GPU consumer
向けに additive field `estimated_intensity_tile_archive` を追加する。

```json
{
  "estimated_intensity_tile": "<legacy full URL>",
  "estimated_intensity_tile_archive": {
    "url": "https://<allowed-host>/ixac41/<eventId>/<sha256>.pmtiles",
    "size_bytes": 123456,
    "sha256": "<64 lowercase hex>"
  }
}
```

上記 URL、size、hash は schema shape の説明であり、production 定数ではない。

descriptor の不変条件:

- `url` は absolute HTTPS URL
- path は decoded segment 単位で `ixac41`, event ID, `<sha256>.pmtiles`
- URL digest と `sha256` field は lowercase で完全一致
- `size_bytes` は正数
- URL は redirect endpoint ではなく archive bytes を直接返す
- 同一 URL は常に同一 bytes
- content が変わる場合は同一 event でも digest、URL、descriptor を変える

`Earthquake` と `EarthquakePartial` の両方へ同じ descriptor 型を使う。detail と list の
descriptor が同一 event で異なる場合、detail の新しい canonical record を採用し、古い
async result は generation で拒否する。

### 5.2 Realtime contract

最小移行では realtime の `estimated_intensity_key` を immutable URL path と同じ key にし、
hash を含ませる。client は realtime を受信したら detail API を再取得し、identifier と
descriptor URL path が一致した場合だけ新 source candidate を作る。

realtime mapper / notifier は key を source candidate として直接採用しない。key 受信時に
request generation を進め、detail refetch の応答が同じ event、同じ generation、同じ immutable
path の descriptor を返した場合だけ download へ進む。古い refetch、異なる key、descriptor
未取得の状態は `base+hypocenter` までに留める。

backend audit で realtime record が descriptor object を安全に同梱できることが確認できた
場合は、同じ descriptor schema を再利用できる。ただし REST と realtime で別の digest / size
定義を作らない。

### 5.3 Legacy coexistence and fail-closed behavior

- MapLibre consumer は移行完了まで legacy field を使用できる。
- GPU consumer は新 descriptor だけを使用する。
- descriptor が null または不正な場合、GPU estimated source は `disabled` または
  `invalidInput` とする。
- legacy URL は content-addressed identity ではないため、新 descriptor の trust 判定や
  invalid 判定へ使わない。両 field の path が異なっても、それだけで valid descriptor を
  拒否しない。
- GPU consumer は legacy URL へ fallback しない。
- API migration 中に descriptor がない event で observed mode を自動選択することは UI の
  初期 mode 決定として可能だが、ユーザーが estimated mode を選んだ後に observed Fill を
  silent fallback として描画してはならない。

## 6. App Descriptor Validation

app は API model を package-neutral download request へ変換する前に、pure validator で
次を検証する。

```dart
final class EstimatedIntensityArchiveDescriptor {
  final String eventId;
  final Uri url;
  final int sizeBytes;
  final String sha256;
}

final class EstimatedIntensityArchiveUrlPolicy {
  final Set<String> allowedHosts;
  final int maxArchiveBytes;
}
```

policy は caller 必須であり、production code に full URL や target event hash を持たない。
host allowlist は exact hostname matching とし、suffix matching を使わない。

拒否条件:

- scheme が HTTPS 以外
- authority または host がない
- host が exact allowlist 外
- user info、fragment、query、non-default port がある
- decoded path segment が厳密な3 segment構造と異なる
- empty segment、dot segment、encoded separator、二重 slash、trailing slash
- event ID segment が要求 event ID と異なる
- event ID が既存 earthquake event ID validator を通らない
- URL digest が64文字 lowercase hexでない
- URL digest と descriptor SHA-256 が異なる
- size が正数でない、または caller `maxArchiveBytes` を超える

URI canonicalization で異なる入力を同一とみなして受理しない。検証前 raw URL と検証後 URI
の path semantics が一致しない場合は拒否する。

## 7. Download, Verification, and Lease

### 7.1 Transport contract

download は app data layer の専用 repository が所有する。Asset Pack の background
downloader は redirect と streaming cap の検証面が異なるため直接再利用しない。

HTTP contract:

- `HttpClient.autoUncompress = false` とし、header 検査前に response body を自動展開しない
- redirect follow を無効化し、全 3xx を拒否
- status `200` だけを受理
- `Accept-Encoding: identity`
- `Content-Encoding` は未指定または `identity` だけを受理
- `Content-Length` があれば descriptor size と完全一致し、byte cap 以下
- `Content-Length` がなくても stream 中の累積 byte 数で cap を強制
- EOF 時の実 byte 数が descriptor size と完全一致
- timeout、cancel、socket failure を source failure として typed に保持
- response body、例外、URL に auth token や local path を user-facing message へ出さない

total timeout と cancel は request open、body read、part write、flush、exact size、SHA-256
確認までを一つの停止signalで制御する。停止時はHTTP request、body subscription、part writer、
hash subscriptionを中断し、各adapterのpending I/Oがsettleしてから `.part` cleanupへ進む。
cleanup失敗の診断は固定enumだけを渡し、URL、local path、hash、元例外を渡さない。

### 7.2 Full-content verification

response は unique `.part` file へ stream する。write と同時に SHA-256 を更新してよいが、
EOF、exact size、digest の全確認前に verified source として publish しない。

確認順:

1. descriptor と caller policy
2. response status / headers
3. streaming byte cap
4. exact final size
5. SHA-256
6. PMTiles archive header
7. content-addressed cache への atomic rename
8. `VerifiedPmTilesSource` publication

SHA mismatch、size mismatch、header failure、cancel、supersede では `.part` を削除する。
cleanup failure は verified source を publishする理由にせず、diagnosticへ記録する。

### 7.3 Lease and bounded local cache

verified file は temporary/cache directory の content-addressed path に置く。

```text
estimated-intensity/<eventId>/<sha256>.pmtiles
```

同じ content identity の concurrent request は一つへ coalesce する。active repository が
file を開いている間は lease で pin し、source switch / widget dispose / package repository
close 完了後に release する。unleased file だけを LRU cleanup 対象にする。

caller は少なくとも次の上限を渡す。

- `maxArchiveBytes`
- `maxRetainedArchiveBytes`
- `maxRetainedArchiveCount`
- connect / idle / total timeout

上限内に収めるため active lease を強制削除してはならない。全 file が leased で新 archive
を保持できない場合は新 candidate を fail closed にする。

## 8. Verified PMTiles Event Source

### 8.1 Header validation

`VerifiedPmTilesSource` を file reader で開き、実 header から次を取得・検証する。

- PMTiles spec version 3
- tile type MVT
- supported internal compression
- tile compression gzip
- `0 <= minZoom <= maxZoom <= PMTiles maximum`
- finite WGS84 bounds
- longitude / latitude の順序と範囲
- archive section bounds と overlap は既存 `PmTilesV3Archive.open` の検証を利用

event `20260823020050` fixture はcontent-addressed URLが指す実 archiveの検証済みmanifestを持ち、
少なくともPMTiles v3、MVT、gzip、`minZoom=0`、`maxZoom=14`、class 4 / 5- / 5+をpinする。
値は test fixture にのみ置き、production limit や fallback として転記しない。

### 8.2 Independent source pipeline

base source と estimated event source は同じ camera / viewport capture を共有するが、次を
共有しない。

- header-derived zoom range
- bounds
- canonical cover
- repository
- decoded geometry cache
- packed mesh cache
- scheduler / in-flight set
- decode failure owner
- source generation
- coverage

`BaseMapTileRepository` の archive/readTile contract は汎用化して再利用できるが、base map
cache は `BaseMapTileGeometry` と visual parent/child fallback に密結合している。estimated
source は exact hazard tile 専用 cache を持つ。

### 8.3 Cover and zoom policy

estimated cover は camera zoom の floor と event header を使う。

- `camera.floorZoom < header.minZoom`: `belowSourceMinZoom`、tile request 0、描画なし
- `header.minZoom <= floorZoom <= header.maxZoom`: exact canonical tile
- `floorZoom > header.maxZoom`: canonical z=`header.maxZoom`、overscaledZ は camera floor
- header bounds 外: authoritative empty
- bounds 内で PMTiles directory entry がない: authoritative empty

min zoom 未満を min zoom tile へ clamp しない。これは MapLibre に存在しない underzoom を
捏造し、hazard geometry の exactness と resource budget を壊すためである。

event `20260823020050` のcontent-addressed archiveはheader由来のmin zoom 0を持つため、z0を
exact canonical tileとして扱う。generic underzoom policyはmin zoom 5のdeterministic synthetic
fixtureを別に用意し、z0でrequest 0 + `belowSourceMinZoom`になることを固定する。いずれもheaderを
唯一のzoom sourceとし、event IDやlegacy archiveの既知値をproduction fallbackへ使わない。

bounds と cover の canonical tile は world wrap を除いて deduplicate する。描画 transform は
unwrapped tile を保持する。cover が caller `maxVisibleCanonicalTiles` を超える場合は一部だけ
描かず、candidate 全体を resource-limit failure とする。

## 9. Estimated Intensity MVT Contract

### 9.1 Accepted schema

source layer は大文字小文字を含め `seismic_intensity` 完全一致とする。

受理する feature:

- geometry type: Polygon
- property `name`: non-empty String
- exact class:
  - `intensity:4`
  - `intensity:5-`
  - `intensity:5+`
  - `intensity:6-`
  - `intensity:6+`
  - `intensity:7`

`fill` property は読まず、render style の入力にしない。Point、LineString、missing name、
unknown class、duplicate conflicting property、invalid geometry、decoder limit 超過は schema
failure とする。既知 feature と未知 feature が同じ tile に混在する場合も tile 全体を拒否し、
既知 feature だけを部分表示しない。

### 9.2 Tile result distinction

- PMTiles directory entry absent: authoritative empty
- tile bytes present、required layer absent: invalid schema
- required layer present、feature zero: authoritative empty
- required layer present、全 feature valid: ready
- required layer present、1件でも invalid: invalid schema
- archive read / decompress / MVT decode failure: source or decode failure

### 9.3 Geometry and style separation

decoder は app theme に依存せず、class ごとの FillMesh と closed polygon boundary LineMesh を
返す。Polygon ring を LineString に変換する helper は package-neutral な公開 unit とし、
base map decoder と estimated decoder が同じ閉路規則を使う。

app は `EstimatedIntensityColors` を class ごとの immutable style へ変換する。class が全て
theme に対応しない限り render candidate を作らない。Fill / Line の色は同じ class theme
背景色、opacity は1、Line width は0.5 logical pixelとする。

## 10. Scene Rendering and Atomic Display Mode

### 10.1 Typed layers

次の component と kind を追加する。

```text
component estimated-intensity-fill
  kind estimatedIntensityFill
  phase underlayHazardFill

component estimated-intensity-line
  kind estimatedIntensityLine
  phase underlayHazardLine
```

Fill、Line、hypocenter sprite は `mapSceneEarthquakeHistorySourceKey` を共有する。estimated
専用 logical source key を別に作ると、frame validator が震源との version 混在を検知できない
ためである。

既存 Fill / Line fmat ABI、material parameter encoder、packed mesh layout は再利用する。
semantic pipeline key と material owner は estimated 用に分け、base map material cache や
observed earthquake material stage を誤って commit / retire しない。

### 10.2 Full display candidate

app は一 event について observed または estimated のどちらか一つを選び、package へ full
candidate として渡す。

```dart
sealed class EarthquakeMapDisplayCandidate {
  MapOverlayVersionStamp get versionStamp;
  String get eventId;
}

final class ObservedEarthquakeMapDisplayCandidate
    extends EarthquakeMapDisplayCandidate {
  final EarthquakeMapOverlaySnapshot snapshot;
}

final class HypocenterOnlyEarthquakeMapDisplayCandidate
    extends EarthquakeMapDisplayCandidate {
  final int requestGeneration;
  final MapSpriteAtlas spriteAtlas;
  final List<MapPointSpriteFeature> hypocenterSprites;
}

final class EstimatedEarthquakeMapDisplayCandidate
    extends EarthquakeMapDisplayCandidate {
  final EstimatedIntensitySourceSnapshot source;
  final MapSpriteAtlas? spriteAtlas;
  final List<MapPointSpriteFeature> hypocenterSprites;
}
```

estimated content identity は
`estimated:<eventId>:<verifiedSha256>`。これを `MapSourceIdentity` と data digest の入力へ
含める。同一 event でも hash が変われば source switch とし、旧 estimated Fill / Line を
即時 clear する。

descriptor が null、loading、invalid、source failure、または archive verification 前の間は
estimated full candidate とその content identity を作らない。同一 event の検証済み
hypocenter sprite だけを残す場合は、archive と独立した
`base+hypocenter:<eventId>:<requestGeneration>` candidate を使う。archive の full verification
成功時にだけ `estimated:<eventId>:<verifiedSha256>` candidate へ原子的に昇格し、hypocenter も
新 stamp へ付け替える。

theme-only 変更は source identity、data sequence、data digest を変えず、render generation
と render digest だけを進める。render digest は全 class 色、opacity、Line width、sprite
render input を含む。

### 10.3 Frame invariants

`MapSceneFrameSubmission` は次を Scene mutation 前に拒否する。

- observed region/city Fill と estimated Fill / Line の共存
- observation point と estimated Fill / Line の共存
- estimated Fill だけ、または Line だけの partial pair
- Fill / Line / hypocenter の overlay version mismatch
- 異なる event の hypocenter
- wrong phase / pipeline / component combination
- node count、material ABI、geometry ABI の上限超過

estimated source が loading、invalid、source failure、below min zoom の場合、observed Fill / station
や旧 estimated geometryを描かない。同一 event の検証済み hypocenter sprite は base map 上に
残せるが、estimated full candidate の stamp を捏造せず、
`base+hypocenter:<eventId>:<requestGeneration>` candidate として単独 commit する。verified archive
が利用可能になったときだけ Fill / Line / hypocenter を同じ estimated stamp へ原子的に切り替える。

## 11. Coverage and Publication Barrier

estimated coverage は少なくとも次を区別する。

- hidden
- loading archive
- validating archive
- loading visible tiles
- complete
- authoritative empty
- below source min zoom
- invalid input / schema
- source / decode failure
- resource limit exceeded
- lifecycle suspended

debug diagnostic は event ID、content identity、header zoom / bounds、visible canonical count、
ready、authoritative empty、pending、missing layer、unknown class、decode failure を持つ。利用者向け
message は短い分類文だけを表示し、URL、hash、local path、例外全文を表示しない。

publication rule:

```text
all unique visible canonical tiles are
  ready OR authoritative empty
AND invalid/schema/decode/resource failures are zero
=> Fill and Line pair may be submitted
```

pending が1件でもある、または invalid が1件でもある場合は estimated Fill / Line packet を0件
にする。前 viewport の complete coverを新 viewportへ last-good として使わない。

## 12. Generation, Switching, and Lifecycle

次の操作は async generation を進め、旧 work の cache put、coverage publish、Scene commit を
拒否する。

- event A -> B
- same event SHA-256 change
- descriptor invalidation
- display mode switch
- viewport canonical cover change
- provider dispose
- background transition
- clock / replay source incarnation change
- renderer context generation change

camera の fractional zoom や pan で canonical cover が変わらない場合は decode generation を
不要に進めない。camera-only update は既存 geometry の model transform / uniform だけを更新する。

background では download、decode、upload、continuous frame を停止し、uncommitted candidate を
破棄する。foreground では API descriptor、active lease、file existence / size、header、current
viewport cover を再評価する。renderer context が再生成された場合は CPU verified geometry を
再利用できるが、旧 context の GPU material / geometry / node を再利用しない。

resource retirement は existing completion fence 後に一度だけ行う。candidate preflight failure は
committed base map resource や hypocenter atlas の pin を誤って解放しない。

## 13. Event-specific Fixture

event `20260823020050` は二層の fixture で検証する。

### 13.1 API contract fixture

backend が生成し EQMonitor に同期する fixture は次を含む。

- event ID
- legacy URL
- immutable descriptor URL
- exact size
- SHA-256
- URL digest と SHA-256 の一致
- realtime immutable key

fixture の URL / hash / size は test input であり production code から import しない。

### 13.2 Archive manifest and deterministic MVT fixtures

実 archive の検証 manifest は次を pin する。

- PMTiles v3
- MVT / gzip
- content-addressed archiveのmin zoom 0 / max zoom 14
- bounds
- representative canonical tiles
- `seismic_intensity`
- class 4 / 5- / 5+

unit test は repository に巨大な production archive を無条件に複製せず、既存
`MinimalPmTilesArchiveBuilder` と MVT fixture builder で deterministic minimal archive を作る。
実 archive manifest の drift test と iOS / Android runtime検証は、
API descriptor が指す bytes
を full verificationした後に実行する。

## 14. Limits and Performance

全上限は caller が明示し、package に hidden fallback を置かない。

- archive byte cap
- retained archive byte / count cap
- PMTiles directory depth / window cap
- MVT layer / feature / property / ring / vertex / command cap
- Fill / Line mesh vertex cap
- visible canonical tile cap
- in-flight decode cap
- decoded geometry count / retained byte cap
- packed CPU / GPU byte cap
- Scene node cap
- max frames in flight

同じ content identity、canonical tile、class、mesh ordinal は packed geometry を再利用する。
theme change は geometryを再decode / repackしない。viewport complete barrier のために visible tile
を pin する場合、pin count / bytes は caller budget 内でなければならない。

runtime diagnostic は download bytes / duration、hash duration、tile read/decode p50/p95、cache
entries / bytes、in-flight count、GPU upload count / bytes、Scene node / batch count を bounded
collectorへ送る。生 URL、hash、座標を通常ログへ出さない。

## 15. User-facing and Debug Integration

最初の consumer は `EqmonitorMapDebugPage` とする。event ID は route parameter、debug input、
または test injection から渡し、production code に固定 URL / hash を置かない。

表示状態:

- descriptor fetch中: 推計震度データを確認中
- archive download / hash中: 推計震度分布図を準備中
- visible cover loading: 表示範囲の推計震度を準備中
- complete: 推計震度分布図を表示中
- below min zoom: この縮尺では推計震度分布図を表示できない
- invalid/schema/source failure: 推計震度分布図を表示できない

error object、stack trace、URL、hash、local path は UI に表示しない。debug details は明示的に
開く diagnostic panelだけへ分類値と count を表示する。

## 16. Verification Gates

### 16.1 Automated

通常CIとpackage/appの無条件test suiteはrepository内のdeterministic fixtureだけを使い、network、
credential、live objectの可用性へ依存しない。event `20260823020050` のactual descriptor/archive
照合はcredential付きの明示的opt-in integration laneで実行する。このlane内のnetwork failureは
skip/passへ変換せずfailureとする。

- descriptor parse / legacy coexistence / contract drift
- host、scheme、port、userinfo、query、fragment、path、event、URL hash
- redirect、status、encoding、Content-Length、stream cap、short / long body
- SHA mismatch、same URL replacement、temp cleanup、lease pin / eviction
- PMTiles header、tile type、compression、min/max、bounds
- event fixtureのz0 exact、synthetic min5 fixtureのz0 no-underzoom、z14 exact、z14超 overscale、bounds edge
- absent tile と present-but-layer-missing の区別
- known class全種、unknown / missing name / wrong geometry 拒否
- Fill / Line underlay phase、theme color、0.5px Line
- visible cover complete前 packet 0
- event A -> B、same event hash、late download / decode
- observed / estimated 排他、same-event hypocenter
- lifecycle / context recreation / resource retirement

### 16.2 Runtime

event `20260823020050` は target ごとに次の mode で検証する。

- iOS Simulator debug: visual、gesture、mode switch、background / foreground
- physical iOS device profile: performance、memory、renderer context、OS lifecycle
- Android emulator debug: visual、gesture、mode switch、background / foreground
- profile を support する Android target: performance、memory、renderer context、lifecycle

iOS Simulator をprofile判定基準として扱わない。各実行では
`flutter devices` が返した実在 device ID
を使い、generic `-d ios` / `-d android` を使わない。

- actual descriptor download / size / SHA / header確認
- class 4 / 5- / 5+ の theme 色
- Fill / Line と administrative line の順序
- observed Fill / station 非表示、same-event hypocenter 表示
- pan / pinch、z0、z14、z14超、bounds edge
- event/hash/theme/mode switch
- background / foreground
- renderer context recreation
- resource / upload / node cap
- 連続 Scene / GPU error がないこと

Simulator / emulator を agent が操作する場合、開始前にユーザーへ通知し、終了時に入力を解放する。

## 17. Rollout and Removal Criteria

実装は backend P0、client P1、app/package P2-P9 の Stacked PR とする。各 PR は前段の public
contractだけに依存し、独立したRED/GREEN、focused analyze、
review checkpointを持つ。

debug map検証が完了してもMapLibre layerは削除しない。
地震履歴詳細とライブモニタの
各 surface へ接続し、同じ data / mode / lifecycle gateを通した後、別 PR で MapLibre source / layer
を除去する。
