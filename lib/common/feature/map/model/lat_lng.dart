import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class LatLng {
  const LatLng(this.lat, this.lon);

  final double lat;
  final double lon;

  @override
  String toString() {
    return 'LatLng(lat: $lat, lon: $lon)';
  }
}
