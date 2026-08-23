# eqmonitor_map 地震震度塗り・観測点 GPU 表示設計

## 目的

`packages/eqmonitor_map` の既存ベース地図描画へ、実際の地震詳細データから生成した
JMA震度の区域塗りと観測点円を重ねる。最初の受け入れ地点は、設定内の
`EQMonitor Map (Flutter Scene)` デバッグ画面で、ベース地図・震度塗り・観測点が
同じcamera上に表示されることとする。

本設計は
`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md` の
`08-dynamic-interaction` をすべて実装するものではない。将来のHome移行を妨げない
型付き境界を作りながら、区域塗りと観測点表示を一本の動く縦切りとして先行させる。

## 現状

ベース地図は次の経路で Flutter Scene/GPU まで接続済みである。

```text
VerifiedPmTilesSource
  -> BaseMapTileRepository
  -> BaseMapTileDecoder
  -> BaseMapTileCache
  -> BaseMapPackedMeshCache
  -> MapRenderSubmission
  -> FlutterSceneBaseMapAdapter
  -> SceneView/GPU
```

地震情報は `EarthquakeIntensity` から MapLibre のStyleLayer/GeoJSONへ変換されており、
上記経路とは接続されていない。さらに、現行MVT decoderはfeature IDとpropertiesを
読み飛ばすため、`areaForecastLocalE.code` と
`areaInformationCityQuake.regioncode` を使った区域選択ができない。観測点用の
instance layout、material、shader、Scene adapterも存在しない。

## スコープ

### 含むもの

- MVT v1/v2のstring propertyを上限付きでdecodeする
- `areaForecastLocalE` の `code` と `areaInformationCityQuake` の
  `regioncode` を保持したpolygon meshをtile cacheへ載せる
- JMA震度ごとの地域・市区町村Fillをbase mapより上へ描画する
- 観測点を安定ID、WGS84座標、RGBA色、半径、最大震度強調の型付きsnapshotへ変換する
- 観測点を `StaticInstanceGeometry` による単一GPU batchの円として描画する
- デバッグ画面で最新の震度1以上の地震詳細を取得し、overlayへ変換する
- loading、地震データ取得失敗、震度データなしを地図上の状態表示として区別する
- package単体テスト、app側変換テスト、静的解析、iOS Simulator可視確認

### 含まないもの

- LPGM、震度DB、推計震度tile
- 震度アイコン、観測点名ラベル、震源、P/S波
- tap/hit test、fitBounds、選択状態
- atomic delta API。最初の縦切りはrevision付きimmutable full snapshotの置換のみ
- Home、地震履歴詳細、Live MonitorのMapLibre置換
- MapLibre依存や既存MapLibreレイヤーの削除
- Flutter Scene forkのinstance batching問題そのものの修正
- MVT feature IDの保持。区域codeが安定識別子になるため、この縦切りでは引き続き読み飛ばす

## 採用する構成

### 1. MVT property decode

`MvtFeature` は不変な `Map<String, String>` を保持する。MVTのvalueは仕様上
複数型を持つが、この縦切りで必要なのは文字列の区域コードだけである。string以外の
valueは正しく読み飛ばし、要求propertyがstring以外ならそのfeatureをoverlay対象から
除外する。壊れたtag index、奇数個のtag配列、重複keyはtyped
`MvtDecodeException`としてtile全体をfail closedする。

`MvtDecodeLimits` へ以下を追加し、すべて呼び出し側が明示する。

- `maxKeysPerLayer`
- `maxValuesPerLayer`
- `maxTagsPerFeature`
- `maxPropertyStringBytes`

property文字列のbyte長はlength-delimited payloadを確保・decodeする前に検証する。
既存geometry上限と同様、固定fallbackは置かない。

### 2. 区域geometry

`BaseMapTileGeometry` はベース地図用の集約meshに加え、次のoverlay用geometryを持つ。

```text
EarthquakeAreaTileGeometry
  forecastRegions: CodedFillGeometry(code, meshes)
  cities:          CodedFillGeometry(code, meshes)
```

区域meshは同じMVT featureのgeometryからdecode worker内で生成する。base map用に集約した
meshからfeature境界を逆算しない。`CodedFillGeometry` は1 featureを単位とし、
Uint16上限によって複数segmentになった場合も同じcodeの下に保持する。

overlayは要求tileのexact geometryだけを使う。base mapが親tileへfallbackしていても、
event/hazard表示は親や異revisionへfallbackせず、exact tileが準備できるまでそのtileの
overlayを描かない。破損propertyやsnapshot不整合を空の正常データへ丸めない。
