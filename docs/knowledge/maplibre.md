# MapLibre の表示・ライフサイクル

確認日: 2026-09-21。Home は引き続き MapLibre を使用する。Flutter Scene への移行完了を前提にしない。
対象: `app/lib/core/util/map/`、`app/lib/feature/home/ui/component/map/`、各機能の地図レイヤー。

## 初期化と更新

- `addSource`・`addImage`・`addLayer` は style ごとに初期化し、可変 GeoJSON は `updateGeoJsonSource`、filter は `updateFilter` で更新する。
- paint/layout に更新 API がない場合は layer だけ差し替える。source の再作成は URL など定義自体が変わる場合に限定する。
- 同じ style への操作は `MapOperationQueueScope` の共有キューで直列化する。パラメータや timer tick を初期化 effect の依存へ混ぜない。
- 更新は初期化 Future を待ち、await 前後で lifecycle token を確認する。初期化完了時には開始時の snapshot でなく最新データを反映する。
- dispose は同期的に無効化してから layer → source → image の順に削除する。各削除を独立して試行し、途中の失敗で後続 cleanup を止めない。
- 非同期データの初回取得前はレイヤー Widget をマウントしない。`AsyncValue.valueOrPrevious` を使い、再取得中・失敗時も既存表示を維持する。
- loading overlay は戻る操作を遮らない。再試行 Future の例外は画面の provider 状態で扱い、ボタンから再伝播させない。
- EEW が既に活性中なら controller 接続直後にも現在値を同期する。空の EEW 領域には非表示 filter を返す。

## 描画順・式

- 同じ `belowLayerId` に追加すると後から追加した layer が上になる。順序に依存する layer 群は一括で下→上に構築し、`replaceMapStyleLayers` へ渡す。
- 挿入アンカーは存在する `BaseLayer` を使う。`aboveLayerId` の web 制約にも注意する。
- 震度色を持つ半透明の細分区域・市区町村 fill を重ねない。切替 zoom では下側の opacity を 0 にする。
- iOS の zoom 依存 `interpolate` は式の最上位に置く。倍率は各 stop 値へ畳み込み、乗算式の内側へ zoom 式を入れない。
- iOS の色 `match` は fork 側で型付きの `NSExpression(forMGLMatching:in:defaultValue:)` に変換する。Dart の式テストだけで native の色型変換を検証済みとしない。
- 非表示 filter に `['==', 1, 0]` を使わない。MapLibre Native はこれを旧形式の比較と解釈し、数値の属性名を拒否する。iOS では predicate 設定時に `NSInvalidArgumentException` が発生し、Dart の catch では捕捉できない。地域選択は `RegionMapLayers.hiddenFilter` の空集合への所属判定を使う。

## 座標・選択・初期カメラ

- `LatLng` は `(latitude, longitude)`。bounds の southwest は `(latitudeSouth, longitudeWest)` とし、保存・再読込まで異なる緯度経度値で確認する。
- 緯度経度グリッドは 12 桁スケールの整数 ceil/floor と index の積から生成する。浮動小数の反復加算を避け、負値・`-0.0`・`0.3 / 0.1` などの境界を確認する。
- ポリゴンの地域判定は `nearest_jma_feature.dart` の常駐 worker provider を使う。main isolate で `JmaMapUtility.findNearestItem` を実行しない。全画面地図は worker を事前に温める。
- `queryLayers` は feature property を返さず、地域判定のゲートにすると zoom やタイル有無へ依存する。必要なら `featuresAtPoint`、コード体系が必要なら worker 判定を使う。
- 市区町村別最大震度のタップは zoom にかかわらず市区町村選択。低 zoom で県へ寄せるだけの操作にしない。ディープリンクは市区町村コードから詳細を開き、領域外は選択解除する。
- 観測点のない震度速報は `intensity.regions` の境界を使う。`jmaMapProvider` と layout サイズが揃ってから `MapCameraBoundsFitter` に論理ピクセルを渡す。
- 初期範囲は `MapOptions.initCenter` / `initZoom` に設定する。表示後の `fitBounds` による移動を避け、境界が得られない場合は固定位置で補わない。

## 通知地域と EEW フォーカス

### 共通の地域選択

- 地域選択は `feature/region_selection` の `RegionSelectionRoute` に集約する。`RegionSelectionRequest.kinds` で対象種別、`mode` で単一・複数選択、`initialSelection` で復元、`allowEmpty` で全解除の確定可否を指定する。結果は `List<RegionOption>`、キャンセルは `null`、全解除は空リスト。
- ホーム指定地域、観測地域フィルター、通知追加、ウィジェット設定、履歴の地域検索は共通の検索・一覧・地図・選択確認を使う。既存の単一地域を保存する呼び出し元は単一選択のまま利用する。震央フィルターは複数選択。
- 通知は `notification: true` と `eewRegion` / `city` を組み合わせ、同じ市でも親EEW区域が違う候補を区別する。一般の観測用細分区域を通知区域へ転用しない。
- Asset Pack v0.1 の `areaEpicenter` は数値属性 `id` を持つ。`areaEpicenter` コード表のコードを数値として照合し、地名と読みはコード表から取得する。未知IDは選ばず、地図領域がない地名は一覧に残す。旧packで当該layerがない場合も一覧で選択できる。
- 震央条件は `EarthquakeHistoryParameter.epicenterCodes` へ保存する。観測地域・震度などの条件とは独立し、地域変更や個別解除で相互の条件を消さない。
- 地図lookupは種別・親・選択・styleの変更とdisposeで無効化する。検索結果の遅延完了で解除済みの選択を戻さない。選択overlayは専用layerを使い、cleanupで除去する。

- 通知の `regionId` は `areaForecastLocalEew`、市区町村の表示名・ふりがなは `EarthquakeParameter` が正本。観測点を含む `jma_code_table.areaInformationCity` は親区域の結合に限定し、結合不能を近隣地域で補わない。
- 通知地域のタップ検索とカメラ操作は世代を持ち、完了時・キュー実行開始時の最新世代と mounted を確認する。dispose で世代と controller を無効化する。
- EEW 自動フォーカスを解除するのは `apiGesture`。`developerAnimation` / `apiAnimation` では解除しない。iOS の理由は bitmask として判定し、`TransitionCancelled` 単独を gesture とみなさない。
- 解除後は同じ EEW の更新で再開せず、新 event ID で再開する。EEW 中のホームボタンは `autoZoom` によらず EEW へ再フォーカスする。animation 開始前に状態を公開し、完了時は session 一致を確認する。
- 揺れ検知は南西端 inclusive の 0.25° 格子へ points を集約し、各セルの最大レベルだけを枠線で描く。空セル・中心/四隅 marker は描かない。レベル順で高い枠を上へ置き、Weaker は `#546E7A`。
- intensity の境界は `≤ -1`、`≤ 0.5`、`≤ 2.5`、`≤ 4.5`、それより上の順に Weaker/Weak/Medium/Strong/Stronger。`ShakeDetectionGridCellBuilder` と配信側の境界を揃える。

## PMTiles と native 障害の切り分け

- ローカル URI は `pmtiles://${Uri.file(absolutePath)}`。`pmtiles://asset://` は使わず、asset をローカルファイルに配置してから開く。旧 `assets_util` は削除済みのため依存を復活させない。
- 配布物には `countries`、`areaForecastLocalE`、`areaForecastLocalEew`、`areaInformationCityQuake` の source layer が必要。別用途の区域 archive や HTTPS へ黙って置換しない。
- 市区町村地物の表示下限は `BaseMapTileSpec.cityMinZoom`（現行 6）。低 zoom は細分区域を使い、保存済み設定も `effectiveRegionToCityZoom` で下限補正する。metadata の minzoom だけで地物の存在を判断しない。
- native pin の正本は `app/pubspec.yaml` の `YumNumm/flutter-maplibre` ref と lockfile。更新時は関連パッケージを揃え、SwiftPM の解決結果も確認する。
- gzip metadata エラーの abort 対処は upstream [#4399](https://github.com/maplibre/maplibre-native/pull/4399)（Android 13.4.0 / iOS 6.28.0 以降）。これは他の decode 障害すべてを防ぐ保証ではない。
- iOS Metal で複数 vector source の fill だけがタイル単位で欠ける場合、clip mask UBO の bind cache 再利用を疑う。[#4342](https://github.com/maplibre/maplibre-native/pull/4342) が原因・回帰テストの参照先。layer 再追加や opacity 変更を恒久対策にしない。
- clip mask 修正の配布履歴は `YumNumm/maplibre-native` の `ios-v6.29.0-yumnumm.2`。binaryTarget は release ZIP と checksum を直接参照し、巨大な source repository の clone を避ける。ZIP 更新は新 tag・URL で配布する。
- Metal の確認は同じ実 archive・camera・style で fill と line を比較する。`MLNMapSnapshotter` や取得・リンク成功だけでは画面の修正を確認できない。

## 変更時の確認

`app/` から関連する既存テストを実行する。初回取得、invalidate、再取得成功・失敗、dispose 中の完了を確認し、式・Metal・PMTiles 表示は iOS/Android でも確認する。

```sh
mise exec -- flutter test test/core/util/map --dart-define=CI=true
mise exec -- flutter test test/feature/intensity_history --dart-define=CI=true
```

関連: [PMTiles](pmtiles.md) / [新レンダラ](map_renderer.md)
