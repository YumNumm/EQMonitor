import 'dart:convert';
import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/geo/map_mercator_projection.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/overlay/map_overlay_version_stamp.dart';
import 'package:eqmonitor_map/src/overlay/map_point_sprite_feature.dart';
import 'package:eqmonitor_map/src/overlay/map_sprite_atlas.dart';
import 'package:eqmonitor_map/src/overlay/map_zoom_scalar_policy.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_frame_submission.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_render_phase_policy.dart';
import 'package:eqmonitor_map/src/renderer/map_sprite_batch.dart';

List<MapPointSpriteInstanceBatch> buildMapPointSpriteBatches({
  required MapFrameSnapshot frame,
  required MapOverlayVersionStamp versionStamp,
  required MapSpriteAtlas? atlas,
  required List<MapPointSpriteFeature> features,
  required int maxPolicyBatches,
  List<MapPointSpriteInstanceBatch> previous = const [],
  MapMercatorProjection projection = const MapMercatorProjection(),
}) {
  if (maxPolicyBatches <= 0) {
    throw ArgumentError.value(maxPolicyBatches, 'maxPolicyBatches');
  }
  if (features.isEmpty) {
    return const [];
  }
  if (atlas == null) {
    throw ArgumentError.value(atlas, 'atlas', 'is required by sprites');
  }
  final regions = {for (final region in atlas.regions) region.id: region};
  final groups =
      <(MapZoomLinearRange, MapZoomStep), List<MapPointSpriteFeature>>{};
  final ids = <String>{};
  for (final feature in features) {
    if (!ids.add(feature.id) || !regions.containsKey(feature.spriteRegionId)) {
      throw ArgumentError.value(features, 'features');
    }
    final sizePolicy = _canonicalSizePolicy(feature.sizeScale);
    final opacityPolicy = _canonicalOpacityPolicy(feature.opacity);
    groups
        .putIfAbsent((sizePolicy, opacityPolicy), () => [])
        .add(
          feature,
        );
  }
  if (groups.length > maxPolicyBatches) {
    throw ArgumentError.value(groups.length, 'features');
  }
  final entries = groups.entries.toList()
    ..sort(
      (left, right) =>
          _policyDigest(
            size: left.key.$1,
            opacity: left.key.$2,
          ).compareTo(
            _policyDigest(size: right.key.$1, opacity: right.key.$2),
          ),
    );
  final previousByDigest = {
    for (final batch in previous)
      '${batch.batchKey.value}|${batch.instanceDigest}': batch,
  };
  return List.unmodifiable([
    for (final entry in entries)
      _buildPolicyBatch(
        frame: frame,
        versionStamp: versionStamp,
        atlas: atlas,
        regions: regions,
        sizePolicy: entry.key.$1,
        opacityPolicy: entry.key.$2,
        features: entry.value,
        previousByDigest: previousByDigest,
        projection: projection,
      ),
  ]);
}

MapPointSpriteInstanceBatch _buildPolicyBatch({
  required MapFrameSnapshot frame,
  required MapOverlayVersionStamp versionStamp,
  required MapSpriteAtlas atlas,
  required Map<String, MapSpriteRegion> regions,
  required MapZoomLinearRange sizePolicy,
  required MapZoomStep opacityPolicy,
  required List<MapPointSpriteFeature> features,
  required Map<String, MapPointSpriteInstanceBatch> previousByDigest,
  required MapMercatorProjection projection,
}) {
  features.sort(
    (left, right) => left.priority != right.priority
        ? left.priority.compareTo(right.priority)
        : left.id.compareTo(right.id),
  );
  final instanceData = _packMapPointSpriteInstances(
    features: features,
    regions: regions,
    projection: projection,
  );
  final policyDigest = _policyDigest(
    size: sizePolicy,
    opacity: opacityPolicy,
  );
  final batchKey = createMapSceneBatchKey(
    value:
        'atlas:${atlas.identity.value}|material:$mapSpriteMaterialAbiVersion|'
        'policy:$policyDigest',
  );
  final instanceDigest = [
    for (final feature in features) '${feature.id.length}:${feature.id}',
    base64Encode(instanceData.buffer.asUint8List()),
  ].join('|');
  final frameUniform = packMapSpriteFrameUniform(
    frame: frame,
    sizePolicy: sizePolicy,
    opacityPolicy: opacityPolicy,
    projection: projection,
  );
  final reusable = previousByDigest['${batchKey.value}|$instanceDigest'];
  if (reusable != null) {
    return reusable.withFrame(
      frame: frame,
      versionStamp: versionStamp,
      frameUniform: frameUniform,
    );
  }
  MapPointSpriteInstanceBatch? textureReplacementReusable;
  for (final batch in previousByDigest.values) {
    if (identical(batch.atlas.regions, atlas.regions) &&
        batch.sizePolicy == sizePolicy &&
        batch.opacityPolicy == opacityPolicy &&
        batch.instanceDigest == instanceDigest) {
      textureReplacementReusable = batch;
      break;
    }
  }
  if (textureReplacementReusable != null) {
    return textureReplacementReusable.withAtlasAndFrame(
      frame: frame,
      versionStamp: versionStamp,
      atlas: atlas,
      frameUniform: frameUniform,
      batchKey: batchKey,
    );
  }
  return createMapPointSpriteInstanceBatch(
    frame: frame,
    versionStamp: versionStamp,
    atlas: atlas,
    sizePolicy: sizePolicy,
    opacityPolicy: opacityPolicy,
    featureIds: [for (final feature in features) feature.id],
    instanceData: instanceData,
    instanceCount: features.length,
    instanceDigest: instanceDigest,
    frameUniform: frameUniform,
    batchKey: batchKey,
    phasePolicyVersion: mapSceneRenderPhasePolicy.version,
    phase: mapSceneRenderPhasePolicy.rankOf(mapSceneSpritePhaseId),
  );
}

Float32List _packMapPointSpriteInstances({
  required List<MapPointSpriteFeature> features,
  required Map<String, MapSpriteRegion> regions,
  required MapMercatorProjection projection,
}) {
  final data = Float32List(features.length * 10);
  final bytes = ByteData.sublistView(data);
  for (final (index, feature) in features.indexed) {
    final center = projection.lngLatToNormalized(
      longitude: feature.longitude,
      latitude: feature.latitude,
    );
    final region = regions[feature.spriteRegionId];
    if (region == null) {
      throw StateError('Validated sprite region disappeared.');
    }
    final offset = index * mapPointSpriteInstanceStrideInBytes;
    bytes
      ..setFloat32(offset, center.x, Endian.little)
      ..setFloat32(offset + 4, center.y, Endian.little)
      ..setFloat32(offset + 8, region.normalizedUv.left, Endian.little)
      ..setFloat32(offset + 12, region.normalizedUv.top, Endian.little)
      ..setFloat32(offset + 16, region.normalizedUv.right, Endian.little)
      ..setFloat32(offset + 20, region.normalizedUv.bottom, Endian.little)
      ..setFloat32(offset + 24, region.logicalSize.width, Endian.little)
      ..setFloat32(offset + 28, region.logicalSize.height, Endian.little)
      ..setFloat32(offset + 32, 1, Endian.little)
      ..setFloat32(offset + 36, feature.priority.toDouble(), Endian.little);
  }
  return data;
}

ByteData packMapSpriteFrameUniform({
  required MapFrameSnapshot frame,
  required MapZoomLinearRange sizePolicy,
  required MapZoomStep opacityPolicy,
  MapMercatorProjection projection = const MapMercatorProjection(),
}) {
  final camera = projection.lngLatToNormalized(
    longitude: frame.camera.centerLongitude,
    latitude: frame.camera.centerLatitude,
  );
  return ByteData(mapSpriteFrameUniformByteLength)
    ..setFloat32(0, camera.x, Endian.little)
    ..setFloat32(4, camera.y, Endian.little)
    ..setFloat32(
      8,
      projection.worldSizeForZoom(frame.camera.zoom),
      Endian.little,
    )
    ..setFloat32(16, frame.viewport.logicalSize.width, Endian.little)
    ..setFloat32(20, frame.viewport.logicalSize.height, Endian.little)
    ..setFloat32(24, frame.camera.zoom, Endian.little)
    ..setFloat32(32, sizePolicy.startZoom, Endian.little)
    ..setFloat32(36, sizePolicy.startValue, Endian.little)
    ..setFloat32(40, sizePolicy.endZoom, Endian.little)
    ..setFloat32(44, sizePolicy.endValue, Endian.little)
    ..setFloat32(48, opacityPolicy.thresholdZoom, Endian.little)
    ..setFloat32(52, opacityPolicy.belowValue, Endian.little)
    ..setFloat32(56, opacityPolicy.atOrAboveValue, Endian.little);
}

String _policyDigest({
  required MapZoomLinearRange size,
  required MapZoomStep opacity,
}) => [
  size.startZoom,
  size.startValue,
  size.endZoom,
  size.endValue,
  opacity.thresholdZoom,
  opacity.belowValue,
  opacity.atOrAboveValue,
].map((value) => value.toString()).join(':');

MapZoomLinearRange _canonicalSizePolicy(MapZoomLinearRange policy) =>
    createMapZoomLinearRange(
      startZoom: _canonicalPolicyScalar(policy.startZoom),
      startValue: _canonicalPolicyScalar(policy.startValue),
      endZoom: _canonicalPolicyScalar(policy.endZoom),
      endValue: _canonicalPolicyScalar(policy.endValue),
    );

MapZoomStep _canonicalOpacityPolicy(MapZoomStep policy) => createMapZoomStep(
  thresholdZoom: _canonicalPolicyScalar(policy.thresholdZoom),
  belowValue: _canonicalPolicyScalar(policy.belowValue),
  atOrAboveValue: _canonicalPolicyScalar(policy.atOrAboveValue),
);

double _canonicalPolicyScalar(double value) => value == 0 ? 0 : value;

double nearestWrappedMapSpriteWorldDelta({
  required double normalizedX,
  required double cameraNormalizedX,
}) {
  if (!normalizedX.isFinite || !cameraNormalizedX.isFinite) {
    throw ArgumentError('normalized X coordinates must be finite');
  }
  final delta = normalizedX - cameraNormalizedX;
  return delta - delta.round();
}

({double x, double y}) mapPointSpriteNdc({
  required double normalizedX,
  required double normalizedY,
  required double cameraNormalizedX,
  required double cameraNormalizedY,
  required double worldSizeLogicalPixels,
  required MapViewport viewport,
  required double cornerX,
  required double cornerY,
  required double logicalWidth,
  required double logicalHeight,
  required double sizeScale,
}) {
  final values = [
    normalizedY,
    cameraNormalizedY,
    worldSizeLogicalPixels,
    cornerX,
    cornerY,
    logicalWidth,
    logicalHeight,
    sizeScale,
  ];
  if (values.any((value) => !value.isFinite) ||
      worldSizeLogicalPixels <= 0 ||
      logicalWidth <= 0 ||
      logicalHeight <= 0 ||
      sizeScale <= 0) {
    throw ArgumentError.value(values, 'sprite projection');
  }
  final logicalX =
      nearestWrappedMapSpriteWorldDelta(
        normalizedX: normalizedX,
        cameraNormalizedX: cameraNormalizedX,
      ) *
      worldSizeLogicalPixels;
  final logicalY = (normalizedY - cameraNormalizedY) * worldSizeLogicalPixels;
  return (
    x:
        logicalX * 2 / viewport.logicalSize.width +
        cornerX * logicalWidth * sizeScale / viewport.logicalSize.width,
    y:
        -logicalY * 2 / viewport.logicalSize.height +
        cornerY * logicalHeight * sizeScale / viewport.logicalSize.height,
  );
}

double evaluateMapSpriteSize({
  required MapZoomLinearRange policy,
  required double zoom,
}) => policy.valueAt(zoom: zoom);

double evaluateMapSpriteOpacity({
  required MapZoomStep policy,
  required double zoom,
}) => policy.valueAt(zoom: zoom);

({double red, double green, double blue, double alpha})
premultiplyMapSpriteSample({
  required double red,
  required double green,
  required double blue,
  required double sampleAlpha,
  required double featureOpacity,
}) {
  final values = [red, green, blue, sampleAlpha, featureOpacity];
  if (values.any((value) => !value.isFinite || value < 0 || value > 1)) {
    throw ArgumentError.value(values, 'sample');
  }
  final alpha = sampleAlpha * featureOpacity;
  return (
    red: red * alpha,
    green: green * alpha,
    blue: blue * alpha,
    alpha: alpha,
  );
}
