import 'package:flutter/cupertino.dart';

/// 観測点の位置を表すクラス
@immutable
class ObsPoint {
  const ObsPoint({
    required this.code,
    required this.name,
    required this.pref,
    required this.lat,
    required this.lon,
    required this.x,
    required this.y,
  });

  ObsPoint.fromList(List<String> lis)
      : code = lis[1],
        name = lis[3],
        pref = lis[4],
        lat = double.parse(lis[5]),
        lon = double.parse(lis[6]),
        x = int.parse(lis[7]),
        y = int.parse(lis[8]);

  final String code;
  final String name;
  final String pref;
  final double lat;
  final double lon;
  final int x;
  final int y;
}
