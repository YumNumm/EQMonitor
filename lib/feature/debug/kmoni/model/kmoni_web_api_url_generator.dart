// ignore_for_file: avoid_classes_with_only_static_members

import 'package:eqmonitor/feature/debug/kmoni/model/realtime_data_type.dart';
import 'package:intl/intl.dart';

final DateFormat _ymdhms = DateFormat('yyyyMMddHHmmss');
final DateFormat _ymd = DateFormat('yyyyMMdd');

/// ## 新強震モニタのURL生成器
class KmoniWebApiUrlGenerator {
  KmoniWebApiUrlGenerator();

  /// JsonEewのUrl
  String jsonEewBase(DateTime dateTime) =>
      'http://www.kmoni.bosai.go.jp/webservice/hypo/eew/${_ymdhms.format(dateTime)}.json';

  /// PsWaveImgのURL
  String psWaveBase(DateTime dateTime) =>
      'http://www.kmoni.bosai.go.jp/data/map_img/PSWaveImg/eew/${_ymd.format(dateTime)}/${_ymdhms.format(dateTime)}';

  /// RealtimeImgのURL
  String realtimeBase({
    required DateTime dateTime,
    required RealtimeDataType dataType,

    /// 地上(`s`)か地下(`b`)
    required GroundType groundType,
  }) =>
      'http://www.kmoni.bosai.go.jp/data/map_img/RealTimeImg/${dataType.url}_${groundType.label}/${_ymd.format(dateTime)}/${_ymdhms.format(dateTime)}.${dataType.url}_${groundType.label}.gif';

  /// 予想震度のURL
  String estShindoBase(DateTime dateTime) =>
      'http://www.kmoni.bosai.go.jp/data/map_img/EstShindoImg/eew/${_ymd.format(dateTime)}/${_ymdhms.format(dateTime)}.eew.gif';
}

enum GroundType {
  aboveGround('s'),
  underGround('b');

  const GroundType(this.label);
  final String label;
}
