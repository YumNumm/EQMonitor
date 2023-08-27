import 'dart:math';

import 'package:latlong2/latlong.dart' as lat_long2;

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

extension LatLngEx on LatLng {
  /// 2点間の距離をメートルで返す
  /// [other] 距離を測る対象の座標
  double distanceTo(LatLng other) {
    const distance = lat_long2.Distance();
    return distance.as(
      lat_long2.LengthUnit.Meter,
      lat_long2.LatLng(lat, lon),
      lat_long2.LatLng(other.lat, other.lon),
    );
  }
}
