# MapLibre レイヤーライフサイクル修正設計

## 目的

`SeismicityEpicenterLayer` を起点に、アプリ内の MapLibre source/image/layer 操作を全件監査し、可変データ更新や非同期初期化・破棄の競合によってレイヤーが消失、重複、復旧不能になる不具合を修正する。

## 対象範囲

`app/lib` 配下で次の API を使用するすべての実装を監査対象とする。

- `StyleController.addSource` / `removeSource`
- `StyleController.addImage` / `addImages` / `addImageFromAssets`
- `StyleController.addLayer` / `removeLayer`
- `StyleController.updateGeoJsonSource` / `updateFilter`

監査では、ホーム、緊急地震速報、地震履歴、震度履歴、地震活動、揺れ検知、津波詳細の各地図を確認する。修正は監査基準に違反する実装だけに限定し、静的レイヤーや source URL の変更に完全再作成が必要な実装は維持する。

## 採用方針

各レイヤーを個別に修正し、既存の `MapOperationQueueScope` と `useMapOperationQueue` を利用する。全レイヤーを新しい汎用 lifecycle abstraction や宣言的 layer API へ移行する大規模変更は行わない。

テストでは共通の fake `StyleController` / `MapController` harness を用意し、Widget から発行される実際の MapLibre 操作列を検証する。これにより production code にテスト専用 API を追加せず、各レイヤーの登録・更新・破棄動作を同じ基準で検証する。

## ライフサイクル規約

### 初期化

- source、image、layer の初期登録 effect は原則として `styleController` と、登録可否を決める不変依存だけを持つ。
- 初期化時に可変データの最新版が必要な場合は `useRef` から読み取る。
- 初期化完了を `isInitialized` と初期化 Future で追跡する。
- 非同期初期化中に unmount された場合、後続の source/image/layer 登録を `disposed` で中止する。

### 更新

- GeoJSON の内容変更には `updateGeoJsonSource` を使用し、source を再登録しない。
- filter の変更には `updateFilter` を使用する。
- paint/layout の変更に MapLibre API がない場合は layer だけを削除・再追加し、source と image は維持する。
- 更新処理は初期化 Future の完了後に実行し、破棄開始後は実行しない。
- 同一 GeoJSON の重複更新は最新値キャッシュで抑止する。

### 破棄

- layer を逆順で削除してから source を削除する。
- 各 `removeLayer`、`removeSource`、必要な `removeImage` は個別に例外処理し、一件の失敗で後続 cleanup を止めない。
- cleanup は共有 `MapOperationQueue` に積み、同一マップ上の再初期化との順序を保証する。
- 完全には初期化されなかった状態でも cleanup が安全に完走することを保証する。

### 完全再作成を許可する条件

- `VectorSource.url` など、既存 API で更新できない source 定義自体が変更された場合。
- 表示対象の有無によって Widget 自体が mount/unmount される場合。
- その場合も非同期初期化の中断と個別 cleanup を必須とする。

## 監査上の分類

### 既に望ましい分離がある実装

P/S 波、揺れ検知、強震モニタ観測点など、初期化 effect と `updateGeoJsonSource` effect が分離されている実装は参照パターンとして使用する。ただし cleanup の個別例外処理と初期化 Future 待機は改めて確認する。

### 修正が必要と判定した実装

少なくとも次を同型不具合として修正対象に含める。

- `SeismicityEpicenterLayer`: events、色モード、10分 tick ごとに source/layer を完全再作成している。
- 地震履歴の震源・震源誤差・震度DB観測点: earthquake/tree や表示設定の変更で source/image/layer を再登録している。
- 津波詳細の予報区・震源・観測点: tsunami state や parameter provider の更新で source/image/layer を再登録している。

残りのレイヤーも同じ基準で監査し、違反が確認できたものは同じ PR に含める。

## データフロー

1. MapLibre の style load 後、レイヤー Widget が空または最新の GeoJSON source と静的 layer/image を一度登録する。
2. provider、引数、タイマーから可変データが更新される。
3. データ専用 effect が初期化完了を待ち、GeoJSON source、filter、または layer 定義の必要最小単位だけを更新する。
4. Widget の破棄時は更新を停止し、登録済みリソースを逆順・個別例外処理で削除する。

## エラー処理

- MapLibre 操作エラーは `talker.handle` または既存の `talker.log` 方針に従って記録する。
- cleanup は best effort だが、すべての対象リソースを必ず試行する。
- add/update の失敗を成功扱いにせず、`isInitialized` や最新 GeoJSON キャッシュを成功後だけ更新する。
- 更新失敗後の次回更新で再試行できる状態を保つ。

## テスト戦略

- `SeismicityEpicenterLayer` が初回に source/layer を一度だけ登録する。
- events または tick 更新時は `updateGeoJsonSource` のみを呼び、source/layer を再登録しない。
- 色モード変更時は source を維持し、必要最小限の layer 更新だけを行う。
- cleanup で一つの layer 削除が失敗しても、残りの layer/source 削除を試行する。
- 非同期初期化中に破棄しても、破棄後の layer 登録を行わない。
- 監査で修正した各レイヤーについて、可変データ変更時に source/image の再登録がないことを focused test で検証する。
- 対象テスト、`flutter analyze`、`git diff --check` を最終ゲートとする。

## ドキュメント

今回確立した MapLibre の初期化・更新・破棄規約とテスト方法を `docs/knowledge/20260720_maplibre_layer_lifecycle.md` に残す。

## 完了条件

- 全 MapLibre 操作箇所の監査結果が説明可能である。
- 監査基準に違反する全レイヤーが修正されている。
- lifecycle 回帰テストが修正前に失敗し、修正後に成功する。
- focused tests、analyze、diff check が成功する。
- 変更がコミット・push され、draft PR が作成されている。
