import 'package:eqmonitor/utils/KyoshinMonitorlib/UrlGenerator/RealTimeDataType.dart';

import '../utils.dart';

/// ## 新強震モニタのURL生成器
class WebApiUrlGenerator {
  /// JsonEewのUrl
  String JsonEewBase(DateTime dt) =>
      'http://www.kmoni.bosai.go.jp/webservice/hypo/eew/${ymdhms.format(dt)}.json';

  /// PsWaveImgのURL
  String PsWaveBase(DateTime dt) =>
      'http://www.kmoni.bosai.go.jp/data/map_img/PSWaveImg/eew/${ymd.format(dt)}/${ymdhms.format(dt)}';

  /// RealtimeImgのURL
  String RealtimeBase(
          {required DateTime dt,
          required RealtimeDataType type,

          /// 地上(`s`)か地下(`b`)
          required String sorb}) =>
      'http://www.kmoni.bosai.go.jp/data/map_img/RealTimeImg/${type.ToUrlString}_$sorb/${ymd.format(dt)}/${ymdhms.format(dt)}.${type.ToUrlString}_$sorb.gif';

  /// 予想震度のURL
  String EstShindoBase(DateTime dt) =>
      'http://www.kmoni.bosai.go.jp/data/map_img/EstShindoImg/eew/${ymd.format(dt)}/${ymdhms.format(dt)}.eew.gif';
}
