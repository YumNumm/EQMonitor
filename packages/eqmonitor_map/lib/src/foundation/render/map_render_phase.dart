extension type const MapRenderPhaseId._(String value) {
  static const labelForeground = MapRenderPhaseId._('labelForeground');
}

final class MapRenderPhasePolicy {
  const MapRenderPhasePolicy._({
    required this.version,
    required this.orderedPhases,
    required Map<MapRenderPhaseId, int> rankByPhase,
  }) : _rankByPhase = rankByPhase;

  final int version;
  final List<MapRenderPhaseId> orderedPhases;
  final Map<MapRenderPhaseId, int> _rankByPhase;

  int rankOf(MapRenderPhaseId phase) {
    final rank = _rankByPhase[phase];
    if (rank == null) {
      throw ArgumentError.value(phase.value, 'phase', 'is not in the policy');
    }
    return rank;
  }
}

MapRenderPhaseId createMapRenderPhaseId({required String value}) {
  final normalizedValue = value.trim();
  if (normalizedValue.isEmpty) {
    throw ArgumentError.value(value, 'value', 'must not be blank');
  }

  return MapRenderPhaseId._(normalizedValue);
}

MapRenderPhasePolicy createMapRenderPhasePolicy({
  required int version,
  required List<MapRenderPhaseId> orderedPhases,
}) {
  if (version <= 0) {
    throw ArgumentError.value(version, 'version', 'must be positive');
  }
  if (orderedPhases.isEmpty) {
    throw ArgumentError.value(orderedPhases, 'orderedPhases');
  }

  final ranks = <MapRenderPhaseId, int>{};
  for (final (rank, phase) in orderedPhases.indexed) {
    if (ranks.containsKey(phase)) {
      throw ArgumentError.value(phase.value, 'orderedPhases');
    }
    ranks[phase] = rank;
  }
  if (!ranks.containsKey(MapRenderPhaseId.labelForeground)) {
    throw ArgumentError.value(orderedPhases, 'orderedPhases');
  }

  return MapRenderPhasePolicy._(
    version: version,
    orderedPhases: List.unmodifiable(orderedPhases),
    rankByPhase: Map.unmodifiable(ranks),
  );
}
