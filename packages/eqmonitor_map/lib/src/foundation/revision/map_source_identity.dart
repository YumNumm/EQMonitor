extension type MapSourceInstanceId._(String value);

extension type MapContentDigest._(String value);

extension type MapSourceIdentity._(String value);

extension type MapSourceIncarnation._(String value);

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

MapSourceIdentity createMapSourceIdentity({required String value}) =>
    MapSourceIdentity._(_normalizeIdentityValue(value: value));

MapSourceIncarnation createMapSourceIncarnation({required String value}) =>
    MapSourceIncarnation._(_normalizeIdentityValue(value: value));

String _normalizeIdentityValue({required String value}) {
  final normalizedValue = value.trim();
  if (normalizedValue.isEmpty) {
    throw ArgumentError.value(value, 'value', 'must not be blank');
  }
  return normalizedValue;
}
