extension type MapNodeKey._(String value) {}

extension type MapNodeTypeId._(String value) {}

MapNodeKey createMapNodeKey({required String value}) {
  final normalizedValue = value.trim();
  if (normalizedValue.isEmpty) {
    throw ArgumentError.value(value, 'value', 'must not be blank');
  }

  return MapNodeKey._(normalizedValue);
}

MapNodeTypeId createMapNodeTypeId({required String value}) {
  final normalizedValue = value.trim();
  if (normalizedValue.isEmpty) {
    throw ArgumentError.value(value, 'value', 'must not be blank');
  }

  return MapNodeTypeId._(normalizedValue);
}
