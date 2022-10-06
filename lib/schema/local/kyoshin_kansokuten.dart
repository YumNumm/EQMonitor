import 'package:flutter/cupertino.dart';

/// 観測点の位置を表すクラス
@immutable
class KyoshinKansokuten {
  const KyoshinKansokuten({
    required this.code,
    required this.name,
    required this.pref,
    required this.lat,
    required this.lon,
    required this.x,
    required this.y,
    required this.arv,
  });

  KyoshinKansokuten.fromList(List<dynamic> lis)
      : code = lis[0].toString(),
        pref = lis[1].toString(),
        name = lis[2].toString(),
        lat = double.parse(lis[3].toString()),
        lon = double.parse(lis[4].toString()),
        x = int.parse(lis[5].toString()),
        y = int.parse(lis[6].toString()),
        arv = double.parse(lis[7].toString());

  final String code;
  final String name;
  final String pref;
  final double lat;
  final double lon;
  final int x;
  final int y;

  /// 工学的基盤（Vs=400m/s）から地表に至る最大速度の増幅率
  /// ref: https://www.j-shis.bosai.go.jp/api-sstruct-meshinfo
  final double arv;
}
