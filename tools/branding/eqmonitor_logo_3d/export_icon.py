"""Render 1024×1024 transparent PNG of the completed EQMonitor 3D logo.

Builds the same scene as build_logo.py (via scene_builder) and renders
from a front-facing orthographic camera. Output goes to
``out/eqmonitor_logo_icon_1024.png``.

Usage:
    BLENDER=/Applications/Blender.app/Contents/MacOS/Blender
    $BLENDER --background --python tools/branding/eqmonitor_logo_3d/export_icon.py
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import bpy
from mathutils import Euler
import math
import scene_builder as sb

OUT_PNG = sb.ROOT / "out" / "eqmonitor_logo_icon_1024.png"


def setup_camera() -> bpy.types.Object:
    bpy.ops.object.camera_add(
        location=(0, 0, 5),
        rotation=Euler((0, 0, 0), "XYZ"),
    )
    cam_obj = bpy.context.active_object
    cam_obj.name = "IconCamera"
    cam = cam_obj.data
    cam.type = "ORTHO"
    cam.ortho_scale = sb.PLATE_SIZE * 1.12
    bpy.context.scene.camera = cam_obj
    return cam_obj


def setup_lighting():
    bpy.ops.object.light_add(
        type="AREA",
        location=(1.5, -1.5, 4),
        rotation=Euler((math.radians(30), math.radians(15), 0), "XYZ"),
    )
    key = bpy.context.active_object
    key.name = "KeyLight"
    key.data.energy = 150
    key.data.size = 3.0

    bpy.ops.object.light_add(
        type="AREA",
        location=(-2, 2, 3),
        rotation=Euler((math.radians(45), math.radians(-20), 0), "XYZ"),
    )
    fill = bpy.context.active_object
    fill.name = "FillLight"
    fill.data.energy = 60
    fill.data.size = 4.0


def setup_render():
    scene = bpy.context.scene
    scene.render.resolution_x = 1024
    scene.render.resolution_y = 1024
    scene.render.resolution_percentage = 100
    scene.render.film_transparent = True
    scene.render.image_settings.file_format = "PNG"
    scene.render.image_settings.color_mode = "RGBA"
    scene.render.image_settings.compression = 15

    # Use EEVEE for fast headless rendering
    try:
        scene.render.engine = "BLENDER_EEVEE_NEXT"
    except Exception:
        scene.render.engine = "BLENDER_EEVEE"

    scene.eevee.taa_render_samples = 64


def render():
    OUT_PNG.parent.mkdir(parents=True, exist_ok=True)
    bpy.context.scene.render.filepath = str(OUT_PNG)
    bpy.ops.render.render(write_still=True)
    size = OUT_PNG.stat().st_size
    print(f"[export_icon] Rendered: {OUT_PNG} ({size:,} bytes)")
    if size == 0:
        print("[export_icon] ERROR: PNG is empty")
        sys.exit(1)


def main():
    sb.build_scene()
    setup_camera()
    setup_lighting()
    setup_render()
    render()
    print("[export_icon] Done")


if __name__ == "__main__":
    main()
