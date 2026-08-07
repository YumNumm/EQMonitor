# EQMonitor Logo 3D Pipeline

Blender 5.2 LTS を使って EQMonitor ロゴの 3D アセットを生成するパイプラインです。

## 前提

- macOS + Blender 5.2 LTS (`/Applications/Blender.app`)
- ソース SVG: `source/eqmonitor_logo.svg`

## 出力

| ファイル | 内容 |
|---|---|
| `out/eqmonitor_logo.glb` | 3D モデル + `logo_draw` アニメーション (48 frames @ 24 fps ≈ 2.0 s) |
| `out/eqmonitor_logo_icon_1024.png` | 1024×1024 正面レンダー (RGBA 透過) |

## 実行コマンド

```bash
BLENDER=/Applications/Blender.app/Contents/MacOS/Blender

# 1. GLB 生成（アニメーション付き）
$BLENDER --background --python tools/branding/eqmonitor_logo_3d/build_logo.py

# 2. アイコン PNG レンダー
$BLENDER --background --python tools/branding/eqmonitor_logo_3d/export_icon.py

# 3. アプリアセットへコピー
cp tools/branding/eqmonitor_logo_3d/out/eqmonitor_logo.glb app/assets/3d/
cp tools/branding/eqmonitor_logo_3d/out/eqmonitor_logo_icon_1024.png app/assets/3d/

# 4. フォールバック PNG (512×512)
sips -z 512 512 app/assets/3d/eqmonitor_logo_icon_1024.png \
  --out app/assets/3d/eqmonitor_logo_fallback.png
```

## ファイル構成

```
tools/branding/eqmonitor_logo_3d/
├── source/
│   └── eqmonitor_logo.svg   # ロゴ原版 SVG
├── out/                      # 生成物出力先
├── scene_builder.py          # 共通シーン構築（プレート + ロゴ）
├── build_logo.py             # GLB エクスポート + logo_draw アニメーション
├── export_icon.py            # 1024×1024 PNG レンダー
└── README.md
```

## 3D シーン構成

- **IconPlate**: 2.0×2.0×0.18 の角丸プレート（青系メタリック, bevel r=0.22）
- **LogoRing**: ロゴのリング部分（白 + emission glow）
- **LogoZigzag**: 地震波形の斜めストローク部分

## アニメーション `logo_draw`

| フレーム | 内容 |
|---|---|
| 1–24 | LogoRing が scale (0,0,0)→(1,1,1) で出現 |
| 12–36 | LogoZigzag が scale (0,0,0)→(1,1,1) で出現 |
| 48 | 完成形 |

glTF 非対応の Build Modifier は使用せず、TRS キーフレームのみで構成。
