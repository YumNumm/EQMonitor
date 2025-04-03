# TopoJSON実装計画

## 背景と目的

現在、EQMonitorアプリケーションでは地図データをGeoJSON形式で扱っていますが、より効率的なTopoJSON形式を利用して地図を描画する必要があります。この文書では、`utils/map_converter/data/topojson/*.topojson`ファイルを利用し、外部ライブラリを使用せずにFlutterの`CustomPainter`で地図をレンダリングするための実装計画を説明します。

## TopoJSONの構造

TopoJSONは、GeoJSONを拡張したフォーマットで、地理的なトポロジーを効率的に表現するために設計されています。基本的な構造は以下の通りです：

```json
{
  "type": "Topology",
  "objects": {
    "AreaForecastLocalE": {
      "type": "GeometryCollection",
      "geometries": [
        {
          "arcs": [
            [
              0
            ]
          ],
          "type": "Polygon",
          "properties": {
            "code": "100",
            "name": "石狩地方",
            "kana": "いしかりちほう"
          }
        },
        ...
      ]
    }
  },
  "arcs": [
    [
      [140.2978515625, 43.19716534542964],
      [0.001220703125, -0.0006866455078125],
      ...
    ],
    ...
  ]
}
```

主な構成要素：
- `type`: "Topology"という値
- `objects`: 名前付きの地理的オブジェクトのコレクション
- `arcs`: 座標の配列の配列（ポリゴンの形状を定義）
- `transform`: 座標の量子化に関する情報（オプション）

## Protocol Buffer定義

TopoJSONデータを効率的に格納するために、`packages/jma_map`のProtocol Buffer定義を以下のように拡張します：

```protobuf
message JmaMap {
  repeated JmaMapData data = 1;
  repeated TopoJSONMapData topoJsonData = 2;

  message TopoJSONMapData {
    JmaMapType mapType = 1;
    string name = 2; // "AreaForecastLocalE" など
    repeated TopoJSONGeometry geometries = 3;
    repeated TopoJSONArc arcs = 4;
    LatLngBounds bounds = 5; // 全体の境界ボックス
  }

  message TopoJSONGeometry {
    string type = 1; // "Polygon", "MultiPolygon" など
    repeated TopoJSONArcIndices arcIndices = 2; // ネストされた配列構造
    Property property = 3; // 既存のPropertyを再利用
    LatLngBounds bounds = 4; // ジオメトリごとの境界ボックス
  }

  message TopoJSONArcIndices {
    repeated int32 indices = 1; // 単一のarcを参照するインデックスの配列
  }

  message TopoJSONArc {
    repeated LatLng positions = 1; // 既存のLatLngを再利用
    LatLngBounds bounds = 2; // アークごとの境界ボックス
  }
}
```

この定義では：
1. TopoJSONデータを格納するための新しいメッセージタイプ`TopoJSONMapData`を追加
2. TopoJSONの構造を反映した各種メッセージタイプを定義
3. ネストされた配列構造を表現するために`TopoJSONArcIndices`を別のメッセージ型として定義
4. 既存の`LatLng`や`Property`を再利用して、コードの重複を避ける
5. 各レベル（全体、ジオメトリ、アーク）で境界ボックス（`LatLngBounds`）を追加

## データ変換プロセス

TopoJSONファイルからProtocol Bufferへの変換プロセスは以下の通りです：

1. TopoJSONファイルを読み込む
2. 必要な情報（name, geometries, arcs）を抽出する
3. 各レベル（全体、ジオメトリ、アーク）で境界ボックスを計算する
4. Protocol Bufferの構造に変換する
5. バイナリ形式で保存する

## CustomPainterでのレンダリング

Protocol Bufferから読み込んだTopoJSONデータを使用して、以下の手順で地図をレンダリングします：

1. TopoJSONデータを読み込む
2. 現在の表示領域（ビューポート）を計算する
3. 表示領域と各ジオメトリの境界ボックスを比較し、画面外の要素をスキップする
4. 表示対象の各ジオメトリに対して：
   a. arcIndicesを解析して、参照するarcsを特定
   b. arcsから座標を取得
   c. 座標を画面座標に変換
   d. Pathオブジェクトを作成
   e. Canvasに描画

## ズームレベルごとのマップ最適化（Shrink）手法

TopoJSONを含むProtocol Bufferを読み込んだ後、別のFutureProviderでズームレベルごとのマップ最適化を行います。以下は主な最適化手法です：

1. **ダグラス・ポイカー法（Douglas-Peucker Algorithm）** - ポリゴンの簡略化
2. **ビジュアル・インポータンス・プルーニング（Visual Importance Pruning）** - 視覚的重要度に基づく簡略化
3. **グリッド・ベース・シンプリフィケーション（Grid-based Simplification）** - グリッドに基づく簡略化
4. **トポロジー保存シンプリフィケーション（Topology-Preserving Simplification）** - トポロジーを保持した簡略化
5. **LOD（Level of Detail）階層化** - 詳細度レベルの階層化

## 境界ボックス（Boundary Box）の活用

パフォーマンス最適化のために、境界ボックスを以下のように活用します：

1. **事前計算**：
   - Protocol Bufferの生成時に、各レベル（全体、ジオメトリ、アーク）で境界ボックスを計算
   - 計算された境界ボックスをProtocol Bufferに格納

2. **描画時の最適化**：
   - 現在の表示領域（ビューポート）を計算
   - 表示領域と各ジオメトリの境界ボックスを比較
   - 表示領域と交差しない（画面外の）ジオメトリは描画をスキップ
   - これにより、不要な描画処理を減らし、パフォーマンスを向上

3. **階層的なフィルタリング**：
   - まず全体の境界ボックスで大まかなフィルタリング
   - 次にジオメトリレベルでフィルタリング
   - 最後にアークレベルでフィルタリング
   - 階層的なアプローチにより、効率的に画面外の要素を除外

## 実装上の注意点

1. **外部ライブラリの不使用**：
   - 外部ライブラリを使用せずに、TopoJSONの解析とレンダリングを実装する

2. **パフォーマンスの最適化**：
   - 大きなTopoJSONファイルの場合、必要な部分だけを効率的に読み込む工夫が必要
   - 境界ボックスを活用して、画面外の要素を描画しないようにする
   - レンダリング時のパフォーマンスを考慮した実装を行う

3. **将来の拡張性**：
   - 新しい地図データや機能を追加しやすい設計にする
