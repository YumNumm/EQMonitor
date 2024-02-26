import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

part 'main_map_viewmodel_state.freezed.dart';
part 'main_map_viewmodel_state.g.dart';

@freezed
class MainMapViewmodelState with _$MainMapViewmodelState {
  const factory MainMapViewmodelState({
    required bool isHomePosition,
    @JsonKey(fromJson: _latLngBoundsFromJson, toJson: _latLngBoundsToJson)
    required LatLngBounds homeBoundary,
  }) = _MainMapViewmodelState;

  factory MainMapViewmodelState.fromJson(Map<String, dynamic> json) =>
      _$MainMapViewmodelStateFromJson(json);
}

LatLngBounds _latLngBoundsFromJson(Map<String, dynamic> json) {
  final southwest = json['southwest'] as List;
  final northeast = json['northeast'] as List;

  return LatLngBounds(
    southwest: LatLng(southwest[0] as double, southwest[1] as double),
    northeast: LatLng(northeast[0] as double, northeast[1] as double),
  );
}

Map<String, dynamic> _latLngBoundsToJson(LatLngBounds instance) =>
    <String, dynamic>{
      'southwest': [instance.southwest.latitude, instance.southwest.longitude],
      'northeast': [instance.northeast.latitude, instance.northeast.longitude],
    };
