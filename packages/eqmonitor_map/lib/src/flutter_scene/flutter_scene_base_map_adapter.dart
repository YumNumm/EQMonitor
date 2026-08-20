import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';
import 'package:eqmonitor_map/src/renderer/base_map_material_parameters.dart';
import 'package:eqmonitor_map/src/renderer/base_map_packed_mesh.dart';
import 'package:eqmonitor_map/src/renderer/base_map_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/map_gpu_resource_ledger.dart';
import 'package:eqmonitor_map/src/renderer/map_render_batch_adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:vector_math/vector_math.dart' as scene_math;

/// `batchKey.materialKey`(=`styleLayerId`)から、そのlayer専用の
/// `scene.PreprocessedMaterial`を引く関数。
///
/// materialの読み込み(`scene.loadFmatMaterial`)は非同期なので、同期の
/// [FlutterSceneBaseMapAdapter.submit]の中では行えない。呼び出し側が
/// 初期化時に全layer分を読み込み、この関数で引けるようにしておく。
/// 未知のkeyには`null`を返し、adapterがfail closedする。
typedef BaseMapSceneMaterialResolver =
    scene.PreprocessedMaterial? Function(String materialKey);

/// [MapRenderSubmission]をFlutter Sceneのnode treeへ変換する
/// [MapRenderBatchAdapter]。
///
/// # 境界の意味
///
/// このclassより上(`renderer/`・`foundation/`)はFlutter Sceneの型を一切知らず、
/// packed byte・行列・uniform byteだけを扱う(設計正本「domain、reconciler、
/// packed meshはFlutter Scene型へ依存させず、`MapSceneRendererAdapter`境界で
/// Geometry/Material/bufferへ変換する」)。Scene型がこのファイルの外へ漏れない
/// ことは`test/renderer/renderer_scene_independence_test.dart`が機械的に確認する。
///
/// # GPU resourceの寿命
///
/// `scene.MeshGeometry`は[MapPackedMesh]のinstance identityをkeyにして
/// [MapGpuResourceLedger]へ登録する。`MapRenderPacket`はGPU resource idを持た
/// ないため、「同じpacked mesh instanceは同じGPU resource」という規約を
/// adapterとpacked mesh cacheの間で持つ(`BaseMapPackedMeshCache`が同じtileへ
/// 同じinstanceを返し続ける責務を負う)。
///
/// `MapFrameSnapshot.contextGeneration`が変わったframeでは、ledgerが前世代の
/// resourceを全て手放してから新しいuploadを始める。context generationを跨いだ
/// GPU resourceの再利用は行わない(#1593要件3)。ただしretireの意味は
/// **Dart参照を落としてGC対象にすること**までであり、`flutter_scene`の
/// `gpu.DeviceBuffer`は`dispose()`を持たないため解放時期は決定的ではない
/// (`docs/todo/820_flutter_scene_batched_instance_slot_clobber.md`と同じ制約)。
final class FlutterSceneBaseMapAdapter implements MapRenderBatchAdapter {
  new({
    required scene.Scene sceneGraph,
    required BaseMapSceneMaterialResolver materialFor,
    required int maxFramesInFlight,
  }) : this._(
         sceneGraph,
         materialFor,
         MapGpuResourceLedger<scene.MeshGeometry>(
           maxFramesInFlight: maxFramesInFlight,
         ),
       );

  /// private fieldへのinitializing formalは名前付きにできないため、内部用の
  /// 位置引数constructorへ委譲する。
  new _(this._sceneGraph, this._materialFor, this._geometries);

  final scene.Scene _sceneGraph;
  final BaseMapSceneMaterialResolver _materialFor;
  final MapGpuResourceLedger<scene.MeshGeometry> _geometries;

  var _uploadedGeometryCount = 0;
  var _retiredGeometryCount = 0;

  /// このadapterが行ったGPU uploadの累計。HUDと性能eventの材料であり、
  /// frameごとのuploadが0へ収束することを実機で確認できるようにする。
  int get uploadedGeometryCount => _uploadedGeometryCount;

  /// context generation変更とframes-in-flight世代で手放したresourceの累計。
  int get retiredGeometryCount => _retiredGeometryCount;

  /// 現在GPU側に保持しているgeometryの件数。
  int get liveGeometryCount => _geometries.liveResourceCount;

  @override
  void submit({required MapRenderSubmission submission}) {
    validateMapRenderSubmission(submission: submission);
    final frame = submission.frame;
    _retiredGeometryCount += _geometries
        .beginFrame(
          contextGeneration: frame.contextGeneration,
          frameNumber: frame.frameNumber,
        )
        .length;

    final nodes = <scene.Node>[];
    for (final batch in submission.batches) {
      final materialKey = batch.compatibility.batchKey.materialKey;
      final material = _materialFor(materialKey);
      if (material == null) {
        throw StateError(
          'No Flutter Scene material is loaded for "$materialKey".',
        );
      }
      applyBaseMapMaterialParameters(
        material: material,
        pipelineKey: batch.compatibility.pipeline.key,
        bytes: batch.compatibility.materialParameters.bytes,
      );

      for (final (index, packet) in batch.packets.indexed) {
        nodes.add(
          scene.Node(
            localTransform: scene_math.Matrix4.fromList(
              batch.instanceTransforms[index],
            ),
            mesh: scene.Mesh(_geometryFor(packet.mesh), material),
          ),
        );
      }
    }

    _sceneGraph
      ..removeAll()
      ..addAll(nodes);
    _retiredGeometryCount += _geometries.retireIdle().length;
  }

  /// GPU resourceを全て手放す。
  ///
  /// backgroundへ移った時とdispose時に呼ぶ。CPU側のpacked meshは
  /// `BaseMapPackedMeshCache`が持ち続けるため、foregroundへ戻ったら
  /// re-decodeなしで再uploadできる(#1593要件4)。
  void retireAllGpuResources() {
    _retiredGeometryCount += _geometries.retireAll().length;
    _sceneGraph.removeAll();
  }

  scene.MeshGeometry _geometryFor(MapPackedMesh mesh) {
    final cached = _geometries.lookup(key: mesh);
    if (cached != null) {
      return cached;
    }
    final args = unpackBaseMapSceneGeometryArgs(mesh);
    final geometry = scene.MeshGeometry.fromArrays(
      positions: args.positions,
      texCoords: args.extrudes,
      indices: args.indices,
    );
    _geometries.put(key: mesh, resource: geometry);
    _uploadedGeometryCount++;
    return geometry;
  }
}

/// [MapPackedMesh]から`MeshGeometry.fromArrays`へ渡す引数。
///
/// GPU呼び出しを含まないため、GPU初期化なしのunit testで検証できる
/// (GPU初期化を要する呼び出しの直前までをpure関数にする、というこのpackage
/// 既存の方針に従う)。
@immutable
final class BaseMapSceneGeometryArgs {
  const new({
    required this.positions,
    required this.indices,
    required this.extrudes,
  });

  /// tile-local座標を3成分(x, y, 0)へ展開したfloat32頂点列。
  ///
  /// packed meshは2成分しか持たない([baseMapFillPackedMeshLayout]のdoc
  /// comment参照)。3成分positionはFlutter Sceneの`MeshGeometry.fromArrays`
  /// 側の制約なので、z=0の埋めはこのadapter層だけで行う。
  final Float32List positions;

  final Uint16List indices;

  /// clip/NDC Y-up済みの押し出し法線。Fillはnull。
  ///
  /// `MeshGeometry.fromArrays`の組み込み`texCoords`(`vec2`)へ渡す。UVではなく
  /// 押し出し法線を運ぶという意味論の逸脱があるが、`setCustomAttribute`経由の
  /// custom vertex attributeは値がshaderへ届かず同じ頂点の`position`が読まれる
  /// 不具合を実機で確認したため使わない(経緯は
  /// `docs/todo/800_eqmonitor_map_deferred_verification.md`)。
  final Float32List? extrudes;
}

/// [mesh]のpacked byteを`MeshGeometry.fromArrays`の引数へ解く。
///
/// pack→unpackの往復は無駄に見えるが、これはpacked meshを
/// 「Scene非依存のGPU転送contract」に保つための代償である。`fromArrays`が
/// structure-of-arraysしか受け取らないため、interleaved bufferをそのまま
/// 渡せない(flutter_sceneがraw vertex bufferを受け取るAPIを持ったら、この
/// 関数ごと不要になる)。解く回数はmesh 1つにつき1回だけであり、結果の
/// `MeshGeometry`は[MapGpuResourceLedger]がpacked mesh identityで保持する。
BaseMapSceneGeometryArgs unpackBaseMapSceneGeometryArgs(MapPackedMesh mesh) {
  final layout = mesh.layout;
  final isFill = haveCompatibleMapPackedMeshLayouts(
    layout,
    baseMapFillPackedMeshLayout,
  );
  final isLine = haveCompatibleMapPackedMeshLayouts(
    layout,
    baseMapLinePackedMeshLayout,
  );
  if (!isFill && !isLine) {
    throw ArgumentError.value(
      layout.vertexStride,
      'mesh',
      'is neither a base map fill nor a base map line layout',
    );
  }
  final indexBytes = mesh.indexBytes;
  final indexCount = mesh.indexCount;
  if (indexBytes == null || indexCount == null) {
    // layout互換性がuint16 indexを含み、`createMapPackedMesh`が
    // 「indexFormatがあるならindexBytes/indexCountも必須」を検証済みなので、
    // ここへは到達しない。将来index無しのlayoutを足したときに気付けるよう
    // 空描画へ丸めずStateErrorにする。
    throw StateError('A base map packed mesh must carry an index buffer.');
  }

  final vertices = ByteData.sublistView(mesh.vertexBytes);
  final positions = Float32List(mesh.vertexCount * 3);
  final extrudes = isLine ? Float32List(mesh.vertexCount * 2) : null;
  for (var vertex = 0; vertex < mesh.vertexCount; vertex++) {
    final offset = vertex * layout.vertexStride;
    positions[vertex * 3] = vertices.getFloat32(offset, Endian.little);
    positions[vertex * 3 + 1] = vertices.getFloat32(offset + 4, Endian.little);
    // positions[vertex * 3 + 2]はFloat32Listの既定値0のまま。
    if (extrudes != null) {
      extrudes[vertex * 2] = vertices.getFloat32(offset + 8, Endian.little);
      extrudes[vertex * 2 + 1] = vertices.getFloat32(
        offset + 12,
        Endian.little,
      );
    }
  }

  final indices = Uint16List(indexCount);
  final indexData = ByteData.sublistView(indexBytes);
  for (var index = 0; index < indexCount; index++) {
    indices[index] = indexData.getUint16(index * 2, Endian.little);
  }

  return BaseMapSceneGeometryArgs(
    positions: positions,
    indices: indices,
    extrudes: extrudes,
  );
}

/// uniform blockのbyte列を[material]のparameterへ適用する。
///
/// pipeline keyでfill/lineを判別し、それぞれの`.fmat`が宣言している
/// parameter名へ書く。byte長が合わなければ
/// [decodeBaseMapFillMaterialBytes]/[decodeBaseMapLineMaterialBytes]が
/// `ArgumentError`を投げるため、pipelineとuniformの対応が崩れたまま
/// 静かに誤った値をshaderへ渡すことはない。
void applyBaseMapMaterialParameters({
  required scene.PreprocessedMaterial material,
  required String pipelineKey,
  required Uint8List bytes,
}) {
  if (pipelineKey == baseMapFillPipelineKey.key) {
    final values = decodeBaseMapFillMaterialBytes(bytes);
    material.parameters.setColor('fill_color', values.color);
    return;
  }
  if (pipelineKey == baseMapLinePipelineKey.key) {
    final values = decodeBaseMapLineMaterialBytes(bytes);
    material.parameters
      ..setColor('line_color', values.color)
      ..setVec2(
        'half_width_ndc',
        scene_math.Vector2(values.halfWidthNdcX, values.halfWidthNdcY),
      );
    return;
  }
  throw ArgumentError.value(
    pipelineKey,
    'pipelineKey',
    'is not a base map pipeline',
  );
}
