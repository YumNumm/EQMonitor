import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_node_identity.freezed.dart';

extension type MapNodeKey._(String value);

extension type MapNodeTypeId._(String value);

@freezed
abstract class MapNodeIdentity with _$MapNodeIdentity {
  const factory _({
    required MapNodeKey key,
    required MapNodeTypeId type,
  }) = _MapNodeIdentity;
}

enum MapNodeIdentityChange { retained, replaced }

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

MapNodeIdentity createMapNodeIdentity({
  required MapNodeKey key,
  required MapNodeTypeId type,
}) => MapNodeIdentity._(key: key, type: type);

MapNodeIdentityChange classifyMapNodeIdentity({
  required MapNodeIdentity current,
  required MapNodeIdentity next,
}) => switch (current == next) {
  true => MapNodeIdentityChange.retained,
  false => MapNodeIdentityChange.replaced,
};
