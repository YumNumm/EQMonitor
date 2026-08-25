# Earthquake Map Hypocenter and Observation Parity Design

## 1. Goal

Flutter Scene / GPU のデバッグ地図で、一つの実地震について次を同じ camera 上へ
表示する。

- base map
- 地域または市区町村の震度 Fill
- 震度観測点
- 震源 sprite

対象地震へ確実に移動でき、zoom 6 の地域 / 市区町村 / 観測点境界、pan / pinch、
background / foreground、source switch、coverage を runtime で検証できる状態を
完成条件とする。

本仕様は
`docs/superpowers/specs/2026-08-24-flutter-gpu-map-migration-roadmap-design.md`
の最初の subproject である。

## 2. Existing Inputs

### 2.1 App earthquake model

`Earthquake` は event ID、telegram metadata、intensity、hypocenter を持つ。
震源を描画できるのは `EarthquakeHypocenter.coordinates` が緯度経度を持つ場合だけ
である。座標が欠損、description、unknown の場合に既定位置へ置かない。

### 2.2 Existing overlay

現行`EarthquakeMapOverlaySnapshot`はsource ID、単一revision、地域 / 市区町村
style、観測点を保持する。本subprojectで単一revisionを3.4のversion stampへ置換
する。観測点はMercator座標、premultiplied color、logical-pixel radiusを28-byte
instance streamへ変換し、一geometry / 一nodeで描画する。

### 2.3 Existing icons

app は次を持つ。

- `app/assets/images/map/normal_hypocenter.png`
- `app/assets/images/map/low_precise_hypocenter.png`

地震履歴では normal icon を使用する。低精度 icon は同じ generic sprite foundation
を将来 EEW から再利用できることを確認する fixture とするが、本 subproject の
地震履歴 data builder は normal icon だけを出力する。

## 3. Public Contracts

### 3.1 Sprite atlas

`eqmonitor_map` は app asset path を受け取らない。app が asset bytes を decode し、
次の immutable descriptor を構築する。

```dart
final class MapSpriteAtlas {
  MapSourceIdentity identity;
  int width;
  int height;
  Uint8List rgbaBytes;
  List<MapSpriteRegion> regions;
}

final class MapSpriteAtlasLimits {
  int maxWidth;
  int maxHeight;
  int maxPixelBytes;
  int maxRegions;
}

final class MapSpriteRegion {
  String id;
  Rect normalizedUv;
  Size logicalSize;
}
```

実際の Dart 宣言は既存 naming、const / factory validation 規約に合わせる。公開
factory は caller 必須の `MapSpriteAtlasLimits` を受け、defensive copy と次の検証を
行う。package に暗黙の上限を置かない。

- identity が空でない
- width / height / byte count が一致する
- atlas byte / region count / dimension の明示上限
- UV が finite かつ 0..1
- logical size が finite かつ正
- region ID が非空・重複なし

atlas は content digest を identity に含める。theme / DPR は atlas identity に
含めず、必要なら別 material / uniform generation として扱う。

pixel ABI は次に固定する。

- top-left origin
- row-major、tight stride `width * 4`
- RGBA8888、straight alpha、sRGB encoded color
- shader で alpha をちょうど一回掛けて premultiplied output にする
- manual gamma conversion を行わない
- sampler は linear filter / clamp-to-edge
- 各 region は上下左右に 2 physical pixel の extruded edge padding を持つ
- normalized UV は padding を除く texel center を指す

2x2 の向き確認fixture、alpha 0.5 fixture、atlas端regionを使い、上下反転、二重
premultiply、neighbor bleed がないことを shader / iOS / Android で確認する。

### 3.2 Zoom scalar policy

地震固有の size / fade を renderer に hardcode しない。本subprojectのGPU ABIは、
必要なMapLibre表現へ絞った次の二型に固定する。

```dart
final class MapZoomLinearRange {
  double startZoom;
  double startValue;
  double endZoom;
  double endValue;
}

final class MapZoomStep {
  double thresholdZoom;
  double belowValue;
  double atOrAboveValue;
}
```

linear rangeは範囲外を端点clampし、`startZoom < endZoom`を必須とする。stepは
`zoom < thresholdZoom`でbelow、`zoom >= thresholdZoom`でatOrAboveを返す。全値は
finite、size値は正、opacity値は0..1をfactoryで検証する。

size / opacity policy pairはbatch-level immutable dataであり、canonical digestを
batch keyへ含める。instance ABIへ任意長stopやpolicy indexを入れない。同じpolicy
pairのfeatureを一batchへまとめ、異なるpolicy pairは別batchへ分ける。caller必須の
`maxSpritePolicyBatches`でbatch数を制限し、packageに暗黙上限を置かない。

### 3.3 Sprite feature

```dart
final class MapPointSpriteFeature {
  String id;
  double longitude;
  double latitude;
  String spriteRegionId;
  MapZoomLinearRange sizeScale;
  MapZoomStep opacity;
  int priority;
}
```

longitude / latitude と policy を factory で検証する。feature ID は一 snapshot
内で一意とする。

地震履歴の震源 feature は安定 ID `hypocenter:<eventId>`、normal region、既存
MapLibre parameter と同じ zoom 3 -> 20 の linear size と、設定された fade zoom
での step opacity を使用する。既存設定を app builder が generic policy へ変換し、
package は地震固有設定へ依存しない。zoom 3、fade zoom の直前 / 一致 / 直後、zoom
20 の値を既存 MapLibre fixture と比較する。

### 3.4 Earthquake overlay

`EarthquakeMapOverlaySnapshot` に次を追加する。

```dart
MapSpriteAtlas? spriteAtlas;
List<MapPointSpriteFeature> sprites;
```

atlas が null で sprites が非空、未知 region ID、重複 feature ID は factory で
拒否する。

snapshot は full replacement で、roadmap の data / render version を持つ。既存の
単一 `revision` は本subproject内でdata sequenceへ置換し、compatibility aliasを残さ
ない。

- data sequence: app provider が canonical earthquake data 変更時に進める
- data digest: region / city / station / hypocenter の canonical digest
- render generation: theme、atlas、display setting 変更時に進める
- render digest: data version と全 render policy の digest

同じ data sequence / 異なる data digest は拒否する。theme / atlas / setting だけの
変更は data version を維持し render generation を進めて受理する。同じ render
generation / 異なる render digest も拒否する。

commit、coverage callback、debug presentationは共通のimmutable
`MapOverlayVersionStamp`を使用する。

```dart
final class MapOverlayVersionStamp {
  MapSourceIdentity sourceIdentity;
  MapSourceIncarnation sourceIncarnation;
  int dataSequence;
  String dataDigest;
  int renderGeneration;
  String renderDigest;
}
```

`MapSourceIncarnation`は非空のopaque文字列をfactoryで検証する専用value typeとし、
`Object` identityやprocess-local hashを公開契約に使わない。

旧`sourceId / revision`だけのcoverage identityは削除する。app provider、controller、
frame owner、coverage equality、debug banner、testsを同じcommit範囲でversion stampへ
移行し、部分的なcompatibility stateを作らない。

### 3.5 Camera controller

`BaseMapView` はSceneやtile内部状態を公開せず、camera commandとcommit済みcamera
stateだけを扱う`MapViewCameraController`を任意引数として受け取る。

controller は caller が所有し、同時に一つの `BaseMapView` だけへ attach できる。
view dispose で detach し、その後の別 view への再attachは許可する。attach 前、
detach 中、二重attachのcommandはtyped failureを返し、queueしない。

controllerは最後にcommitされた`MapCamera`を保持し、同期getterと
`ValueListenable<MapCamera>`でcallerへ公開する。再attach時は保持cameraを使い、保持値
がない最初のattachだけ`BaseMapView.initialCamera`を使う。source switchはcameraを
暗黙resetしない。callerがcontrollerをdisposeした後のattach / commandはfailureと
する。

最低限の command は次とする。

- `Future<MapCameraCommandResult> moveTo({required MapCamera camera})`
- `Future<MapCameraCommandResult> fitBounds({required MapCameraBounds bounds,
  required EdgeInsets padding})`

`MapCameraCommandResult` は success receipt と sealed failure を持つ。success は camera
state が受理され次 frame がscheduleされた時点を意味し、tile load完了は意味しない。
failure は invalid input、not attached、already attached、disposed、superseded を区別
する。

command は非 finite input を typed failure として返し、例外を unawaited にしない。
新 command は未commitの前 commandを generation で supersede する。gesture と
command は同じ camera clamp / tile cover 経路を使う。`fitBounds` は antimeridian、
padding、DPR、viewport resize、min / max zoom clamp を扱う。

MapLibre parity fixtureでは、同一viewport / padding / boundsに対しzoom絶対誤差
`1e-6`以下、中心点のprojected logical-pixel誤差`0.5 px`以下を合格条件とする。

本 subproject の debug page は overlay source が変わったとき、震源座標があるなら
一度だけ震源へ移動できる UI action を表示する。座標がない場合は action を表示
しない。自動で毎 rebuild camera を戻さない。

## 4. Renderer Design

### 4.1 Geometry and instance layout

sprite は一つの quad topology と、全 feature の instance stream を使用する。
instance は少なくとも次を含む。

- normalized Mercator center
- atlas UV rect
- logical size / scale
- opacity
- feature priority

size / opacity policyはinstance streamへ格納せずbatch uniformで評価する。byte
stride、attribute offset、endiannessはpublic constantsとtest fixtureで固定する。
入力listはimmutableに所有し、caller buffer aliasを残さない。

同じbatch dataでcameraだけが変わる場合、instance bytes、texture、geometryを
再生成しない。cameraとzoom policy評価用uniformだけを更新する。

### 4.2 Shader contract

vertex shader は normalized Mercator、nearest date-line wrap、camera center、zoom、
viewport logical size から quad position を算出する。DPR を logical size に二重適用
しない。

fragment shader は straight-alpha atlas sample のRGBへsample alphaとfeature
opacityを一度だけ適用し、premultiplied RGBA を出力する。material は alpha
blending、depth write off、culling none、opaque false とする。texture row origin、
UV orientation、linear / clamp sampler は 3.1 のABIと一致させる。

shader symbol、uniform block size、instance stride / offset、texture binding type を
Scene mutation 前に reflection preflight する。

### 4.3 Phase and batching

地震 Fill、観測点、震源の順序は次とする。

```text
base < earthquake Fill < observation point < hypocenter sprite < label
```

震源は観測点より前面に置く。feature数に関係なく同じatlas / material / zoom policy
pairのspriteは一geometry / 一nodeとする。本subprojectの地震履歴震源は一policy
pairなので一geometry / 一nodeである。

### 4.4 Resource ownership

texture、static topology、instance geometry、node は別々に所有する。

- texture: `(contextGeneration, atlasDigest)`
- quad topology: `(contextGeneration, ABI version, material version)`
- instance: `(contextGeneration, batchGeneration)`
- node: committed frame

次の場合に旧 resource を Scene から外し、renderer completion fence 後に一度だけ
retire する。

- overlay source / full snapshot replacementで不要になったinstance / node
- atlas identity changeで不要になったtexture pin
- context recreation
- background
- widget dispose

submit / reflection / texture upload が失敗した場合、new earthquake candidate を
commit せず base-only へ fail closed する。旧 source の震源や観測点を残さない。
同atlasを二つのlogical overlayが共有する場合、一方の更新 / 削除でtextureを再upload
せず、他方のpinがある限りretireしない。failed candidateはcommitted texture /
topology / instanceをretireしない。

transaction順序を次に固定する。

1. candidate resourceをprepareしcandidate pinを取得
2. preflight / submit失敗時はcandidate pinだけをrelease
3. base-onlyをatomic commitし旧nodeをSceneから除去
4. completion fence後に旧instance / node pinと、旧consumerが保持していたtexture /
   topology pinをrelease
5. shared atlas / topologyは他pinがなくなった時だけretire

candidate失敗そのものはcommitted resourceへ触れず、その後のbase-only atomic commit
が旧ownerのpin releaseを担う。

同atlas digestならrender generation、station、sprite instanceの変更後もtexture upload
は0とする。同batch digestならinstanceを再利用し、camera-onlyではuniformだけを更新
する。異batch digestではinstanceだけを更新し、texture / topologyを再利用する。

## 5. Coverage Semantics

### 5.1 User-facing status

利用者向け earthquake coverage は、要求された style code と表示可能 component の
結果を表す。

- complete: source が提供すると宣言した required visible code / component が解決
- loading: exact tile または material / texture の準備中
- incomplete: required visible code、station input、hypocenter input の実欠損
- hidden: overlay null、source switch、fail-closed

震源座標や観測点が API 上で提供されない telegram は「正常にcomponentなし」で
あり、overlay 全体を incomplete にしない。source が座標 / 観測点を提供したのに
変換・sprite input・atlasが不正な場合は incomplete または failure とする。

### 5.2 Diagnostic status

debug diagnostic は別に次を保持できる。

- visible canonical tile count
- authoritative empty tile count
- source layer absent tile count
- missing / invalid property feature count
- decode / schema failure
- required code unresolved count
- station count
- sprite count

Asset Pack行政区域overlayでは、signed semantic sidecar等のverified evidenceが空を
明示した場合だけauthoritative emptyとする。tile内に対象source layerが存在しない
だけでは空を証明できないためincompleteを維持する。required codeが未解決、required
propertyが不正、decode / schema failureもincompleteとする。explicit empty layer、
absent layer、corrupt layerを別fixtureで検証する。

`EarthquakeOverlayCoverageSnapshot` はcommit済み`MapOverlayVersionStamp`とcoverageを
atomicに通知する。data / render versionのいずれかが一致しないcoverageをappへ適用
しない。必要ならdiagnosticを同snapshotへ追加する。

## 6. App Data Flow

```text
latest earthquake list
  -> event detail
  -> EarthquakeMapOverlayBuilder
       -> region / city maximum intensity styles
       -> deduplicated station observations
       -> validated hypocenter sprite feature
  -> asset atlas provider
  -> full earthquake overlay snapshot
  -> BaseMapView
```

loading、event switch、error、no intensity では旧 overlay を null にする。event A の
detail / asset / material が event B switch 後に完了しても A を publish しない。

atlas decode は provider で一度だけ行い、widget build 内で行わない。例外や stack
trace を banner に直接表示しない。

## 7. Debug UI

デバッグ地図は最低限次を表示する。

- current event ID / data sequence / render generation
- region / city / station / sprite counts
- coverage state
- `震源へ移動` action
- current zoom

長い diagnostic は折り返し可能な developer detail とし、地図操作を妨げる固定高を
置かない。

Simulator / emulator を agent が操作する前にユーザーへ通知する。ユーザーが操作中
なら agent は入力せず、ユーザー操作後に screenshot / log を read-only 採取する。

## 8. Testing

### 8.1 Package tests

- atlas validation、defensive copy、bounds / byte limits
- sprite feature validation、duplicate / unknown region rejection
- exact instance bytes、stride、offset、premultiply
- atlas top-left / RGBA / straight-alpha / sRGB / padding / sampler ABI
- zoom linear clamp / step equalityと既存MapLibre size / fade fixture
- policy batch digest、同policy grouping、caller上限超過拒否
- nearest date-line wrap、logical pixel size、zoom fade
- zero sprite、one batch / one geometry / one node
- same version / digestのidempotent camera-only reuse
- same data sequence / different data digest rejection
- same data version / higher render generationのtheme・atlas replacement
- same render generation / different render digest rejection
- material / texture reflection fail-closed
- source / context / background / dispose fence retirement
- shared atlasの片方更新 / 削除、candidate失敗時のresource pin維持
- command camera clamp、supersede、pre-attach / post-dispose failure
- controller attach / detach / reattach / double attach
- committed camera getter / listenableと再attach時restoration
- antimeridian fit、padding、DPR、viewport resizeの数値fixture
- authoritative empty と実欠損 coverage の区別

### 8.2 App tests

- hypocenter `CoordinateLatLng` だけを feature 化
- coordinate missing / description / unknown で固定位置を作らない
- event switch / late completion / asset failure
- existing station maximum / deterministic order regressions
- banner が committed version stamp だけを表示
- camera action visibility と一度だけの command

### 8.3 Runtime gate

verified Asset Pack と実 API event を使用する。固定の fake event を成功根拠にしない。

iOS Simulator と Android emulator / device で次を確認する。

- Impeller / Flutter GPU backend log
- base + region Fill + station + hypocenter
- zoom 5.999 は region、station hidden
- zoom 6 は city、station visible
- pan / pinch 追従
- 震源へ移動
- MapLibre基準とのcenter / zoom / projected pixel tolerance
- antimeridian、viewport resize、state restoration
- event switch
- background 30 秒 / foreground
- Scene / GPU exception が連続しない
- source switch / dispose 後の resource 上限

市区町村、観測点、震源の画面確認ができない場合、本 subproject は完成扱いにしない。

## 9. Migration Gate

本 subproject ではデバッグ地図へ実装する。地震詳細 MapLibre の削除は行わない。

本番地震詳細への切替は、別 task で次を確認後に行う。

- existing normal hypocenter size / fade parity
- station display mode / label setting parity
- hypocenter below-stations mode
- hypocenter error rectangle
- fit bounds / focus behavior
- Light / Dark theme
- iOS / Android profile performance

## 10. Out of Scope

- low-precision EEW hypocenter consumer
- hypocenter error rectangle renderer
- estimated intensity remote PMTiles
- EEW P/S wave
- KMON live points
- station labels
- production MapLibre removal
