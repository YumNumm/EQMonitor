import 'dart:isolate';

import 'package:eqmonitor_map/src/mesh/fill_mesh_build_exception.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh_builder.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_build_exception.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder.dart';
import 'package:eqmonitor_map/src/tile/estimated_intensity_tile_decode_exception.dart';
import 'package:eqmonitor_map/src/tile/estimated_intensity_tile_decode_limits.dart';
import 'package:eqmonitor_map/src/tile/estimated_intensity_tile_geometry.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decode_exception.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decoder.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_tile.dart';
import 'package:eqmonitor_map/src/tile/mvt/polygon_boundary_builder.dart';
import 'package:flutter/foundation.dart';

export 'estimated_intensity_tile_decode_exception.dart';
export 'estimated_intensity_tile_decode_limits.dart';

const estimatedIntensitySourceLayerName = 'seismic_intensity';

final class EstimatedIntensityTileDecoder {
  const new();

  Future<EstimatedIntensityTileGeometry> decode({
    required Uint8List tileBytes,
    required EstimatedIntensityTileDecodeLimits limits,
  }) => Isolate.run(() => decodeEstimatedIntensityTileSync(tileBytes, limits));
}

/// Themeやapp stateに依存せず、推計震度tileをclass別meshへ変換する同期本体。
@visibleForTesting
EstimatedIntensityTileGeometry decodeEstimatedIntensityTileSync(
  Uint8List tileBytes,
  EstimatedIntensityTileDecodeLimits limits,
) {
  final fillBuilder = FillMeshBuilder(limits: limits.fillLimits);
  final lineBuilder = LineMeshBuilder(
    limits: limits.lineLimits,
    miterLimit: limits.lineMiterLimit,
  );
  try {
    final tile = decodeMvtTile(tileBytes, limits: limits.mvtLimits);
    final matchingLayers = tile.layers
        .where((layer) => layer.name == estimatedIntensitySourceLayerName)
        .toList(growable: false);
    if (matchingLayers.isEmpty) {
      throw const EstimatedIntensityTileDecodeException(
        EstimatedIntensityTileDecodeFailure.missingSourceLayer,
      );
    }
    if (matchingLayers.length != 1) {
      throw const EstimatedIntensityTileDecodeException(
        EstimatedIntensityTileDecodeFailure.duplicateSourceLayer,
      );
    }
    final layer = matchingLayers.single;
    if (layer.features.isEmpty) {
      return EstimatedIntensityTileEmpty(extent: layer.extent);
    }

    final featuresByClass = {
      for (final intensityClass in EstimatedIntensityClass.values)
        intensityClass: <MvtFeature>[],
    };
    for (final feature in layer.features) {
      if (feature.type != MvtGeometryType.polygon) {
        throw const EstimatedIntensityTileDecodeException(
          EstimatedIntensityTileDecodeFailure.wrongGeometry,
        );
      }
      final name = feature.properties['name'];
      if (name == null || name.isEmpty) {
        throw const EstimatedIntensityTileDecodeException(
          EstimatedIntensityTileDecodeFailure.missingName,
        );
      }
      final intensityClass = EstimatedIntensityClass.fromSourceName(name);
      if (intensityClass == null) {
        throw const EstimatedIntensityTileDecodeException(
          EstimatedIntensityTileDecodeFailure.unknownClass,
        );
      }
      featuresByClass[intensityClass]?.add(feature);
    }

    const boundaryBuilder = PolygonBoundaryBuilder();
    return EstimatedIntensityTileReady(
      extent: layer.extent,
      classes: [
        for (final intensityClass in EstimatedIntensityClass.values)
          if (featuresByClass[intensityClass] case final features?
              when features.isNotEmpty)
            EstimatedIntensityClassGeometry(
              intensityClass: intensityClass,
              fillMeshes: fillBuilder.build(features),
              boundaryMeshes: lineBuilder.build([
                for (final feature in features)
                  boundaryBuilder.build(feature: feature),
              ]),
            ),
      ],
    );
  } on EstimatedIntensityTileDecodeException {
    rethrow;
  } on MvtLimitExceededException {
    throw const EstimatedIntensityTileDecodeException(
      EstimatedIntensityTileDecodeFailure.resourceLimitExceeded,
    );
  } on FillMeshLimitExceededException {
    throw const EstimatedIntensityTileDecodeException(
      EstimatedIntensityTileDecodeFailure.resourceLimitExceeded,
    );
  } on LineMeshLimitExceededException {
    throw const EstimatedIntensityTileDecodeException(
      EstimatedIntensityTileDecodeFailure.resourceLimitExceeded,
    );
  } on MvtInvalidGeometryCommandException {
    throw const EstimatedIntensityTileDecodeException(
      EstimatedIntensityTileDecodeFailure.invalidGeometry,
    );
  } on FillMeshDegenerateRingException {
    throw const EstimatedIntensityTileDecodeException(
      EstimatedIntensityTileDecodeFailure.invalidGeometry,
    );
  } on FillMeshHoleBeforeExteriorException {
    throw const EstimatedIntensityTileDecodeException(
      EstimatedIntensityTileDecodeFailure.invalidGeometry,
    );
  } on MvtDecodeException {
    throw const EstimatedIntensityTileDecodeException(
      EstimatedIntensityTileDecodeFailure.invalidMvt,
    );
  }
}
