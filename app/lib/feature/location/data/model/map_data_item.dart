import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_data_item.freezed.dart';

@freezed
abstract class MapDataLatLng with _$MapDataLatLng {
  const factory({
    required double lat,
    required double lng,
  }) = _MapDataLatLng;
}

@freezed
abstract class MapDataBounds with _$MapDataBounds {
  const factory({
    required MapDataLatLng southWest,
    required MapDataLatLng northEast,
  }) = _MapDataBounds;
}

@freezed
abstract class MapDataProperty with _$MapDataProperty {
  const factory({
    required String code,
    required String name,
    required String nameKana,
  }) = _MapDataProperty;
}

/// JMAマップデータの検索結果。
/// protobufの任意フィールドに合わせ、各フィールドはnullableとする。
/// 津波予報区の場合のみ [distanceToCoastlineKm] が設定される。
@freezed
abstract class MapDataItem with _$MapDataItem {
  const factory({
    MapDataBounds? bounds,
    MapDataProperty? property,
    MapDataLatLng? polylabel,

    /// 現在地から該当海岸線までの最短距離（km）。津波予報区のみ設定される。
    double? distanceToCoastlineKm,
  }) = _MapDataItem;
}
