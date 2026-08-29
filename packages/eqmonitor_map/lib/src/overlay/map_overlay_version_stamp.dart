import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:flutter/foundation.dart';

/// One immutable identity for an earthquake overlay's data and render input.
@immutable
final class MapOverlayVersionStamp {
  const MapOverlayVersionStamp._({
    required this.sourceIdentity,
    required this.sourceIncarnation,
    required this.dataSequence,
    required this.dataDigest,
    required this.renderGeneration,
    required this.renderDigest,
  });

  final MapSourceIdentity sourceIdentity;
  final MapSourceIncarnation sourceIncarnation;
  final int dataSequence;
  final String dataDigest;
  final int renderGeneration;
  final String renderDigest;

  @override
  bool operator ==(Object other) =>
      other is MapOverlayVersionStamp &&
      other.sourceIdentity == sourceIdentity &&
      other.sourceIncarnation == sourceIncarnation &&
      other.dataSequence == dataSequence &&
      other.dataDigest == dataDigest &&
      other.renderGeneration == renderGeneration &&
      other.renderDigest == renderDigest;

  @override
  int get hashCode => Object.hash(
    sourceIdentity,
    sourceIncarnation,
    dataSequence,
    dataDigest,
    renderGeneration,
    renderDigest,
  );
}

MapOverlayVersionStamp createMapOverlayVersionStamp({
  required MapSourceIdentity sourceIdentity,
  required MapSourceIncarnation sourceIncarnation,
  required int dataSequence,
  required String dataDigest,
  required int renderGeneration,
  required String renderDigest,
}) {
  if (dataSequence.isNegative) {
    throw ArgumentError.value(dataSequence, 'dataSequence');
  }
  if (renderGeneration.isNegative) {
    throw ArgumentError.value(renderGeneration, 'renderGeneration');
  }
  final normalizedDataDigest = dataDigest.trim();
  final normalizedRenderDigest = renderDigest.trim();
  if (normalizedDataDigest.isEmpty) {
    throw ArgumentError.value(dataDigest, 'dataDigest', 'must not be blank');
  }
  if (normalizedRenderDigest.isEmpty) {
    throw ArgumentError.value(
      renderDigest,
      'renderDigest',
      'must not be blank',
    );
  }
  return MapOverlayVersionStamp._(
    sourceIdentity: sourceIdentity,
    sourceIncarnation: sourceIncarnation,
    dataSequence: dataSequence,
    dataDigest: normalizedDataDigest,
    renderGeneration: renderGeneration,
    renderDigest: normalizedRenderDigest,
  );
}

/// Whether [next] is a valid full-snapshot transition from [current].
bool canAdvanceMapOverlayVersionStamp({
  required MapOverlayVersionStamp current,
  required MapOverlayVersionStamp next,
}) {
  if (current.sourceIdentity != next.sourceIdentity ||
      current.sourceIncarnation != next.sourceIncarnation) {
    return true;
  }
  if (next.dataSequence < current.dataSequence ||
      next.renderGeneration < current.renderGeneration) {
    return false;
  }
  if (next.dataSequence == current.dataSequence &&
      next.dataDigest != current.dataDigest) {
    return false;
  }
  return next.renderGeneration != current.renderGeneration ||
      next.renderDigest == current.renderDigest;
}
