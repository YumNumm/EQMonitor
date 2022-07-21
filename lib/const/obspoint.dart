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

  ObsPoint.fromList(List<dynamic> lis)
      : code = lis[1].toString(),
        name = lis[3].toString(),
        pref = lis[4].toString(),
        lat = double.parse(lis[5].toString()),
        lon = double.parse(lis[6].toString()),
        x = int.parse(lis[7].toString()),
        y = int.parse(lis[8].toString());

  final String code;
  final String name;
  final String pref;
  final double lat;
  final double lon;
  final int x;
  final int y;
}
