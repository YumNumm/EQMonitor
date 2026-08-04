# eqmonitor_mapで維持する設計制約

## 初期surface

- `packages/eqmonitor_map`はEQMonitor専用とする。
- 初期対象はiOS/Android、北固定・真上視点とする。
- Flutter Sceneで地物、Flutter `TextPainter`でラベルを描画する。
- ラベルの地理anchorはPMTiles生成時に専用Pointレイヤーへ1点だけ格納し、right/left/up/downのscreen placementはrendererが実測文字サイズとDPRから生成する。
- label schema、backend生成器、producerのglobal validator、signed sidecarによるdigest-bound summary、Asset Pack rolloutをrendererのlabel実装より先に用意する。runtimeはarchive全体をscanしない。
- 動的描画でGeoJSONを介さない。
- 新Home rendererは回転を明示的に無効化するが、残存MapLibre surface用の共有`lockBearing`設定/UIは全surface移行まで削除しない。
- 現在地はapp側で権限とlifecycleを処理し、accuracy、course、pulse、fresh/stale/expired、unavailableを表す型付き動的layerとして渡す。

## 将来互換性

- 地理座標は`altitudeMeters`を持ち、2D段階でもZ軸を削除しない。
- 地表は0、地下震源や断層は負、地上要素は正の高度を使う。
- Geographic、Mercator、Tile Local、Camera-relative World、Screenを別の型と責務で扱う。
- GPUへ渡す座標はcamera origin rebasingを行い、高zoomと3Dのfloat精度低下を避ける。
- bearing、pitch、透視投影、地下表示はfeatureモデルではなくprojection/rendererを拡張する。
- P/S波の距離はgeodesic meter radiusとして計算し、Mercator平面上の円で近似しない。

## 宣言と実体

- 公開APIは不変かつ原則Freezedの`MapNode`ツリーとする。JSONは明示的な保存・通信DTO/specにだけ要求する。
- 内部`MapElement`がkeyとnode型でmount/update/unmountを行う。
- Flutter Widget/Elementの内部APIへ依存しない。
- GPU/HTTP/Controllerなどの実行時資源をJSONモデルへ混ぜない。
- hot pathのpacked payload、snapshot、deltaはJSONを要求しないversion付きruntime型とし、Freezedのdeep equalityでgeometryを比較しない。
- deltaは`baseRevision`/`targetRevision`、重複しない`upserts`/`removals`を持ち、duplicate/stale/gapをatomicに拒否してfull snapshot resyncする。full snapshotは完全なFeature集合で、省略は削除を意味する。
- full snapshotは全検証後にatomic commitする。低revisionを拒否し、同一revisionはidentity/digest一致時だけno-op、競合時はerrorとする。gap/branch latchはより新しいauthoritative fullのcommitだけで解除し、新しい`sourceInstanceId`も検証済みfull commit後だけ交換する。
- renderごとに注入clockからwall/monotonic時刻を1回だけcaptureし、camera、viewport、DPR、revision、context generationとともにimmutable snapshotへ固定する。
- freshnessはload stateと分離し、receipt ageはmonotonic clockで判定する。staleはprovenance/ageを公開し、expired hazard/current locationはanimationを停止して描画せずtyped unavailableへfail closedする。producer時刻の未来skewやexpiryはversion付きpolicyで保守的に検証する。
- async処理はelement/source incarnationをawait前後で検証し、GPU resourceはcompletionまたは検証済みframes-in-flight方式でretireする。

## Sourceとresourceの安全境界

- tile cache keyは`sourceInstanceId`、source revision/content digest、Z/X/Y、world wrapを含める。
- hazard sourceはrevisionを跨いでlast good tileを表示しない。basemapのstale表示も同一revisionに限る。
- appはAsset Pack manifest trust/size/hashを検証し、path/digest/size/schema/summaryを持つimmutable descriptorだけをpackageへ渡す。packageは`app`へ依存しない。
- manifest/item schema v1と既存`BASE_MAP_PMTILES`を維持し、新しいversion付きPoint layerを同archiveへ追加する。新asset IDは作らず、`<pmtiles basename>.eqmonitor-attestation.v1.json`という決定的なsigned sidecarを隣へ配布し、旧clientには無視させる。
- sidecar signatureはasset ID、archive SHA-256/size、label schema/summary、source version、発行/失効時刻、sequenceをbindする。app埋め込みtrust root/key ID、rotation/revocation、高水位sequenceによるreplay/rollback拒否を必須とし、missing/unknown/invalid/expired時は新rendererをfail closedする。
- remoteは`Accept-Encoding: identity`を送り、非identity `Content-Encoding`を拒否する。rangeはstrong ETagまたは`If-Match`可能なimmutable validator、`206`、安定total length、同一validator、`Content-Range`と実body長の完全一致を必須とし、`412`/mismatchで全byteを破棄する。validatorなしはidentity encodingの上限付き単一full-streamだけを使う。
- PMTiles/MVTは件数・byte・decode時間をversion付きpolicyで制限し、壊れた入力を空tileへ変換しない。
- CPU/GPU cacheはaggregate budget、pin、context generation、rebuild原因を観測可能にする。

## 性能観測

- HUDや性能試験より先に`MapPerformanceSnapshot`と`MapPerformanceEvent`を実装する。
- tile request、decode、mesh build、GPU upload、cache、label、frameを同じ計測基盤で観測する。
- Feature単位のScene Nodeを作らず、tile/layer/material単位でbatchする。
- canonical `RenderSortKey`だけを描画順の正本とする。全resolved node/specがphaseを明示し、宣言順はphase内だけに適用してv1ではcross-phase interleaveを禁止する。label/leader lineは`labelForeground` phase、hit testは同じkeyの降順とする。
- metricsはbounded・rate-limitedにし、queue待機、実行、GPU submission/completion、current/peak memoryを分離する。

## Flutter Scene manual smoke

- Flutter SDKとFlutter Scene revisionを固定し、adapterの外へFlutter Scene型を漏らさない。
- iOS/Android実機のprofile/releaseでprocedural mesh、custom material、
  `TextPainter` overlay、partial update、回転、background復帰、resource rebuild、
  dispose/remount、例外counter/logを手動確認する。
- 実機確認の未実施や失敗はTODOで追跡し、foundation実装を停止する
  evidence gateにしない。

## 検証コマンド

Flutter/Dartコマンドは必ず`mise exec --`経由で実行する。

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- flutter test
mise exec -- dart analyze
```
