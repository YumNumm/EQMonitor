extension type MapSourceInstanceId._(String value);

extension type MapContentDigest._(String value);

MapSourceInstanceId createMapSourceInstanceId({required String value}) {
  final normalizedValue = value.trim();
  if (normalizedValue.isEmpty) {
    throw ArgumentError.value(value, 'value', 'must not be blank');
  }

  return MapSourceInstanceId._(normalizedValue);
}

MapContentDigest createMapContentDigest({required String value}) {
  final normalizedValue = value.trim();
  if (normalizedValue.isEmpty) {
    throw ArgumentError.value(value, 'value', 'must not be blank');
  }

  return MapContentDigest._(normalizedValue);
}
