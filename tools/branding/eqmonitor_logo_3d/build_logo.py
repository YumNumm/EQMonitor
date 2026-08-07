"""Build EQMonitor 3D logo and export as GLB with `logo_draw` animation.

The animation `logo_draw` (frames 1–48 @ 24 fps ≈ 2.0 s) uses TRS keyframes
to create a "drawn-in" appearance: the ring scales up first, then the zigzag
seismograph stroke follows.

Usage:
    BLENDER=/Applications/Blender.app/Contents/MacOS/Blender
    $BLENDER --background --python tools/branding/eqmonitor_logo_3d/build_logo.py
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import bpy
import scene_builder as sb

OUT_GLB = sb.ROOT / "out" / "eqmonitor_logo.glb"

FPS = 24
FRAME_START = 1
FRAME_END = 48


def build_animation(
    ring_obj: bpy.types.Object | None,
    zigzag_obj: bpy.types.Object | None,
):
    """Create 'logo_draw' NLA animation: ring appears, then zigzag draws in."""
    scene = bpy.context.scene
    scene.frame_start = FRAME_START
    scene.frame_end = FRAME_END
    scene.render.fps = FPS

    animated = []

    if ring_obj:
        ring_obj.scale = (0, 0, 0)
        ring_obj.keyframe_insert(data_path="scale", frame=1)
        ring_obj.scale = (1, 1, 1)
        ring_obj.keyframe_insert(data_path="scale", frame=24)
        _linearize_fcurves(ring_obj)
        animated.append(ring_obj)

    if zigzag_obj:
        zigzag_obj.scale = (0, 0, 0)
        zigzag_obj.keyframe_insert(data_path="scale", frame=1)
        zigzag_obj.scale = (0, 0, 0)
        zigzag_obj.keyframe_insert(data_path="scale", frame=12)
        zigzag_obj.scale = (1, 1, 1)
        zigzag_obj.keyframe_insert(data_path="scale", frame=36)
        _linearize_fcurves(zigzag_obj)
        animated.append(zigzag_obj)

    # Push all actions into NLA tracks named "logo_draw" so the glTF
    # exporter groups them into a single animation clip.
    for obj in animated:
        ad = obj.animation_data
        if ad is None or ad.action is None:
            continue
        action = ad.action
        track = ad.nla_tracks.new()
        track.name = "logo_draw"
        strip = track.strips.new(
            action.name,
            int(action.frame_range[0]),
            action,
        )
        strip.name = "logo_draw"
        ad.action = None

    scene.frame_set(FRAME_END)


def _linearize_fcurves(obj: bpy.types.Object):
    """Set all keyframe interpolation to LINEAR for glTF compatibility."""
    ad = obj.animation_data
    if ad is None or ad.action is None:
        return
    action = ad.action

    # Blender 5.x layered actions: fcurves are inside channelbags
    if hasattr(action, "layers"):
        for layer in action.layers:
            for strip in layer.strips:
                for cb in strip.channelbags:
                    for fc in cb.fcurves:
                        for kp in fc.keyframe_points:
                            kp.interpolation = "LINEAR"
    # Blender 4.x legacy: fcurves directly on action
    elif hasattr(action, "fcurves"):
        for fc in action.fcurves:
            for kp in fc.keyframe_points:
                kp.interpolation = "LINEAR"


def export_glb():
    OUT_GLB.parent.mkdir(parents=True, exist_ok=True)
    filepath = str(OUT_GLB)

    # Blender 5.x uses export_animation_mode; fall back to legacy param
    try:
        bpy.ops.export_scene.gltf(
            filepath=filepath,
            export_format="GLB",
            export_animations=True,
            export_animation_mode="NLA_TRACKS",
            export_apply=True,
        )
    except TypeError:
        bpy.ops.export_scene.gltf(
            filepath=filepath,
            export_format="GLB",
            export_animations=True,
            export_nla_strips=True,
            export_apply=True,
        )

    size = OUT_GLB.stat().st_size
    print(f"[build_logo] Exported GLB: {OUT_GLB} ({size:,} bytes)")
    if size == 0:
        print("[build_logo] ERROR: GLB file is empty")
        sys.exit(1)


def main():
    plate, ring_obj, zigzag_obj = sb.build_scene()
    build_animation(ring_obj, zigzag_obj)
    export_glb()
    print("[build_logo] Done")


if __name__ == "__main__":
    main()
