final class MapRenderSortKey {
  new({
    required this.phasePolicyVersion,
    required this.phase,
    required this.declarationOrderWithinPhase,
    required this.sourceOrder,
    required this.overscaledTileOrder,
    required this.featureOrder,
  }) {
    if (phasePolicyVersion <= 0) {
      throw ArgumentError.value(phasePolicyVersion, 'phasePolicyVersion');
    }
    if (phase < 0 ||
        declarationOrderWithinPhase < 0 ||
        sourceOrder < 0 ||
        overscaledTileOrder < 0 ||
        featureOrder < 0) {
      throw ArgumentError('ordering fields must not be negative');
    }
  }

  final int phasePolicyVersion;
  final int phase;
  final int declarationOrderWithinPhase;
  final int sourceOrder;
  final int overscaledTileOrder;
  final int featureOrder;
}

int compareMapRenderSortKeys(MapRenderSortKey left, MapRenderSortKey right) {
  if (left.phasePolicyVersion != right.phasePolicyVersion) {
    throw ArgumentError('phase policy versions must match');
  }
  return left.phase != right.phase
      ? left.phase.compareTo(right.phase)
      : left.declarationOrderWithinPhase != right.declarationOrderWithinPhase
      ? left.declarationOrderWithinPhase.compareTo(
          right.declarationOrderWithinPhase,
        )
      : left.sourceOrder != right.sourceOrder
      ? left.sourceOrder.compareTo(right.sourceOrder)
      : left.overscaledTileOrder != right.overscaledTileOrder
      ? left.overscaledTileOrder.compareTo(right.overscaledTileOrder)
      : left.featureOrder.compareTo(right.featureOrder);
}

int reverseMapRenderSortKeysForHitTest(
  MapRenderSortKey left,
  MapRenderSortKey right,
) => compareMapRenderSortKeys(right, left);
