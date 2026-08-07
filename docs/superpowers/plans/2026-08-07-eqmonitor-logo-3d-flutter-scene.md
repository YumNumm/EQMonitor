# EQMonitor Logo 3D Flutter Scene Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Blender で EQMonitor ロゴの macOS 風 3D モデル（ポリゴン描画 + glow アニメ付き GLB）を生成し、Flutter Scene で設定/About に表示し、静止レンダーを macOS AppIcon に差し替える。

**Architecture:** SVG 正本を `tools/branding/eqmonitor_logo_3d` の bpy ヘッドレススクリプトで GLB / PNG 化する。アプリは `feature/branding` に Scene adapter を閉じ、失敗時は 2D フォールバックする。地図用 `eqmonitor_map` には依存しない。Flutter Scene revision は `eqmonitor_map` と同じ `7f71993b7e2a0ab1d2f59726a406098709be7291` に固定する。

**Tech Stack:** Blender 5.2 LTS (`bpy`)、glTF/GLB、Flutter master / Impeller / Flutter GPU、`flutter_scene`、HookWidget、go_router、`sips`（macOS アイコンリサイズ）

**Worktree:** `.worktrees/eqmonitor-logo-3d` on branch `feat/eqmonitor-logo-3d`  
**Spec:** `docs/superpowers/specs/2026-08-07-eqmonitor-logo-3d-flutter-scene-design.md`

## Global Constraints

- Blender 連携は GUI MCP ではなく `/Applications/Blender.app/Contents/MacOS/Blender --background --python ...`
- ロゴ入力: `app/ios/AppIcon-prod.icon/Assets/レイヤー-3 3.svg`
- 出力 GLB: `app/assets/3d/eqmonitor_logo.glb`
- アニメクリップ名: `logo_draw`（約 2.0 秒、非ループ）
- Flutter Scene 型を branding adapter 外へ漏らさない
- Splash 必須ゲート化はしない（フェーズ1対象外）
- iOS / Android アイコンは対象外
- Flutter / Dart コマンドは `mise exec --` 経由
- pubspec の依存は直接編集せず `mise exec -- flutter pub add` 等で追加
- `!` 禁止、`print` 禁止、StatefulWidget 禁止、プライベートメソッド原則禁止

## File Structure

```text
tools/branding/eqmonitor_logo_3d/
  build_logo.py          # SVG → プレート+ロゴ+アニメ → GLB
  export_icon.py         # 同一シーン静止レンダー → PNG
  README.md              # 実行手順
  source/
    eqmonitor_logo.svg   # prod SVG のコピー（パス空白回避）

app/assets/3d/
  eqmonitor_logo.glb
  eqmonitor_logo_fallback.png   # 2D フォールバック（既存アイコンから生成可）

app/lib/feature/branding/
  data/
    logo_scene_asset.dart              # asset key 定数
  ui/
    components/
      eqmonitor_logo_scene_view.dart   # Scene + fallback Widget
      eqmonitor_logo_2d_fallback.dart
    page/
      logo_scene_debug_page.dart       # デバッグ検証入口

app/macos/Runner/Assets.xcassets/AppIcon.appiconset/
  app_icon_*.png                       # レンダーから差し替え

tools/branding/eqmonitor_logo_3d/out/  # 生成中間物（git 管理しない / README で説明）
```

---

### Task 1: Blender パイプラインで GLB を生成する

**Files:**
- Create: `tools/branding/eqmonitor_logo_3d/build_logo.py`
- Create: `tools/branding/eqmonitor_logo_3d/export_icon.py`
- Create: `tools/branding/eqmonitor_logo_3d/README.md`
- Create: `tools/branding/eqmonitor_logo_3d/source/eqmonitor_logo.svg`
- Create: `app/assets/3d/eqmonitor_logo.glb`
- Create: `app/assets/3d/eqmonitor_logo_icon_1024.png`（アイコン原版、Task 4 で消費）
- Create: `app/assets/3d/eqmonitor_logo_fallback.png`

**Interfaces:**
- Consumes: `source/eqmonitor_logo.svg`
- Produces:
  - GLB with animation name `logo_draw`
  - PNG `eqmonitor_logo_icon_1024.png` (1024×1024, RGBA)
  - PNG `eqmonitor_logo_fallback.png` (512×512 以上)

- [ ] **Step 1: 作業ディレクトリと SVG コピーを用意する**

```bash
mkdir -p tools/branding/eqmonitor_logo_3d/source \
  tools/branding/eqmonitor_logo_3d/out \
  app/assets/3d
cp "app/ios/AppIcon-prod.icon/Assets/レイヤー-3 3.svg" \
  tools/branding/eqmonitor_logo_3d/source/eqmonitor_logo.svg
```

- [ ] **Step 2: `build_logo.py` を実装する**

要件（スクリプト内コメントと README にも書く）:

1. 既存オブジェクトを全削除
2. 角丸厚みプレートを作成（例: サイズ 2.0×2.0、厚み 0.18、bevel 0.22）
3. SVG を import（`bpy.ops.import_curve.svg`）。stroke は curve のままでは薄いので、curve を mesh 化し extrude / solidify
4. ロゴをプレート前面中央に配置・スケール調整
5. プレートは青系メタリック、ロゴは白 + emission（glow）
6. アニメ `logo_draw`（frame 1→48 @ 24fps ≈ 2.0s）:
   - ロゴをリング部分と斜めストローク部分に分割できる場合は別オブジェクトに
   - 各パーツの `scale` または `pass_index` / マテリアル emission strength をキーフレームし、「描かれていく」印象を出す
   - glTF が Build Modifier をサポートしないため、Build Modifier は使わない。TRS / emission キーに限定する
7. `bpy.ops.export_scene.gltf` で `out/eqmonitor_logo.glb` を出力（`export_animations=True`, `export_apply=True`）

スケルトン（実装時に完成させる）:

```python
import bpy
from pathlib import Path

ROOT = Path(__file__).resolve().parent
SVG = ROOT / "source" / "eqmonitor_logo.svg"
OUT = ROOT / "out" / "eqmonitor_logo.glb"

def clear_scene() -> None:
    bpy.ops.object.select_all(action="SELECT")
    bpy.ops.object.delete(use_global=False)

def create_plate() -> bpy.types.Object:
    bpy.ops.mesh.primitive_cube_add(size=1)
    plate = bpy.context.active_object
    plate.name = "IconPlate"
    plate.scale = (1.0, 1.0, 0.09)
    bpy.ops.object.transform_apply(scale=True)
    # bevel + マテリアルは実装時に追加
    return plate

def import_logo() -> list[bpy.types.Object]:
    bpy.ops.import_curve.svg(filepath=str(SVG))
    # curve → mesh、押し出し、配置は実装時に追加
    return [obj for obj in bpy.context.selected_objects]

def build_draw_animation(logo_objects: list[bpy.types.Object]) -> None:
    scene = bpy.context.scene
    scene.frame_start = 1
    scene.frame_end = 48
    # 各オブジェクトの scale / emission をキーフレーム
    # アクション名を logo_draw にリネーム

def export_glb() -> None:
    OUT.parent.mkdir(parents=True, exist_ok=True)
    bpy.ops.export_scene.gltf(
        filepath=str(OUT),
        export_format="GLB",
        export_animations=True,
        export_apply=True,
    )

def main() -> None:
    clear_scene()
    create_plate()
    logos = import_logo()
    build_draw_animation(logos)
    export_glb()

if __name__ == "__main__":
    main()
```

- [ ] **Step 3: `export_icon.py` を実装する**

`build_logo.py` と同じジオメトリ構築関数を import するか、共通 `scene_builder.py` に切り出す。最終フレーム（完成形）を正面カメラで 1024×1024 レンダーし `out/eqmonitor_logo_icon_1024.png` を書く。透過背景推奨（フィルム transparent）。

```python
# 要点
scene.render.resolution_x = 1024
scene.render.resolution_y = 1024
scene.render.film_transparent = True
scene.render.filepath = str(OUT_PNG)
bpy.ops.render.render(write_still=True)
```

- [ ] **Step 4: README に実行コマンドを書く**

```bash
BLENDER=/Applications/Blender.app/Contents/MacOS/Blender
$BLENDER --background --python tools/branding/eqmonitor_logo_3d/build_logo.py
$BLENDER --background --python tools/branding/eqmonitor_logo_3d/export_icon.py
cp tools/branding/eqmonitor_logo_3d/out/eqmonitor_logo.glb app/assets/3d/
cp tools/branding/eqmonitor_logo_3d/out/eqmonitor_logo_icon_1024.png app/assets/3d/
# fallback は 1024 を 512 に縮小でも可
sips -z 512 512 app/assets/3d/eqmonitor_logo_icon_1024.png \
  --out app/assets/3d/eqmonitor_logo_fallback.png
```

- [ ] **Step 5: ヘッドレス実行して成果物を確認する**

```bash
/Applications/Blender.app/Contents/MacOS/Blender --background \
  --python tools/branding/eqmonitor_logo_3d/build_logo.py
/Applications/Blender.app/Contents/MacOS/Blender --background \
  --python tools/branding/eqmonitor_logo_3d/export_icon.py
ls -lh tools/branding/eqmonitor_logo_3d/out/
cp tools/branding/eqmonitor_logo_3d/out/eqmonitor_logo.glb app/assets/3d/
cp tools/branding/eqmonitor_logo_3d/out/eqmonitor_logo_icon_1024.png app/assets/3d/
sips -z 512 512 app/assets/3d/eqmonitor_logo_icon_1024.png \
  --out app/assets/3d/eqmonitor_logo_fallback.png
```

Expected: `eqmonitor_logo.glb` が非ゼロサイズ。必要なら `gltf-transform` や Blender で `logo_draw` クリップ存在を目視確認。

- [ ] **Step 6: Commit**

```bash
git add tools/branding/eqmonitor_logo_3d app/assets/3d
git commit -m "$(cat <<'EOF'
Feat: BlenderでEQMonitorロゴ3DのGLB生成パイプラインを追加

EOF
)"
```

---

### Task 2: アプリに Flutter Scene 依存と branding 表示基盤を追加する

**Files:**
- Modify: `app/pubspec.yaml`（`flutter pub add` 経由）
- Modify: root `pubspec.lock`（resolve 結果）
- Create: `app/lib/feature/branding/data/logo_scene_asset.dart`
- Create: `app/lib/feature/branding/ui/components/eqmonitor_logo_2d_fallback.dart`
- Create: `app/lib/feature/branding/ui/components/eqmonitor_logo_scene_view.dart`
- Create: `app/test/feature/branding/ui/components/eqmonitor_logo_2d_fallback_test.dart`
- Modify: `app/pubspec.yaml` assets（`assets/` 配下なら既存 `- assets/` で足りる。足りない場合のみ `assets/3d/` を追加）

**Interfaces:**
- Consumes: `app/assets/3d/eqmonitor_logo.glb`, `eqmonitor_logo_fallback.png`
- Produces:
  - `class LogoSceneAsset` with `static const glb = 'assets/3d/eqmonitor_logo.glb';` and `static const fallback = 'assets/3d/eqmonitor_logo_fallback.png';`
  - `class EqMonitorLogoSceneView extends HookWidget` with named params `{required LogoScenePlaybackMode playbackMode, double? height}`
  - `enum LogoScenePlaybackMode { once, loop }`
  - Fallback Widget は Scene 失敗時に必ず表示

- [ ] **Step 1: フォールバック Widget の failing test を書く**

```dart
import 'package:eqmonitor/feature/branding/ui/components/eqmonitor_logo_2d_fallback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EqMonitorLogo2dFallback shows image asset', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EqMonitorLogo2dFallback(),
        ),
      ),
    );
    expect(find.byType(Image), findsOneWidget);
  });
}
```

- [ ] **Step 2: テストを実行し失敗を確認する**

```bash
cd app
mise exec -- flutter test test/feature/branding/ui/components/eqmonitor_logo_2d_fallback_test.dart
```

Expected: FAIL（ライブラリ未作成）

- [ ] **Step 3: fallback と asset 定数を実装する**

```dart
// logo_scene_asset.dart
abstract final class LogoSceneAsset {
  static const glb = 'assets/3d/eqmonitor_logo.glb';
  static const fallback = 'assets/3d/eqmonitor_logo_fallback.png';
}

// eqmonitor_logo_2d_fallback.dart
class EqMonitorLogo2dFallback extends StatelessWidget {
  const EqMonitorLogo2dFallback({super.key, this.height = 160});
  final double height;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      LogoSceneAsset.fallback,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
```

- [ ] **Step 4: flutter_scene を app に固定 revision で追加する**

```bash
cd app
mise exec -- flutter pub add "flutter_scene:{git:{url: https://github.com/bdero/flutter_scene.git, ref: 7f71993b7e2a0ab1d2f59726a406098709be7291, path: packages/flutter_scene}}"
```

`eqmonitor_map` と同様に root / app で `scene` の `dependency_overrides` が必要なら、既存パターンに合わせて同じ ref の `packages/scene` を追加する。`pubspec.yaml` を手で矛盾させない。追加後:

```bash
rg -n -A 8 "^  (flutter_scene|scene):" pubspec.lock
```

Expected: 両方とも `7f71993b7e2a0ab1d2f59726a406098709be7291`

- [ ] **Step 5: `EqMonitorLogoSceneView` を実装する**

要点:

- `HookWidget`
- `useEffect` で `Scene.initializeStaticResources()` → `Node.fromGlbAsset(LogoSceneAsset.glb)` → scene.add
- アニメクリップ `logo_draw` を取得できれば `createAnimationClip` で再生。`once` は `looped = false`、`loop` は `looped = true`
- 取得失敗・初期化失敗時は state を error にして `EqMonitorLogo2dFallback` を返す（例外文字列は UI に出さない。talker / developer log のみ）
- `SceneView` + `PerspectiveCamera`（例: position `(0, 0, 3.2)`, target origin）
- Widget に関数/getter を定義しない。ロジックが必要なら `LogoSceneLoader` クラスを `data/` に切り出し Riverpod DI

最小表示骨格:

```dart
return SceneView(
  scene,
  camera: PerspectiveCamera(
    position: Vector3(0, 0.2, 3.2),
    target: Vector3.zero(),
  ),
);
```

- [ ] **Step 6: fallback テストを再実行して通す**

```bash
cd app
mise exec -- flutter test test/feature/branding/ui/components/eqmonitor_logo_2d_fallback_test.dart
```

Expected: PASS（asset 解決のため `TestWidgetsFlutterBinding` + asset bundle が必要なら `flutter_test_config` や `TestAssetBundle` を使う。Image.asset がテストで落ちる場合は `skipOffstage` ではなく `pumpWidget` 前に `TestDefaultBinaryMessenger` ではなく、単純に `find.byType(EqMonitorLogo2dFallback)` の存在アサートに緩和してよい）

- [ ] **Step 7: Commit**

```bash
git add app/pubspec.yaml pubspec.lock app/lib/feature/branding app/test/feature/branding
git commit -m "$(cat <<'EOF'
Feat: Flutter Sceneでロゴ3D表示基盤を追加

EOF
)"
```

---

### Task 3: About / Debug に埋め込み、macOS で手動確認する

**Files:**
- Modify: `app/lib/feature/settings/children/application_info/about_this_app.dart`
- Create: `app/lib/feature/branding/ui/page/logo_scene_debug_page.dart`
- Modify: `app/lib/core/router/router.dart`（debug route 追加）
- Modify: `app/lib/feature/settings/children/config/debug/debug_page.dart`（入口 ListTile）
- Test: `app/test/feature/settings/children/application_info/about_this_app_test.dart`（無ければ新規。Scene は pump せず fallback 経路か find する）

**Interfaces:**
- Consumes: `EqMonitorLogoSceneView(playbackMode: LogoScenePlaybackMode.loop)`
- Produces: About 先頭に高さ約 180 のロゴ表示。Debug に「EQMonitor Logo (Flutter Scene)」

- [ ] **Step 1: About にロゴを埋め込む**

`AboutThisAppScreen` の `Column` 先頭（ListTile 群の前）に:

```dart
const Padding(
  padding: EdgeInsets.symmetric(vertical: 16),
  child: SizedBox(
    height: 180,
    width: double.infinity,
    child: EqMonitorLogoSceneView(
      playbackMode: LogoScenePlaybackMode.loop,
    ),
  ),
),
```

既存の `SingleChildScrollView` はそのまま（今回のスコープ外の既存構造）。`HookWidget` のまま Scene View を子として置く。

- [ ] **Step 2: Debug ページと route を追加する**

`LogoSceneDebugPage`: 全画面 `EqMonitorLogoSceneView(playbackMode: once)`。  
`router.dart` に `TypedGoRoute`（既存 Debug 配下のパターンに合わせる）。  
`debug_page.dart` に ListTile を追加（`Eqmonitor Map` の近く）。

- [ ] **Step 3: analyze**

```bash
cd app
mise exec -- dart analyze lib/feature/branding lib/feature/settings/children/application_info/about_this_app.dart lib/feature/settings/children/config/debug/debug_page.dart
```

Expected: No issues

- [ ] **Step 4: macOS 手動 smoke（必須）**

```bash
cd app
mise exec -- flutter run -d macos --enable-flutter-gpu --enable-impeller
```

確認:

1. 設定 → このアプリについて でロゴ 3D が見える / 失敗時は 2D
2. デバッグ → Logo Scene でアニメ意図が分かる
3. Splash / Home 遷移が壊れていない

- [ ] **Step 5: Commit**

```bash
git add app/lib/feature/branding app/lib/feature/settings app/lib/core/router
git commit -m "$(cat <<'EOF'
Feat: AboutとDebugにロゴ3D Sceneを埋め込む

EOF
)"
```

---

### Task 4: macOS AppIcon を静止レンダーで差し替える

**Files:**
- Modify: `app/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_*.png`
- Modify: `app/macos/Assets.xcassets/AppIcon.appiconset/`（重複セットがあれば同様）
- Optional Create: `tools/branding/eqmonitor_logo_3d/resize_macos_icons.sh`

**Interfaces:**
- Consumes: `app/assets/3d/eqmonitor_logo_icon_1024.png`
- Produces: Contents.json が参照する全サイズ PNG

- [ ] **Step 1: リサイズスクリプトを用意する**

```bash
#!/usr/bin/env bash
set -euo pipefail
SRC="app/assets/3d/eqmonitor_logo_icon_1024.png"
DST="app/macos/Runner/Assets.xcassets/AppIcon.appiconset"
sips -z 16 16 "$SRC" --out "$DST/app_icon_16.png"
sips -z 32 32 "$SRC" --out "$DST/app_icon_32.png"
sips -z 64 64 "$SRC" --out "$DST/app_icon_64.png"
sips -z 128 128 "$SRC" --out "$DST/app_icon_128.png"
sips -z 256 256 "$SRC" --out "$DST/app_icon_256.png"
sips -z 512 512 "$SRC" --out "$DST/app_icon_512.png"
sips -z 1024 1024 "$SRC" --out "$DST/app_icon_1024.png"
```

`app/macos/Assets.xcassets/AppIcon.appiconset` が別にある場合は同様にコピー。

- [ ] **Step 2: 実行して差分を確認する**

```bash
bash tools/branding/eqmonitor_logo_3d/resize_macos_icons.sh
git --no-pager status -- app/macos
```

- [ ] **Step 3: macOS でアイコン見た目を確認する**

Clean build 後に Dock / アプリウィンドウのアイコンが新デザインであること。

```bash
cd app
mise exec -- flutter clean
mise exec -- flutter run -d macos --enable-flutter-gpu --enable-impeller
```

- [ ] **Step 4: Commit**

```bash
git add app/macos tools/branding/eqmonitor_logo_3d/resize_macos_icons.sh
git commit -m "$(cat <<'EOF'
Feat: macOS AppIconを3Dロゴ静止レンダーに差し替え

EOF
)"
```

```bash
git push -u origin HEAD
```

---

## Spec Coverage Check

| Spec 要件 | Task |
|-----------|------|
| Blender bpy で GLB + 静止レンダー | Task 1 |
| 角丸プレート + 立体ロゴ + draw/glow アニメ | Task 1 |
| Flutter Scene 表示（設定/About） | Task 2, 3 |
| 2D フォールバック | Task 2 |
| Debug 検証入口 | Task 3 |
| macOS AppIcon | Task 4 |
| Splash 非ゲート / iOS Android 対象外 | 全 Task で触らない |

## Out of Scope (do not implement in this plan)

- Splash 背景連動（フェーズ2）
- iOS / Android アイコン
- `eqmonitor_map` 統合
- CI での Blender 実行必須化
