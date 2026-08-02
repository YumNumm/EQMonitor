# Flutter Scene 震源3D表示 設計

## 目的

気象庁の震源データを格納したPMTilesを読み込み、Flutter Scene上で日本列島と震源の深さを3次元表示する。
年間約200万件を集約・間引きせず個別表示し、iPhone 13相当以上で操作中30fpsを満たすことを目標とする。

## 確定要件

- MapLibreには依存しない独立した3D画面とする。
- 深さ0kmに半透明の日本地図を配置する。
- 水平距離と深さはkm単位で統一し、深さ倍率はDart定数の`1.0`とする。
- 年間約200万件を同時に個別表示する。密度集約や件数間引きは行わない。
- 遠景は点、近景はShader生成の球インポスターとして表示する。
- 点と球の切り替えは画面上の直径で判定し、境界では連続的に遷移する。
- 色、半径、遷移閾値、地図透明度をDart側の引数として渡す。
- 1本指で回転、ピンチでズーム、2本指ドラッグで平行移動できる。
- PMTilesの取得と解析は独立した`seismicity_pmtiles`パッケージに置く。
- PMTilesはNetwork、File、Flutter Assetの3種類から読み込める。
- Network取得にはDioのHTTP Range Requestを使い、アーカイブ全体をファイルとしてダウンロードしない。
- 公開データ型、状態、結果、例外はFreezedで生成する。
- Flutter masterを基底PRで導入し、その上にStacked PRを積む。

## 対象外

- MapLibreとのカメラ・深度・レイヤー同期
- 震源のクラスタリング、ヒートマップ、密度による間引き
- 初期リリースでの震源タップ選択と詳細表示
- 初期リリースでのカメラ慣性
- DuckDB、Parquet、SQLiteによる端末内分析
- 既存の2D地震活動ページの置き換え

## 採用方式

### 描画

Flutter Scene標準の`InstancedMesh`は、各インスタンスを`Matrix4`として保持し、描画時に16個のfloatへ再パックする。
200万件では変換行列だけで約128MBとなり、毎フレームのCPU処理と転送も大きいため使わない。

標準の`BillboardGeometry`もインスタンスデータをフレーム一時領域へ転送するため、そのままでは使わない。
Flutter Sceneのforkへ、静的インスタンスデータを永続GPUバッファへ一度だけアップロードする汎用Geometryを追加する。
EQMonitorはforkの内部APIを直接importせず、公開APIだけを使う。

各震源は共有四角形をインスタンス描画する。Fragment Shaderが円形外を破棄し、近景では球面法線、陰影、補正深度を生成する。
これにより実ポリゴン球より大幅に三角形数を減らしながら、震源ごとの奥行き関係を維持する。

### 点・球LOD

任意視点の3D空間では地図のZoomLevelを定義せず、投影後の震源直径をピクセル単位で使う。

- `pointMinDiameterPx`: 遠景でも消失させない最小点径
- `sphereTransitionStartPx`: 点から球へ移り始める直径
- `sphereTransitionEndPx`: 完全な球表示になる直径

判定と補間はShader内で行う。カメラ操作時にDart側で200万件を走査したりGPUバッファを再構築したりしない。

## `seismicity_pmtiles`パッケージ

### 責務

`packages/seismicity_pmtiles/`は次を担当する。

- Network、File、Assetを共通のrandom-access readerへ変換
- Dioによるmanifest取得とPMTilesのHTTP Range取得
- `206 Partial Content`、`Content-Range`、取得長、ETagの検証
- Fileのrandom accessとAsset bytesの読み込み
- PMTiles v3のheader、root directory、leaf directory、tile dataの読み込み
- スキーマバージョン、アーカイブ識別子、件数の検証
- bounded memory LRUによる取得済みrangeのキャッシュ
- 固定データズームのMVT Point解析
- Isolate上でのチャンク変換
- `TransferableTypedData`による解析結果の転送
- Freezedによる状態、結果、例外の公開

Flutter、Flutter Scene、Riverpod、EQMonitor UIには依存しない。AssetはFlutterの`AssetBundle`を直接参照せず、呼び出し側からasset keyをbytesへ解決するloaderを注入する。

### 構成

```text
packages/seismicity_pmtiles/
├── lib/src/data_source/
├── lib/src/decoder/
├── lib/src/model/
├── lib/src/reader/
└── lib/src/repository/
```

主要な型は次とする。

- `SeismicityPmTilesManifest`
- `SeismicityPmTilesSource`
- `SeismicityPmTilesLayer`
- `SeismicityPmTilesChunk`
- `SeismicityPmTilesDataset`
- `SeismicityPmTilesLoadState`
- `SeismicityPmTilesResult`
- `SeismicityPmTilesException`

200万件を個別のFreezedモデルには変換しない。`SeismicityPmTilesChunk`は緯度、経度、深さ、マグニチュード、発生時刻、震度フラグを列形式のバッファとして保持する。
巨大バッファを持つFreezed型は`@Freezed(equal: false)`とし、意図しない全要素比較を防ぐ。

### Sourceとrandom access

`SeismicityPmTilesSource`は次のFreezed unionとする。

- `network`: manifest URIを持つ。manifestからversioned archive URIを解決し、DioでRange取得する。
- `file`: manifest pathとPMTiles pathを持つ。`RandomAccessFile`で必要範囲だけ読む。
- `asset`: manifest asset keyとPMTiles asset keyを持つ。注入された`SeismicityPmTilesAssetLoader`でbytesを取得する。

`SeismicityPmTilesAssetLoader`は`Future<Uint8List> Function({required String assetKey})`とする。EQMonitor側のadapterが`AssetBundle.load`の結果を`Uint8List`へ変換する。loaderはrepositoryへ依存注入し、JSON変換対象の`SeismicityPmTilesSource`には保持しない。

3経路は最終的に`pmtiles.ReadAt.readAt(int offset, int length)`へ統一し、`pmtiles`パッケージ2.2系の`PmTilesArchive.fromReadAt(..., strict: true)`へ渡す。PMTiles解析ロジックを経路ごとに複製しない。

FlutterのAsset APIはファイル内random accessを提供しないため、Asset経路だけはPMTiles asset全体を一度メモリへ読み込む。Network経路でこのフォールバックを使うことは禁止する。

Network readerは次を保証する。

- `Range: bytes=<offset>-<inclusiveEnd>`と`ResponseType.bytes`を使用する。
- 初回range応答のstrong ETagをアーカイブ識別子として固定し、後続rangeへ`If-Match`を付ける。
- `206 Partial Content`以外を拒否し、`200 OK`を全体ファイルとして受理しない。
- `Content-Range`の開始、終了、全体長と実データ長をmanifestおよび要求範囲と照合する。
- `412 Precondition Failed`またはETag変更時は、異なる世代のrangeを混在させず読み込み全体を失敗させる。
- 同じアーカイブ識別子、offset、lengthのrangeはbounded memory LRUから再利用する。
- Dioの`CancelToken`で未完了requestを停止する。

### PMTiles生成契約

manifestは少なくともversioned archive URI、ファイルサイズ、生成日時、スキーマバージョン、データズーム、地理範囲、フィーチャー件数を含む。FileとAsset用manifestも同じ論理フィールドを持ち、archive URIだけをローカルsource識別子へ置き換える。

PMTiles生成処理は次を保証する。

- manifestの`dataZoom`で全震源を保持する。
- 密度やタイルサイズを理由に点を削除しない。
- 同じ`event_id`を同一データズーム内で重複させない。
- 元データ件数、ユニークID件数、PMTiles内件数が一致する。
- 必須プロパティの型と欠損をリリース前に検証する。
- Network配信先はbyte Rangeをサポートし、正しい`206`、`Content-Range`、strong ETagを返す。
- 公開後のarchive URIは内容を上書きせず、更新時は新しいversioned URIを発行する。

クライアントはアーカイブ識別子、サイズ、range、件数が一致しないデータを表示しない。全体を取得しないNetwork経路ではアーカイブ全体のSHA-256をクライアント検証要件にしない。FileとAssetではmanifestにSHA-256がある場合だけ全体検証を行う。

## データフロー

```text
sourceとmanifestを解決
  → Network: 先頭16KiBをDio Range取得しETagを固定
  → File: RandomAccessFileをopen
  → Asset: 注入loaderでbytesを取得
  → header/root/leafから対象dataZoomのtile rangeを解決
  → 必要なtile dataだけをrange単位で取得
  → Worker IsolateでMVTをタイル単位に解析
  → 列形式チャンクをTransferableTypedDataで転送
  → 正距方位図法でkm座標へ変換
  → 24バイト固定長のGPUレコードを構築
  → 静的GPUバッファへ一度だけアップロード
```

GPUレコードは東西・深さ・南北位置、マグニチュード、発生時刻、震度等のフラグを持ち、1件あたり24バイトを目安とする。
200万件で約48MBとなる。Dartヒープに200万個のイベントオブジェクトは保持しない。

全震源を個別表示するため、Network経路でも最終的には対象dataZoomに存在する全tile payloadを取得する。Range方式の目的は、PMTiles全体ファイルの保存を避け、directoryや不要領域の転送を抑え、段階的解析、キャンセル、range単位の再利用を可能にすることである。

## 座標と地図

日本中心の正距方位図法を使い、水平座標をkmへ変換する。

```text
X = 東方向 km
Y = -深さ km
Z = 北方向 km
depthScale = 1.0
```

日本地図は同じ投影法で生成した半透明のGLBメッシュとする。地表はY=0、両面描画とし、地下から見上げた場合も輪郭を確認できる。
地図は半透明パスで深度書き込みを行わず、地下の震源を隠さない。震源は円形外を破棄する不透明パスで描画し、震源同士の深度判定を行う。

## アプリ側コンポーネント

- `HypocenterCoordinateProjector`: 緯度経度と深さをシーン座標へ変換
- `HypocenterGpuBufferBuilder`: パッケージのチャンクからGPUレコードを構築
- `Seismicity3dDatasetNotifier`: 読み込み、キャンセル、進捗、再試行を管理
- `HypocenterSceneStyle`: 色、半径、LOD閾値、地図透明度を保持
- `HypocenterSceneController`: SceneとGPUリソースの生成・破棄
- `OrbitCameraController`: タッチ入力からカメラ姿勢を計算
- `HypocenterSceneView`: Flutter Sceneを表示
- `Seismicity3dPage`: 期間、色モード、読み込み状態を統合

既存の2D地震活動ページは維持し、3D表示は別ページとして追加する。既存の期間・色モード選択UIは再利用する。

## 視点操作

- 1本指ドラッグ: トラックボール方式で360度回転
- ピンチ: カメラ距離を指数的に変更
- 2本指ドラッグ: 視線に直交する平面上で平行移動
- ダブルタップまたはリセットボタン: 日本全体が収まる初期視点へ戻す

カメラの近遠クリップ面はデータ境界から決定する。カメラ操作だけでは震源バッファを変更しない。

## 状態と障害対応

`SeismicityPmTilesLoadState`は`idle`、`fetchingManifest`、`openingSource`、`fetchingRanges`、`decoding`、`completed`、`failed`、`cancelled`をFreezed unionで表す。

- 期間変更時はDioの`CancelToken`と解析Isolateを停止する。
- Network range cacheはアーカイブURIとETagが一致する場合だけ再利用する。
- FileとAssetはmanifestのsource識別子、サイズ、任意SHA-256が一致する場合だけ受理する。
- 生の例外文字列をUIへ表示しない。
- 不明値を固定値やランダム値で補完しない。
- manifest件数と解析件数が一致しなければ描画しない。

## テスト

### 独立パッケージ

- manifestのFreezed JSON変換
- Source Freezed unionのNetwork、File、Asset分岐
- Dio Range header、キャンセル、進捗通知
- `206`と`Content-Range`の厳密検証、および`200`応答の拒否
- ETag固定、`If-Match`送信、`412`と世代変更の拒否
- bounded range LRUのhit、eviction、アーカイブ識別子分離
- File random accessと範囲外readの拒否
- Asset loaderからの読み込みとNetwork経路への全体loadフォールバック禁止
- MVT Pointとプロパティの解析
- 不正型、欠損、未知スキーマの拒否
- manifest件数と解析件数の一致
- `TransferableTypedData`のIsolate転送
- 200万件相当で個別Freezedオブジェクトを生成しないこと

### Flutter Sceneとアプリ

- 点表示と球インポスター表示
- 点と球の遷移境界のスモークレンダー
- 色、半径、深さ、補正深度のShader入力
- 半透明地図越しの地下表示
- カメラ回転、移動、ズーム、リセット
- GPUバッファが初回またはデータ変更時だけ転送されること
- 読み込み状態、キャンセル、エラー変換のunit test

今回の機能追加では新しいWidget testを必須にしない。3D画面の描画確認は実機smoke testと性能ゲートで行う。

## 性能ゲート

200万件の合成データを使い、iPhone 13相当の実機でProfileまたはReleaseビルドを計測する。

- 操作中30fps以上を継続する。
- カメラ操作中にDart側の全件走査を行わない。
- フレームごとの巨大バッファ確保やGPU転送を行わない。
- 5分間の連続操作でクラッシュ、Jetsam、継続的なメモリ増加がない。

性能ゲートを満たさない場合、実データ画面の統合PRへ進まない。

## Stacked PR

1. Flutter master移行と必要なプラグイン更新
2. `seismicity_pmtiles`独立パッケージ
3. Flutter Scene導入、fork固定、空Sceneとカメラ操作
4. 静的GPUバッファ、点・球Shader、200万件実機ベンチマーク
5. PMTiles実データ、日本地図、`Seismicity3dPage`統合

各PRは直前のPRをbaseとし、順番にレビュー・マージする。Flutter Scene fork側の変更は汎用APIとして別PRにし、EQMonitor側では固定コミットを参照する。

## 参照

- [Flutter Scene](https://pub.dev/packages/flutter_scene)
- [Flutter Scene InstancedMesh](https://github.com/bdero/flutter_scene/blob/master/packages/flutter_scene/lib/src/instanced_mesh.dart)
- [PMTiles v3 specification](https://github.com/protomaps/PMTiles/blob/main/spec/v3/spec.md)
- [pmtiles Dart package](https://pub.dev/packages/pmtiles)
- [vector_tile Dart package](https://pub.dev/packages/vector_tile)
