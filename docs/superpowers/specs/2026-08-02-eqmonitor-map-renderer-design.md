# EQMonitor専用Flutter地図レンダラー設計

## 目的

MapLibre Nativeへの描画依存を段階的に置き換えるため、Flutter SceneをGPU描画基盤とするEQMonitor専用地図パッケージ`packages/eqmonitor_map`を新設する。

PMTiles内のMVTと型付き動的データをDart側で解釈し、Fill・Line・Point・CircleをFlutter Sceneで描画する。ラベルは事前計算済みアンカーを使い、Flutterの`TextPainter`で描画する。

## 確定事項

- 初期対象はiOSとAndroidのみ。
- 初期カメラは北固定・真上視点とし、bearingとpitchは実装しない。
- Flutter master channelとFlutter Sceneの利用を許容する。
- Flutter Sceneはadapter境界の内側へ隔離し、FlutterとFlutter Sceneのrevisionを固定する。実装着手前にiOS/Android実機spikeを通す。
- MapLibre Style JSON互換は持たず、型付きの独自レイヤー定義を使う。
- ラベルの地理anchorはPMTiles生成時に専用Pointレイヤーへ1点だけ格納する。表示位置候補はrendererが実測文字サイズとDPRからscreen上に生成する。
- ラベルanchorを含むbase PMTilesは既存Asset Pack manifest/item schema v1と既存asset IDを維持したまま後方互換に拡張し、生成器、release検証器、signed sidecarのschema/summary attestationをrendererより先に用意する。
- 動的更新でGeoJSONを介さない。
- runtimeの`MapNode`を含む主要データモデルは不変かつ原則Freezedとする。JSONは明示的な保存・通信DTO/specだけに要求する。
- FlutterのWidget型は使わず、Widget/Elementに似た宣言と実体の分離を採用する。
- 性能HUDは後続実装とするが、性能観測基盤は初期実装に含める。
- 将来の3D、地下震源、断層表示に備え、座標モデルからZ軸を削除しない。
- 既存MapLibre実装は機能・障害時挙動の同等性を確認するまで残す。
- 新しいHome rendererは回転gestureを無効化して北固定を明示する。legacy MapLibre surfaceが残る間は共有`lockBearing`設定とUIを維持し、全surface移行後の削除は別途承認する。
- 実装は依存順のstacked PRで提供する。

## 対象外

初期実装では次を対象外とする。

- bearing、pitch、透視投影
- 3D地形、地下震源、断層面
- Web、macOS、Windows、Linux
- 線上ラベル
- 任意のMapLibre Style JSON
- 汎用地図パッケージとしての公開
- Performance HUD
- Widget、Golden、実機性能試験の完成

## 公開API

利用側は不変な`MapScene`を宣言し、`EqmonitorMapView`へ渡す。

```dart
final scene = MapScene(
  children: [
    PmTilesSourceNode(
      key: const MapNodeKey('base-map'),
      source: baseMapSource,
      children: [
        FillLayerNode(
          key: const MapNodeKey('countries-fill'),
          spec: countriesFillSpec,
        ),
        LineLayerNode(
          key: const MapNodeKey('region-line'),
          spec: regionLineSpec,
        ),
        LabelLayerNode(
          key: const MapNodeKey('city-label'),
          spec: cityLabelSpec,
        ),
      ],
    ),
    ObservationPointLayerNode(
      key: const MapNodeKey('observations'),
      data: observationSnapshot,
    ),
    WaveCircleLayerNode(
      key: const MapNodeKey('ps-wave'),
      data: waveSnapshot,
    ),
    CurrentLocationLayerNode(
      key: const MapNodeKey('current-location'),
      data: currentLocationSnapshot,
    ),
  ],
);

EqmonitorMapView(controller: controller, scene: scene);
```

主要公開境界は`EqmonitorMapView`、`EqmonitorMapController`、`MapScene`、各`MapNode`、型付きsource/layer/featureモデルとする。

## モデルと実行時オブジェクト

座標、カメラ、source、layer、feature、ラベル候補、hit test結果、エラー、性能snapshotなどのruntimeモデルは不変とし、原則Freezedで表現する。`json_serializable`を必須にするのは、設定の永続化、API/manifest/schemaなどJSONを契約に使う明示的な保存・通信DTO/specだけとする。runtimeの`MapNode`、frame snapshot、hot snapshot/deltaをJSON経路へ通すことは要求しない。

Flutter SceneのGeometry/Material、GPU buffer、`TextPainter`、Controller、Repository、HTTP clientなど、状態や外部資源を持つ実行時オブジェクトはモデルに含めず、JSON対応の対象外とする。

動的データsourceは`sourceInstanceId`と単調増加する`snapshotRevision`を持つ。full snapshotは`sourceInstanceId`、`snapshotRevision`、重複のない安定Feature IDの完全な集合を持ち、省略されたFeatureは削除済みとみなす。deltaは`sourceInstanceId`、`baseRevision`、`targetRevision`、重複のないFeature IDごとの`upserts`と`removals`を持ち、同じIDを両方へ含めない。

動的・現在地source snapshotは、型付き`observedAtUtc: UtcInstant`、注入`MapClock`で受信時に取得した`receivedAt: MonotonicInstant`、source policy由来の`staleAfter: Duration`、`validUntil: MapValidityDeadline`を必須とする。`MapValidityDeadline`はUTC deadlineと同じclock domainのmonotonic deadlineを持つ。producerがexpiryを持たない場合もappのversion付きpolicyが明示的に決め、rendererの固定値や暗默defaultで補わない。monotonic instantはprocess/clock domainを跨いでserializeしない。

freshnessはload stateと直交する型付き状態`fresh`、`stale`、`expired`として評価する。localな経過時間は`MapFrameSnapshot.monotonicNow - receivedAt`だけで計算し、wall clockの巻き戻りや進みによってfreshへ戻さない。`staleAfter`を超え、かつ`validUntil`前なら`stale`とし、source identity、revision、`observedAtUtc`、receipt ageをUI、semantics、性能eventへ公開する。monotonic deadline到達、clock domain不一致、または保守的なUTC検証で失効した場合は`expired`とする。producerの観測時刻が許容skewを超えて未来、expiryが観測時刻以前、またはUTC expiryが受信時点ですでに過去なら、version付きsource policyに従ってvalidation errorまたは即時`expired`とし、wall clockだけを根拠に有効期間を延長しない。expired hazardは継続animationを停止して描画対象から除外し、fail closedのtyped unavailable stateを公開する。expired current locationも同様に描画しない。

full snapshotは、authoritative full-snapshot channelのidentity/trust、envelope、revision、canonical content digest、Feature ID重複、全Featureの型・時間metadata・semantic/resource limitを完全に検証してcandidate stateを構築した後で、Feature集合・revision・digest・時間metadataを1回でatomic commitする。同一`sourceInstanceId`の低いrevisionはstaleとして拒否する。同一revisionはidentityとdigestが一致するときだけidempotent no-opとし、digestの異なる同一revisionはconflicting-equal errorにする。gap/branch latchは、latch時点より新しいauthoritative full snapshotのcommit成功後だけ解除する。equal no-opや検証失敗では解除しない。新しい`sourceInstanceId`は検証済みfull snapshotのatomic commit成功時にだけ旧sourceを置き換え、失敗時は旧state/latchを保つ。

deltaは全項目を検証してから1回のcommitでatomicに適用する。`targetRevision <= currentRevision`または既適用の`targetRevision`はduplicate/staleとして拒否し、`baseRevision > currentRevision`はgap、`baseRevision < currentRevision`かつtargetが新しい場合は枝分かれしたstale deltaとして拒否する。`targetRevision`は`baseRevision`より大きくなければならない。どの拒否でも既存feature集合とrevisionを変更しない。gapまたは枝分かれを検出したsourceはdelta受付を停止し、full snapshot resyncを要求する。新しい`sourceInstanceId`はfull snapshotからだけ開始する。Feature単位revisionだけで完全性を推論する代替契約は採用せず、削除はdeltaの`removals`、完全性はfull snapshotでのみ表す。

reconcilerはkey、型、revision metadataだけを比較し、geometry collectionのFreezed deep equalityやhashをhot pathで実行しない。描画経路でJSONへの変換は行わない。

isolate間payload、GPU upload command、毎frameのpoint instance deltaは、JSON DTOとは別のversion付きimmutable runtime型とする。必要に応じてFreezedを使えるがJSON変換は要求せず、外部保存へ流用しない。

## 宣言的Nodeツリー

Flutter内部APIへ結合せず、地図専用の軽量reconcilerを実装する。

```text
MapNode            不変な宣言、原則Freezed（JSON必須ではない）
  ↓ keyとnode型でreconcile
MapElement         mount/update/unmountと実行状態
  ↓ command queue
MapRenderObject    CPU meshとGPU resource
```

`MapNode`は毎回再生成してよい。同じkeyとnode型なら`MapElement`を更新し、異なる場合はunmount後にmountする。ネットワーク取得やGPU操作は宣言の組み立て中に実行せず、command queueをrender tickで適用する。各drawable node/specはresolve時に明示的な`MapRenderPhase`を必ず持ち、宣言順は同一phase内の順序だけを決める。v1ではphaseを跨ぐinterleaveを許可せず、後述のcanonical `RenderSortKey`だけを描画順とhit test順の正本とする。

設定変更はstyleのみ、filter/source layer、動的feature、source交換に分類し、必要な範囲だけ再構築する。GPU resourceの解放は描画中・実行中のGPU参照を避け、後述のretirement方式で行う。

各`MapElement`とsource mountは再利用されないincarnation tokenとowned cancellation scopeを持つ。network、worker、label、uploadを含む全async継続はawaitの前後でmounted状態とtokenを検証する。command queueはsource内で順序を保証し、同一resourceへの更新はlast-writer-wins、disposeはidempotentかつawait可能にする。古いtokenの結果とエラーはattachmentも通知もしない。

rendererに`MapClock`を注入し、render開始時の1回のcaptureで`wallNowUtc`と`monotonicNow`を同時に凍結する。immutable `MapFrameSnapshot`はこの両時刻とclock domain、camera、viewport、DPR、source/layer revision、app lifecycle、Flutter Scene context generationを固定する。P/S波、pulse、freshness、expiryを含む全time-dependent nodeはこのsnapshotの時刻だけを使い、nodeごとにclockを再取得しない。各render nodeはdirty reasonと`needsContinuousFrame`を返し、期限内のtime-dependent nodeだけが継続frameを要求する。detach/backgroundではanimation、request、decode、uploadを停止し、resume後は新しいcaptureでfreshness/expiryを再評価してから描画する。

CPU frame終了はGPU完了を意味しない。GPU resourceはFlutter Scene/Flutter GPUのcompletion通知、または実機検証したframes-in-flight世代方式でretireする。context generationが変わったresourceを再利用しない。

## 座標系

MapLibre Nativeの座標変換を参考に、次の段階を明示する。

```text
WGS84 Geographic
  → normalized Web Mercator world
  → Z/X/Y tile
  → MVT tile-local extent
  → camera-relative world
  → clip
  → screen
```

参考: https://maplibre.org/maplibre-native/docs/book/design/coordinate-system.html

地理座標は経度、緯度、`altitudeMeters`を保持する。地表は0、地下は負、地上は正とする。初期描画は正射影でも頂点を常にXYZで扱い、将来の投影変更でfeatureモデルを変更しない。

高zoomや将来の3DでGPU float精度を失わないよう、カメラ中心を原点とするorigin rebasingをrenderer境界で行う。高度からworld Zへの変換はprojection層へ集約し、メートルとMercator単位を混在させない。

- projection入力の緯度はWeb Mercator限界の±85.0511287798066°へclampする。元のWGS84値は変更しない。
- cameraはdate lineを連続移動できるunwrapped longitudeを持ち、tile addressは`[-180, 180)`へ正規化したlongitudeと明示的なworld wrapを使う。
- normalized worldはXが東、Yが南、Zが上とする。CPU地理計算は`double`、GPUはorigin rebasing後の`float`とする。
- CPU行列はcolumn vectorとして`clip = projection * view * model * position`の順に適用する。Flutter Scene固有表現への変換はadapter内だけで行う。
- screen APIとhit testはlogical pixelを使い、Scene surface境界だけでDPRを掛けてphysical pixelへ変換する。
- altitudeは緯度`lat`で`altitudeMeters / (earthCircumference * cos(lat))`のnormalized Mercator Zへ変換し、clamp済み緯度を使う。
- P/S波の距離は地表のgeodesic meter radiusとし、方位ごとの地理座標を求めてから投影する。Mercator平面上の単純な円を距離表現には使わない。

## 静的タイルデータフロー

```text
camera change
  → TileCoverCalculator
  → TileScheduler
  → PmTilesTileRepository
  → MVT bytes
  → worker isolateでdecode/geometry/label candidate生成
  → TransferableTypedData
  → UI isolateでFlutter Scene Geometryとlabel stateを更新
```

cacheとrender entryの`TileKey`は`sourceInstanceId`、`sourceRevision`またはcontent digest、canonical Z/X/Y、world wrapを持つ。source交換時は新しいidentityを発行し、異なるrevisionのtileを引き継がない。source zoomは連続camera zoomからMapLibreと同じ規則で決定し、sourceのmin/max zoomで制限する。max zoom超過時は親タイルからoverscaled childへの座標変換とclipを明示して描画する。

中心に近いタイルを優先し、同じtile identityの重複取得を抑止する。カメラ移動で不要になった処理はキャンセルし、frame generationまたはincarnation tokenが古いworker結果をGPUへアップロードしない。workerは上限付きpersistent poolとし、queue backpressure、priority変更、decode/geometry構築中のcancellation checkpointを持つ。

MVT decode結果と描画データを分離する。再利用可能な頂点、layer別index、material bucket、Feature IDとgeometry rangeの対応を保持し、色や表示状態の変更でMVTを再decodeしない。

worker出力はversion付きflat payloadとする。`TransferableTypedData`内にvertex/index buffer、offset table、feature/property/string table、material bucket metadata、label candidate、構造化decode errorを格納する。payloadのbyte上限と各tableの件数上限、transfer後の所有権を定め、UI isolateでobject graphを再コピーしない。

### PMTilesの信頼境界

PMTiles/MVTはローカルでもremoteでもuntrustedなbounded inputとして扱う。上限値はversion付き`MapDecodeLimits`とAsset Pack schemaへ明示し、隠れた固定fallbackにしない。

- Asset Packの取得、platform/release由来のmanifest trust、v1 manifest/item schema、`sizeBytes`、`sha256`の検証はappが所有する。appは検証後のpath、digest、size、semantic schema/summaryを持つimmutable verified source descriptorを`eqmonitor_map`へ渡す。packageは`app`へ依存せず、未検証pathやmanifest repositoryを受け取らない。
- remoteはHTTPSとallowlist hostを基本とし、redirect回数、cross-host redirect、TLS downgradeをpolicyで制限する。
- remote requestはrange/full-streamとも`Accept-Encoding: identity`を送り、responseの`Content-Encoding`は欠落または`identity`だけを受理する。gzip、brなど非identity表現はarchive offset、size、digestの対象と一致しないためrejectし、透過展開後のbyteを検証対象にしない。
- remote range合成はweakでないstrong ETag、またはAPIが提供して`If-Match`に利用できるimmutable digest/versionを最初のresponseで確立できる場合だけ行う。2回目以降の全Range requestへそのvalidatorを`If-Match`で送り、`206`、requested `Content-Range`、安定したarchive total length、同一validatorを必須とする。各bodyの実byte長は`Content-Range`のinclusiveなstart/endから得る長さと完全一致させる。`412`、validator/total length不一致、validator欠落、body長不一致では、それまでに取得した全byteを破棄してtyped snapshot mismatchにする。
- strong snapshot identityを得られないremoteはrangeを合成せず、identity encodingの上限付き単一full-stream downloadだけを許可する。途中byteを別requestと結合しない。
- archive offsetとlengthはchecked arithmeticで検証し、archive、directory depth/entry、compressed/uncompressed tile bytes、layer、feature、vertex、command、string、triangulation work、decode時間にhard limitを設ける。
- `eqmonitor-backend`のproducer/release validatorはarchive全体を走査し、global coverage、zoom別feature count、必須ID集合、必須propertyと型、zoom範囲を検証する。検証済みsemantic schema/summaryはarchive SHA-256へ結び付けた署名済み、または同等にtrustedなrelease attestationとして配布する。
- runtimeではappがmanifest trust、archive size/hash、attestationとdigestの対応を検証し、packageがPMTiles header/metadataとverified descriptorのschema/summaryの整合を検証する。その後は読み込んだ各tileへ件数、ID/property型、zoom、byte/work上限を適用する。runtimeがarchive全体をscanしてglobal coverageや全件数を再検証するとはしない。
- limit超過、破損、semantic不足は空tileへ変換せずtyped errorにする。malformed/fuzz/decompression bomb/pathological polygon fixtureを単体テストへ含める。

### Asset Pack rollout

初期rolloutでは既存clientを壊さないことを必須とする。manifestと各itemの`schema_version`はv1のまま、asset IDは既存の`BASE_MAP_PMTILES`だけを使い、version付きlabel Point source layerを既存base PMTilesへ追加する。既存clientは未知のsource layerとPMTiles metadataを無視して従来layerを描画できなければならない。新しいasset IDは追加しない。

attestation carrierはmanifest itemではなく、既存PMTilesのbasenameへ`.eqmonitor-attestation.v1.json`を付けたversion付きsigned sidecarとする。たとえば`base_map.pmtiles`に対して`base_map.pmtiles.eqmonitor-attestation.v1.json`を同じ配布directoryへ置く。新clientは`BASE_MAP_PMTILES`の解決済みURL/pathのpathnameへこのsuffixを付けて明示的に取得し、bounded downloadとatomic write後にPMTilesの隣へ保存してreadbackする。認証query/headerはAsset Pack transport policyに従ってsidecar requestへ引き継ぐ。旧clientはmanifest v1に列挙されないsidecarを要求も解釈もしないため、manifest/item schema v1とasset IDを変更しない。

sidecarは`format`、`version: 1`、`keyId`、JCSでcanonical化するpayload、Ed25519 signatureを持つ。domain-separated signature payloadには少なくとも`assetId: BASE_MAP_PMTILES`、archive SHA-256、archive byte size、label schema versionとschema digest、global semantic summary、producer source version、`issuedAtUtc`、`expiresAtUtc`、単調増加`sequence`を含め、これらの変更を署名なしで許さない。v1 manifest itemの`sha256`/`sizeBytes`、実archiveのdigest/size、sidecar payloadの値はすべて一致しなければならない。

app releaseへversion付きtrust policyとしてroot public keyと許可`keyId`、revoked key ID、asset/sourceごとのminimum sequenceを埋め込む。key rotationは旧新keyの重複信頼期間を設けて先にappを配布し、revokedまたはunknown keyは拒否する。appはasset/sourceごとの最高accept済みsequenceとdigestを永続化し、低いsequenceをrollback、同一sequenceで異なるdigestをconflicting replayとして拒否する。同一sequenceかつ同一digestだけをidempotent readbackとして許可する。意図的なrollbackは、対象sequenceとdigestを明記した新しいapp trust policyまたは、より高いsequenceで再署名したreleaseだけで行う。missing sidecar、unknown format/version/key、invalid/revoked signature、payload/manifest/archive mismatch、expired attestation、replay/rollbackはtyped verification errorにし、新rendererはbase/label sourceをmountせずfail closedでunavailableを表示する。legacy rendererの既存manifest v1 pathは移行期間中この判定と分離する。

producerは既存basemap layerの互換性fixtureと新旧client fixtureを通し、global semantic summary/schemaをrelease attestationへ出力する。`eqmonitor-backend`のB1はsidecar生成・署名、key rotation sample、archive/size/schema/summary/source version/時刻/sequenceのmutation、旧新client fixtureを所有する。EQMonitor PR 05はsidecar discovery/download/readback、署名・unknown/revoked key・expiry、同一sequence replay、rollback拒否、明示的rollback許可、manifest/archiveとのbinding fixtureを所有する。manifest/item schemaを変更する方式は、producer先行、旧新consumer共存、store rollout、rollbackを別途実証したrelease sequenceが承認されるまで採用しない。

## 描画

Flutter SceneのScene GraphをFeature単位では使用しない。`tile × layer × material`単位でmeshを結合し、GPU bucketを生成する。

描画順の唯一の権威は`render phase → phase内宣言layer order → source order → overscaled tile order → feature order`からなるcanonical `RenderSortKey`とする。各resolved drawable node/specはversion付き`MapRenderPhase`を明示し、treeのpre-orderをphaseでfilterした値だけを`declarationOrderWithinPhase`へ使う。v1のphase境界を跨ぐ宣言順interleaveは無効であり、batchingやsource traversalから別のglobal順序を導出しない。material batchingは同じkeyの連続範囲だけを結合する。labelとleader lineは常に`labelForeground` phaseへ解決し、collision用priorityとは別にこのkeyを持つ。geometry、icon、採用済みlabelのhit testは同じkeyの降順、すなわち画面上側から走査する。

- Fillは穴付きPolygonをtriangulationする。
- Fill/LineはMVT extent外bufferをmesh構築とtile edgeのjoinに保持し、最終描画はtile境界へscissorする。ring winding、hole分類、degenerate/invalid ringのreject規則を固定する。
- Lineはjoin/cap/width、miter limit、antialiasingを反映したmeshへ展開し、隣接tileで端点処理が変わらないようbuffer内のline continuationを使う。
- 観測点はinstance bufferを利用する。
- 震源や震度アイコンはtexture付きquadを利用する。
- P/S波は中心とgeodesic半径からsegmentを更新し、instance/update bufferだけを差し替える。
- 区域状態変更はFeature IDに対応するindex rangeを再構成する。

動的点群はWGS84からnormalized projectionへの結果をFeature ID単位でcacheし、zoom変更時はscaleとscreen transformだけを更新する。投影済み点とflat grid spatial indexを描画候補、label collision、hit testでimmutableに共有する。少数点は線形探索、多数点はgridを使う閾値をpolicyで設定する。hover/selectionはcollection objectではなく安定Feature IDで更新後のfeatureへ再束縛する。

### Flutter Scene adapterと実装gate

domain、reconciler、packed meshはFlutter Scene型へ依存させず、`MapSceneRendererAdapter`境界でGeometry/Material/bufferへ変換する。Flutter SDK revisionとFlutter Scene package revisionをlockfileと設計記録へ固定する。

`02-scene-spike`のiOS/Android実機manual smokeでは、正射影のprocedural tile
mesh、custom material、部分buffer更新、TextPainter overlay合成、surface
resize、dispose/remount、background/foreground後のresource rebuildを確認する。
未実施や失敗はTODOに記録し、証跡判定でfoundation実装を停止しない。

## ラベル

PMTilesの専用Pointレイヤーは、Feature geometryとして1つの地理anchor、安定ID、文字列、優先度、zoom範囲を持つ。alternate geographic anchorやleader line属性はMVTへ持たせない。layer IDとproperty型、ID生成規則、zoom policyをversion付きAsset Pack semantic schemaで管理し、生成器・producer validator・fixtureをrendererと同じ契約で検証する。

表示対象tileから候補を収集し、source/layer/安定ID/world wrapで重複を解決した後、地理anchorをscreen座標へ投影する。rendererは`TextPainter`の実測boundsとDPRからright、left、up、downのscreen placement candidateを生成する。候補は優先度、phase内layer order、stable ID、screen placement orderの決定的collision keyで配置し、画面端補正を行う。採用後のlabelとleader lineは`labelForeground`のcanonical `RenderSortKey`だけで描画・hit testする。既定のright以外へ退避したlabelのleader line要否、長さ、stroke、描画閾値はversion付きrenderer policyで決め、asset schemaへは含めない。

`TextPainter`は文字列、text direction、locale、font family/fallback/load generation、weight/features、letter/word spacing、height、color、`TextScaler`、width、max lines、ellipsis、theme generation、DPRを完全なkeyとして、byte/count上限付きLRUでcacheする。font load、theme、locale、text scale、DPR、accessibility変更で対応entryをinvalidateする。カメラ移動時は原則再layoutせず、screen位置とcollisionだけを更新する。

直前frameの配置へ限定的なhysteresisを与えてzoom境界のちらつきを抑えるが、priority変更を上書きしない。採用ラベルはFlutter Scene前景の`CustomPainter`で画面正立に描画する。装飾labelと操作・防災上重要なlabelを分類し、後者は`semanticsBuilder`または対応する`Semantics` surfaceで読み上げ、focus、activateを提供する。

## Hit test

`MapQueryRequest`はlogical pixelのpointまたはbox、対象layer key、hit toleranceを持つ。screen座標をworld、tile、tile-local座標へ逆変換し、現在commit済みの`MapFrameSnapshot`と空間indexだけを同期的に検索する。networkやdecodeは開始しない。

visibility、min/max zoom、filter、fill hole、描画時のline/icon/label boundsを先に解決し、実際に描画したgeometryとscreen-space widthで判定する。結果はsource/layer/Feature IDの規則でtile/wrap重複を除き、canonical `RenderSortKey`の上側から、型付きpropertiesとprovenanceを含む`MapQueryResult`として返す。現在の`queryLayers`利用箇所ごとにparity fixtureを作る。

現在の`queryLayers` callerはIntensity HistoryとEarthquake History detailsの2箇所であり、Home移行のgateにはしない。両surfaceの後続移行では、query hitだけでなく、その後に行うタップ地理座標からの最寄りJMA region/city、観測station/Shindo DB station検索とpopup/drill-downまでをparity gateにする。

## 現在地

appはpermission、location service、lifecycleを扱い、`CurrentLocationLayerNode`へ`availableFix`または理由付き`unavailable`を渡す。fixはcoordinate、非負の`accuracyMeters`、`observedAtUtc`、`receivedAt`、`staleAfter`、`validUntil`、任意のcourse/speedと各値のvalidityを持つ。利用不能時に固定座標や疑似fixへfallbackしない。

- available fixは現在地点とgeodesic meterのaccuracy radiusを描画する。accuracyが非finite、不正、またはapp policyの信頼上限外ならradiusを描画せず、その理由をobservable stateへ残す。
- course indicatorは有効なcourseとapp側の信頼判定がある場合に、真北基準の向きで表示する。北固定cameraは地図の回転を止めるだけで、course indicatorを削除する根拠にはしない。
- pulseはfresh fixだけに使い、`CurrentLocationPolicy`の周期・振幅、app lifecycle、reduced motionに従う。background、stale、reduced motionでは静止表示にする。
- frameの`monotonicNow - receivedAt`が`staleAfter`を超えたfixはstaleとし、pulseとcourseを止め、point/accuracyをstale styleへ変更し、semanticsとperformance eventへprovenanceとreceipt ageを公開する。`validUntil`到達時はexpired unavailableとして全geometryを除去する。
- unavailableではpoint、accuracy、courseを描画せず、permission denied、service disabled、no fixなどのtyped reasonをappへ通知する。appが適切な案内やretryを表示する。

## Cacheとエラー

PMTiles bytes、decoded MVT、CPU mesh、GPU resource、TextPainterをresource ownership graph下のcacheで管理する。cache別上限に加えてaggregate CPU/GPU budgetを持ち、可視・upload中・frames-in-flightのresourceをpinする。容量、先読み、並列取得、retry、eviction順は設定モデルへ明示し、隠れた固定fallbackを設けない。

読み込み中や部分的な取得失敗のfallbackはsource criticalityごとに定義する。basemapは同一source revisionの直前正常tileまたは有効な親tileをprovenanceとage付きで維持できる。event固有・hazard sourceは異なるrevisionのtileを絶対に維持せず、fail closedして利用不可・stale状態を明示する。壊れたPMTiles/MVTを空tileとして扱わず、失敗データをcacheしない。古い処理のcancelはエラーにしない。

エラーはsource identity、TileKey、失敗段階、再試行可能性、provenance、ageを持つFreezed unionとして通知する。loadの集約状態は`ready`、`loading`、`degraded`、`failed`とし、sourceの`fresh`、`stale`、`expired`とは別々に保持・通知する。一部basemap tile失敗で動的レイヤーを消さない。同一原因のtile errorは集約key、count、代表sampleを持たせ、rate limitとbounded deliveryで通知する。

memory pressureでは非可視・非pin resourceから削除する。background/surface loss/context generation変更ではGPU resourceを破棄し、保持済みCPU mesh、decoded data、または再decodeの順で再構築する。current/peak bytes、pin、eviction/rebuild原因を性能snapshotへ記録する。

## 性能観測

初期実装からframe reconciliation、tile cover、label placement、render submission、tile request、decode、mesh build、GPU uploadをmonotonic clockで計測する。queue待機と実行、GPU submissionとcompletionを分離する。Flutterの`FrameTiming`でbuild/raster/vsync超過を取得し、cache hit/missとcurrent/peak bytes、request/decode byte、tile queue、GPU bucket、label候補/採用数、動的feature差分数、node/layer名とfeature数も集約する。

Controllerはversion付き`ValueListenable<MapPerformanceSnapshot>`と`Stream<MapPerformanceEvent>`を公開する。観測レベル、sampling、集約window、percentile、snapshot更新間隔、ring buffer容量、drop policyを`MapPerformancePolicy`で設定可能にし、通常時はrate-limitedな軽量集約、デバッグ時はboundedなtile単位イベントを利用できるようにする。fixture IDをmetricsへ含め、instrumentation overhead budgetも計測する。

HUD、Widget/Golden test、実機性能試験は後続TODOとするが、後から計測方式を変更しない。

## KEViから採用する知見

先行実装として、MIT Licenseの[ingen084/KyoshinEewViewerIngen](https://github.com/ingen084/KyoshinEewViewerIngen/tree/5a2bf513b6b9c93ee06473f70b6d27ee96070b3f) commit `5a2bf513b6b9c93ee06473f70b6d27ee96070b3f`を参照した。

- [`MapControl.cs`](https://github.com/ingen084/KyoshinEewViewerIngen/blob/5a2bf513b6b9c93ee06473f70b6d27ee96070b3f/src/KyoshinEewViewer.CustomControl/MapControl.cs)と`MapLayer`で観測したUI/render間state snapshot、`RefreshRequested`、`NeedPersistentUpdate`を、`MapFrameSnapshot`とframe schedulingへ反映する。変更種別を表すtyped dirty reasonはEQMonitor側の強化であり、KEVi由来とはしない。
- [`MapLayerHost.cs`](https://github.com/ingen084/KyoshinEewViewerIngen/blob/5a2bf513b6b9c93ee06473f70b6d27ee96070b3f/src/KyoshinEewViewer.Map/Layers/MapLayerHost.cs)の宣言順描画・逆順hit testをphase内orderの参考にし、cross-phase orderはEQMonitorのcanonical `RenderSortKey`で固定する。
- [`PointLayoutCache.cs`](https://github.com/ingen084/KyoshinEewViewerIngen/blob/5a2bf513b6b9c93ee06473f70b6d27ee96070b3f/src/KyoshinEewViewer.Map/Layers/PointLayoutCache.cs)と[`NormalizedPointSet.cs`](https://github.com/ingen084/KyoshinEewViewerIngen/blob/5a2bf513b6b9c93ee06473f70b6d27ee96070b3f/src/KyoshinEewViewer.Map/Layers/NormalizedPointSet.cs)で観測したarray-backed point dataとprojection cacheを参考にする。projection結果とflat spatial indexをimmutableに共有することはEQMonitor側のpolicyである。
- `HoverTracker`で観測したのはcaller提供のequalityによる再照合である。安定Feature IDによるhover/selection再束縛はEQMonitor側のpolicyとする。
- [`MapLayerLabelRenderer.cs`](https://github.com/ingen084/KyoshinEewViewerIngen/blob/5a2bf513b6b9c93ee06473f70b6d27ee96070b3f/src/KyoshinEewViewer.CustomControl/MapLayerLabelRenderer.cs)の実測文字サイズに基づくscreen placementとleader lineをrenderer policyの参考にする。alternate geographic anchorをKEViへ帰属させず、assetには1つの地理anchorだけを格納する。

KEViはSkia/Avaloniaの直接描画で、PMTiles/MVT tile engineではない。Miller projection、1回だけのlongitude wrap、全体`SKPicture` invalidation、host lock中のrender、次frameでのresource dispose、毎frame全再描画は採用しない。tile selection、overzoom、wrap、Web MercatorはMapLibreの仕様・実装を正とする。

## 初期検証

初期実装では純粋ロジックの単体テストを必須とする。

- WGS84、Mercator、tile-local、screenの往復
- Mercator緯度限界、date line、最大zoom、複数DPR、正負の高度、geodesic半径
- tile cover、overscale child transform、world wrap、canonical render order
- MVT Point/LineString/Polygonと穴付きPolygon
- extent外buffer geometry、tile edge line、invalid ring、resource limit、malformed/fuzz payload
- Node/Elementのmount/update/reorder/unmount、同じkeyのremount、await中cancel、source交換、controller dispose
- full snapshotと`baseRevision`/`targetRevision` deltaのatomic apply、duplicate/stale/gap reject、remove、full resync
- full snapshot resyncの低revision、同一revision同一digest no-op、同一revision異digest、malformed full、gap後のequal/新revision、sourceInstanceId交換成功/失敗fixture
- fake `MapClock`を進めるfresh/stale/expired境界、wall-clock skew、background/resume、source停止、現在地expiryとexpired hazardのanimation停止/fail-closed fixture
- strong ETag/immutable validator付きrange、`If-Match`、`Accept-Encoding: identity`、非identity `Content-Encoding`拒否、`206`/total length/`Content-Range` body長検証、range間でarchiveが変異して`412`またはvalidator不一致になるfixture、validatorなしidentity full-stream。これらのremote byte fixtureはPR 04で実装する
- producerのglobal semantic fixtureと、runtimeのdescriptor/metadata整合・bounded per-tile検証。B1でsidecar signing/mutation、PR 05でsignature/readback/replay/rollback fixtureを実装する
- ラベル重複排除、決定的優先順、right/left/up/down screen placement、衝突、leader line policy、hysteresis、cache invalidation、semantics
- hit test parity、stale generation破棄、aggregate cache eviction、context generation rebuild

## Delivery graph

### Cross-repository prerequisite

`eqmonitor-backend`側で先に`B1-label-asset-release` milestoneを完了する。既存base PMTilesへversion付きlabel Point layerを後方互換に追加するgenerator、archive全体のsemantic validator、version付きsidecar生成・署名、署名payload mutation/旧新client fixture、Asset Pack releaseを同repositoryでreview・releaseする。このbranch/PRは`eqmonitor-backend`の既定branchまたは同repository内の先行branchから分岐し、EQMonitor repositoryのbranchやPRを祖先にしない。EQMonitor側はrelease済みartifact digestとattestationをfixtureとして受け取る。

### EQMonitor repository stacked PRs

EQMonitor側の後続PRは前のEQMonitor PRだけへ依存させ、各stackを単独でreview可能にする。backend prerequisiteはbranch ancestryではなく、release artifact contractとして依存する。

1. `01-design`: 設計書、README、知見、将来TODO
2. `02-scene-spike`: minimalでcompile可能な`packages/eqmonitor_map` scaffoldとmanual smoke exampleを作成し、revision固定とadapter prototypeを確認
3. `03-foundation`: モデル、座標、Node/Element、FrameSnapshot、render order、packed mesh/render command契約とfake、性能観測
4. `04-tile-pipeline`: verified source descriptor、trust policy、PMTiles、MVT、identity-encoded remote byte/range fixture、packed worker payload、tile scheduler、cache
5. `05-label-asset-integration`: backend release fixture、signed sidecar discovery/readback/signature/replay/rollback fixture、semantic schema/summary contract、app側Asset Pack検証とpackage boundary、旧新client compatibility test
6. `06-scene-renderer`: Flutter Scene adapter、Fill/Line、GPU lifecycleとcontext recovery
7. `07-labels`: screen placement候補、collision、TextPainter overlay、leader line、semantics
8. `08-dynamic-interaction`: atomic typed delta、point index、camera、fitBounds、現在地、hit test
9. `09-home-integration`: Home Mapのデバッグ切り替え、北固定/rotation無効化、並行検証。共有`lockBearing`設定は削除しない

各PRはその時点でcompileし、checked-in fixtureに対する実行可能なcontract testを持つ。後続consumerだけが使う未検証APIを先に公開しない。各PRで生成、format、analyze、対象単体テスト、`git diff --check`を実行する。後続branchは直前のEQMonitor stackから分岐し、base PR取り込み時はstackを順番にrebaseする。

## 移行完了条件

Home Mapの移行matrixをstack内でversion管理する。

| 項目 | 移行条件 |
|------|----------|
| pan / pinch zoom | min/max zoom、gesture enable、boundsを含め同等 |
| rotation | 新Home rendererでgestureを明示的に無効化し北固定にする。legacy MapLibre consumer用`lockBearing`設定/UIは維持する |
| camera | 初期位置、fitBounds、date line、viewport resize、状態復元が同等 |
| 現在地 | permission/lifecycle/errorをapp側で扱い、accuracy、course、pulse、fresh/stale/expired、unavailableの規定を型付き`CurrentLocationLayerNode`で満たす |
| theme / layer | Light/Dark再構築、順序、visibility、loading/errorが同等 |
| event / interaction | Homeで利用するgesture event、controller、hover/selectionがparity fixtureを通る。別surfaceの`queryLayers` parityはHome gateに含めない |
| hazard | 観測点、震源、P/S波、区域状態でsource revision、fresh/stale表示、expired fail-closed規則を満たす |
| platform | label asset新schemaとFlutter Scene lifecycleをiOS/Android実機で検証済み |

ベース地図、ラベル、観測点、震源、P/S波、区域状態、camera、現在地、Homeで実際に使うinteraction、障害時表示がmatrixを満たし、性能観測で継続利用可能と判断できるまでHomeのMapLibre pathを削除しない。その後は`docs/todo/780_eqmonitor_map_maplibre_surface_migrations.md`に従って地図surfaceを一つずつ移行し、全surface完了までMapLibre packageと共有設定を削除しない。
