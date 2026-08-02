# Flutter Sceneで大量の静的インスタンスを描画する際の注意

## Flutter SDK

Flutter Scene 0.20.0はpre-1.0で、実際には新しいFlutter masterとFlutter GPUを要求する。
pubspecのFlutter stable下限だけを見て導入可否を判断しない。

```sh
mise exec -- flutter --version
mise exec -- flutter run --enable-flutter-gpu --enable-impeller
```

Flutter master移行は機能導入と分離し、既存テスト、iOSビルド、プラグイン互換性を先に確認する。

## 標準InstancedMeshの特性

Flutter Sceneの`InstancedMesh`は各インスタンスを`List<Matrix4>`で保持する。
描画時にはインスタンスごとの行列を16個のfloatへパックし、フレーム一時GPU領域へ転送する。

数万件の一般的なインスタンスには適するが、200万件の静的点群では次が問題になる。

- Matrix4だけで約128MB必要
- Dartオブジェクト数が大きい
- フレームごとの行列計算と再パックが発生する
- 静的データでも大きな転送が繰り返される

大量の静的点群では、位置、色、半径等を固定長レコードへ詰め、永続GPUバッファへ一度だけアップロードするGeometryを使う。
カメラ操作や点・球LODはShader内で処理し、Dart側の全件走査を発生させない。

## 震源表示

実ポリゴン球を大量に描画せず、共有四角形を使う球インポスターを採用する。
遠景は点、近景は球面法線と陰影を持つ球表示とし、投影後のピクセル直径で連続遷移させる。

PMTiles全件を表示する場合は、Dioでアーカイブ全体を検証付きキャッシュへ取得してからローカル解析する。
PMTilesの固定データズームでは間引きと重複を禁止し、元データ件数との一致を生成時とクライアント側の両方で検証する。

## 参照

- https://pub.dev/packages/flutter_scene
- https://github.com/bdero/flutter_scene/blob/master/packages/flutter_scene/lib/src/instanced_mesh.dart
- https://github.com/bdero/flutter_scene/blob/master/packages/flutter_scene/lib/src/render/instance_packing.dart
