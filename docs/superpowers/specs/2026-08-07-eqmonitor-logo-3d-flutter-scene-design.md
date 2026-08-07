# EQMonitor ロゴ 3D（Flutter Scene）設計

## 目的

EQMonitor ロゴを macOS 風の厚みある角丸プレート上の 3D モデルとして作成し、ポリゴンが順に描かれ glow しながら完成するアニメーションを Flutter Scene で再生する。同一モデルの静止レンダーを macOS アプリアイコンに使う。

## 確定要件

- 用途: 起動周り（Splash 連動は段階導入）と設定 / About の装飾
- 見た目: macOS 風の厚みある角丸プレート + 立体 EQMonitor ロゴ
- 演出: ポリゴンが引かれていき、glow しながらロゴが完成する
- アニメーション正本: Blender で作成したアニメーション付き GLB を Flutter Scene で再生
- ロゴ元データ: `app/ios/AppIcon-prod.icon/Assets/レイヤー-3 3.svg`
- アイコン: macOS を優先。iOS / Android アイコン差し替えは後続
- Blender 連携: GUI のライブ MCP ではなく、ローカル Blender 5.x の `bpy` ヘッドレススクリプト
- Flutter Scene: 既存 `eqmonitor_map` と同じ revision 前提。地図パッケージには依存しない

## 対象外

- iOS / Android アプリアイコン差し替え
- `eqmonitor_map` へのロゴ表示統合
- Splash を 3D 再生完了までブロックする必須ゲート化（フェーズ1では行わない）
- 手編集 `.blend` をビルド正本にすること

## 採用方式

Blender スクリプトでアセットを生成し、Flutter Scene で再生する。

```text
AppIcon-prod.svg
       │
       ▼
Blender bpy script (ヘッドレス)
  ├─ 角丸プレート生成
  ├─ ロゴ SVG 押し出し
  ├─ ポリゴン描画アニメ + glow
  └─ 出力
       ├─ eqmonitor_logo.glb      ← Flutter Scene
       └─ eqmonitor_logo_icon.png ← macOS AppIcon 用静止レンダー
```

見た目の正本を Blender に置き、アプリ表示と macOS アイコンの両方へ流す。GLB アニメが Flutter Scene で期待どおり再生できない場合は、フェーズ2で静止メッシュ + アプリ側描画アニメへフォールバック可能にする。

## アーキテクチャ

### Blender パイプライン

置き場: `tools/branding/eqmonitor_logo_3d/`

| ファイル | 役割 |
|----------|------|
| `build_logo.py` | SVG import → プレート + ロゴ押し出し → マテリアル / glow → アニメ → GLB export |
| `export_icon.py` | 同一シーンを正面向き静止レンダー |
| `README.md` | Blender 5.2 パスと実行例 |

出力:

- `app/assets/3d/eqmonitor_logo.glb`
- macOS `AppIcon.appiconset` 用 PNG（1024 など）

手編集 `.blend` は補助用に残してよいが、再現生成の正本はスクリプト + SVG とする。

### Flutter Scene 表示

- feature: `app/lib/feature/branding/`（設定 / About / 検証入口から共有参照）
- `EqMonitorLogoSceneView`
  - `Scene.initializeStaticResources`
  - `Node.fromGlbAsset('assets/3d/eqmonitor_logo.glb')`
  - 起動連動（フェーズ2）: 固定カメラ、アニメ 1 回
  - 設定 / About: 同じアセット、軽いループ（既定）
- Flutter Scene 型は Widget / adapter 内に閉じ、`eqmonitor_map` へ依存しない
- 依存 revision は `eqmonitor_map` と揃える（現行 pin を正とする）

### macOS アプリアイコン

- 静止レンダー PNG を既存 `app/macos/.../AppIcon.appiconset` に差し替え
- iOS / Android はスコープ外

## 画面フロー

### 起動（Splash）

既存 `SplashPage` は重い初期化完了を待たず Home へ進む。3D 再生を必須ゲートにしない。

- **フェーズ1:** デバッグまたは設定から開ける検証表示 + 設定 / About 埋め込み
- **フェーズ2（任意）:** Splash 背景として短時間再生。初期化と並行し、アニメ完了または最大 2.0 秒で現行どおり遷移

コールドスタートの deep link / オンボーディング redirect は現状ロジックを維持する。

### 設定 / About

- 設定画面または About セクションに `EqMonitorLogoSceneView` を埋め込む
- タップ拡大は任意

## エラー処理

| 状況 | 挙動 |
|------|------|
| GLB 読み込み失敗 / Scene 未準備 | 既存 2D ロゴ（または App Icon 画像）を表示。例外文字列は出さない |
| アニメ非対応 | 静止ポーズで表示し、ログのみ |
| 低スペック / GPU 不可 | Scene をスキップし 2D フォールバック |
| アイコン生成失敗 | 既存 macOS アイコンを維持。パイプラインは非ゼロ終了 |

## テスト方針

- Blender: スクリプト実行で GLB / PNG が生成されること（ローカル必須、CI は任意）
- Flutter: Scene をモック可能な adapter 経由にし、フォールバック表示を Widget テスト
- 実機: macOS で Scene 再生とアイコン見た目を確認

## 受け入れ条件

1. Blender ヘッドレス実行で `eqmonitor_logo.glb` と macOS 用 1024 PNG が再現生成できる
2. Flutter Scene で GLB が再生され、ポリゴン描画 + glow の意図が分かる（失敗時は 2D フォールバック）
3. 設定 / About に埋め込み表示できる
4. macOS AppIcon が新レンダーに差し替わる（iOS / Android は対象外）
5. Splash の遷移・オンボーディング・deep link を壊さない

## 実装順序（概要）

1. Blender 生成パイプライン（SVG → GLB + 静止レンダー）
2. Flutter Scene 埋め込み（設定 / About + 検証入口）
3. macOS AppIcon 差し替え
4. （任意）Splash 背景連動

## リスク

- Flutter Scene は master + Impeller / Flutter GPU 前提（既存地図スパイクと同系統）
- glTF アニメーションの Scene 側サポート範囲が、意図した「線が引かれる」表現と一致しない可能性がある
- SVG の stroke ベース形状は Blender 取り込み時にメッシュ化の調整が必要
