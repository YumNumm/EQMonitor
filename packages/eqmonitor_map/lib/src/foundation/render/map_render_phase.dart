extension type const MapRenderPhaseId._(String value) {
  static const labelForeground = MapRenderPhaseId._('labelForeground');
}

final class MapRenderPhasePolicy {
  const MapRenderPhasePolicy._();
}

MapRenderPhaseId createMapRenderPhaseId({required String value}) {
  final normalizedValue = value.trim();
  if (normalizedValue.isEmpty) {
    throw ArgumentError.value(value, 'value', 'must not be blank');
  }

  return MapRenderPhaseId._(normalizedValue);
}
