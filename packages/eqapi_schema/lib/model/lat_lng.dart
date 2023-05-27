import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class LatLng extends Point<double> {
  const LatLng(this.lat, this.lon) : super(lat, lon);
  factory LatLng.fromJson(Map<String, dynamic> json) {
    return LatLng(
      (json['lat'] as num).toDouble(),
      (json['lon'] as num).toDouble(),
    );
  }

  final double lat;
  final double lon;

  @override
  String toString() {
    return 'LatLng(lat: $lat, lon: $lon)';
  }

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
      };
}
