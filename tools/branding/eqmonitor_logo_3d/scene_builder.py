"""Shared 3D scene builder for EQMonitor logo.

Builds a macOS-style thick rounded plate with the EQMonitor logo raised
on its front face. Both build_logo.py and export_icon.py import this
module to ensure identical geometry.

Run via Blender headless:
    /Applications/Blender.app/Contents/MacOS/Blender --background --python <script>.py
"""

import bpy
import sys
from pathlib import Path
from mathutils import Vector

ROOT = Path(__file__).resolve().parent
SVG_PATH = ROOT / "source" / "eqmonitor_logo.svg"

PLATE_SIZE = 2.0
PLATE_DEPTH = 0.18
BEVEL_RADIUS = 0.22
LOGO_EXTRUDE = 0.05
LOGO_FILL_RATIO = 0.78

PLATE_COLOR = (0.05, 0.16, 0.48, 1.0)
LOGO_COLOR = (1.0, 1.0, 1.0, 1.0)
LOGO_EMISSION_COLOR = (0.7, 0.85, 1.0, 1.0)
LOGO_EMISSION_STRENGTH = 3.0

SVG_ZIGZAG_STROKE_WIDTH_PX = 110.0
SVG_CANVAS_PX = 742.0


def clear_scene():
    bpy.ops.object.select_all(action="SELECT")
    bpy.ops.object.delete(use_global=False)
    for dt in (bpy.data.meshes, bpy.data.materials, bpy.data.curves,
               bpy.data.cameras, bpy.data.lights, bpy.data.actions):
        for block in list(dt):
            dt.remove(block)
    for coll in list(bpy.data.collections):
        bpy.data.collections.remove(coll)


def make_material(
    name: str,
    base_color: tuple,
    metallic: float = 0.0,
    roughness: float = 0.5,
    emission_color: tuple | None = None,
    emission_strength: float = 0.0,
) -> bpy.types.Material:
    mat = bpy.data.materials.new(name)
    mat.use_nodes = True
    tree = mat.node_tree
    tree.nodes.clear()
    out_n = tree.nodes.new("ShaderNodeOutputMaterial")
    bsdf = tree.nodes.new("ShaderNodeBsdfPrincipled")
    bsdf.inputs["Base Color"].default_value = base_color
    bsdf.inputs["Metallic"].default_value = metallic
    bsdf.inputs["Roughness"].default_value = roughness
    if emission_color is not None:
        bsdf.inputs["Emission Color"].default_value = emission_color
    bsdf.inputs["Emission Strength"].default_value = emission_strength
    tree.links.new(bsdf.outputs["BSDF"], out_n.inputs["Surface"])
    return mat


def _select_only(obj: bpy.types.Object):
    bpy.ops.object.select_all(action="DESELECT")
    obj.select_set(True)
    bpy.context.view_layer.objects.active = obj


def _world_bbox(obj: bpy.types.Object):
    if obj.type == "MESH":
        corners = [obj.matrix_world @ Vector(c) for c in obj.bound_box]
    elif obj.type == "CURVE":
        corners = []
        for sp in obj.data.splines:
            for bp in sp.bezier_points:
                corners.append(obj.matrix_world @ bp.co)
            for p in sp.points:
                corners.append(obj.matrix_world @ Vector(p.co[:3]))
    else:
        return Vector((0, 0, 0)), Vector((0, 0, 0))
    if not corners:
        return Vector((0, 0, 0)), Vector((0, 0, 0))
    mn = Vector(min(c[i] for c in corners) for i in range(3))
    mx = Vector(max(c[i] for c in corners) for i in range(3))
    return mn, mx


def _combined_bbox(objs: list[bpy.types.Object]):
    mn = Vector((1e10, 1e10, 1e10))
    mx = Vector((-1e10, -1e10, -1e10))
    for obj in objs:
        a, b = _world_bbox(obj)
        for i in range(3):
            mn[i] = min(mn[i], a[i])
            mx[i] = max(mx[i], b[i])
    return mn, mx


def _join_objects(objects: list[bpy.types.Object], name: str):
    objects = [o for o in objects if o is not None and o.name in bpy.data.objects]
    if not objects:
        return None
    if len(objects) == 1:
        objects[0].name = name
        return objects[0]
    bpy.ops.object.select_all(action="DESELECT")
    for o in objects:
        o.select_set(True)
    bpy.context.view_layer.objects.active = objects[0]
    bpy.ops.object.join()
    result = bpy.context.active_object
    result.name = name
    return result


def create_plate() -> bpy.types.Object:
    bpy.ops.mesh.primitive_cube_add(size=1, location=(0, 0, 0))
    plate = bpy.context.active_object
    plate.name = "IconPlate"
    plate.scale = (PLATE_SIZE, PLATE_SIZE, PLATE_DEPTH)
    bpy.ops.object.transform_apply(scale=True)
    bevel = plate.modifiers.new("Bevel", "BEVEL")
    bevel.width = BEVEL_RADIUS
    bevel.segments = 8
    bevel.limit_method = "ANGLE"
    bpy.ops.object.modifier_apply(modifier="Bevel")
    mat = make_material("PlateMat", PLATE_COLOR, metallic=0.85, roughness=0.22)
    plate.data.materials.append(mat)
    return plate


def import_and_process_logo():
    """Import EQMonitor SVG, separate ring and zigzag, and return positioned meshes.

    Returns (ring_obj, zigzag_obj). Either may be None on partial failure.
    """
    if not SVG_PATH.exists():
        print(f"[scene_builder] ERROR: SVG not found: {SVG_PATH}")
        sys.exit(1)

    before = set(bpy.data.objects[:])
    bpy.ops.import_curve.svg(filepath=str(SVG_PATH))
    new_objs = [o for o in bpy.data.objects if o not in before]
    empties = [o for o in new_objs if o.type == "EMPTY"]
    curves = [o for o in new_objs if o.type == "CURVE"]
    print(f"[scene_builder] Imported {len(curves)} curves, {len(empties)} empties")

    if not curves:
        print("[scene_builder] ERROR: No curves from SVG")
        sys.exit(1)

    curve_info = []
    for c in curves:
        mn, mx = _world_bbox(c)
        sz = mx - mn
        area = sz.x * sz.y
        pts = sum(len(s.bezier_points) + len(s.points) for s in c.data.splines)
        print(f"  {c.name}: pts={pts} size=({sz.x:.5f},{sz.y:.5f}) area={area:.6f}")
        curve_info.append({"obj": c, "area": area, "size": sz, "pts": pts})

    all_mn, all_mx = _combined_bbox(curves)
    full_sz = all_mx - all_mn
    px_scale = full_sz.x / SVG_CANVAS_PX if full_sz.x > 1e-8 else 1.0 / 90.0
    print(f"  Full size=({full_sz.x:.5f},{full_sz.y:.5f}), px_scale={px_scale:.7f}")

    full_area = full_sz.x * full_sz.y
    threshold = full_area * 0.35
    ring_curves = [ci["obj"] for ci in curve_info if ci["area"] > threshold]
    zigzag_curves = [ci["obj"] for ci in curve_info if ci["area"] <= threshold]

    # Remove duplicate zigzag curves (SVG has both fill and stroke paths)
    if len(zigzag_curves) > 1:
        zigzag_curves = zigzag_curves[:1]
        for extra in [ci["obj"] for ci in curve_info if ci["area"] <= threshold][1:]:
            bpy.data.objects.remove(extra, do_unlink=True)

    print(f"  ring={len(ring_curves)} zigzag={len(zigzag_curves)}")

    # ---- Process ring: filled face ----
    for c in ring_curves:
        c.data.fill_mode = "BOTH"
        c.data.bevel_depth = 0.0
        _select_only(c)
        bpy.ops.object.convert(target="MESH")

    ring_obj = _join_objects(ring_curves, "LogoRing")
    if ring_obj:
        _select_only(ring_obj)
        sol = ring_obj.modifiers.new("Solidify", "SOLIDIFY")
        sol.thickness = LOGO_EXTRUDE
        sol.offset = 1.0
        bpy.ops.object.modifier_apply(modifier="Solidify")

    # ---- Process zigzag: bevel tube flattened ----
    zigzag_obj = None
    if zigzag_curves:
        zc = zigzag_curves[0]
        for sp in zc.data.splines:
            sp.use_cyclic_u = False
            for bp in sp.bezier_points:
                bp.handle_left_type = "VECTOR"
                bp.handle_right_type = "VECTOR"
        zc.data.fill_mode = "NONE"
        zc.data.bevel_depth = (SVG_ZIGZAG_STROKE_WIDTH_PX / 2.0) * px_scale
        zc.data.bevel_resolution = 4
        if hasattr(zc.data, "use_fill_caps"):
            zc.data.use_fill_caps = True

        _select_only(zc)
        bpy.ops.object.convert(target="MESH")
        zc.name = "LogoZigzag"

        # Flatten tube in Z, then solidify for controlled height
        zc.scale.z = 0.01
        _select_only(zc)
        bpy.ops.object.transform_apply(scale=True)
        sol = zc.modifiers.new("Solidify", "SOLIDIFY")
        sol.thickness = LOGO_EXTRUDE
        sol.offset = 1.0
        bpy.ops.object.modifier_apply(modifier="Solidify")
        zigzag_obj = zc

    # ---- Assign material ----
    logo_mat = make_material(
        "LogoMat",
        LOGO_COLOR,
        roughness=0.3,
        emission_color=LOGO_EMISSION_COLOR,
        emission_strength=LOGO_EMISSION_STRENGTH,
    )
    for obj in (ring_obj, zigzag_obj):
        if obj:
            obj.data.materials.clear()
            obj.data.materials.append(logo_mat)

    # ---- Scale & position on plate ----
    _layout_on_plate(ring_obj, zigzag_obj)

    # Cleanup
    for e in empties:
        bpy.data.objects.remove(e, do_unlink=True)

    return ring_obj, zigzag_obj


def _layout_on_plate(ring_obj, zigzag_obj):
    """Center, scale XY, and position logo objects on the plate's front face."""
    objs = [o for o in (ring_obj, zigzag_obj) if o is not None]
    if not objs:
        return

    all_mn, all_mx = _combined_bbox(objs)
    center = (all_mn + all_mx) / 2.0
    size = all_mx - all_mn
    max_dim = max(size.x, size.y)
    if max_dim < 1e-8:
        print("[scene_builder] ERROR: Logo has zero size after processing")
        sys.exit(1)

    target = PLATE_SIZE * LOGO_FILL_RATIO
    s = target / max_dim
    print(f"[scene_builder] layout: center=({center.x:.5f},{center.y:.5f}) "
          f"max_dim={max_dim:.5f} scale={s:.4f}")

    for obj in objs:
        obj.location.x -= center.x
        obj.location.y -= center.y
        obj.location.z -= center.z
    for obj in objs:
        _select_only(obj)
        bpy.ops.object.transform_apply(location=True)

    for obj in objs:
        obj.scale = (s, s, 1.0)
    for obj in objs:
        _select_only(obj)
        bpy.ops.object.transform_apply(scale=True)

    # Align bottom of logo to plate front face + tiny offset
    all_mn, _ = _combined_bbox(objs)
    z_target = PLATE_DEPTH / 2.0 + 0.001
    z_off = z_target - all_mn.z
    for obj in objs:
        obj.location.z += z_off
    for obj in objs:
        _select_only(obj)
        bpy.ops.object.transform_apply(location=True)

    for obj in objs:
        mn, mx = _world_bbox(obj)
        print(f"  {obj.name}: bbox ({mn.x:.3f},{mn.y:.3f},{mn.z:.3f})"
              f" → ({mx.x:.3f},{mx.y:.3f},{mx.z:.3f})")


def build_scene():
    """Build complete 3D scene: plate + logo. Returns (plate, ring, zigzag)."""
    clear_scene()
    plate = create_plate()
    ring_obj, zigzag_obj = import_and_process_logo()
    return plate, ring_obj, zigzag_obj
