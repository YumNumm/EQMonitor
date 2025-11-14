import 'package:freezed_annotation/freezed_annotation.dart';

part 'lat_lng.freezed.dart';
part 'lat_lng.g.dart';

@freezed
abstract class LatLng with _$LatLng {
  const factory LatLng({
    required double latitude,
    required double longitude,
  }) = _LatLng;

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
}
