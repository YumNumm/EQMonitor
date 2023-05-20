import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class LatLng extends Point<double> {
  const LatLng(this.lat, this.lon) : super(lat, lon);

  final double lat;
  final double lon;

  @override
  String toString() {
    return 'LatLng(lat: $lat, lon: $lon)';
  }
}
