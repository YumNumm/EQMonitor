import '../../const/kmoni/real_time_data_type.dart';
import 'date_format.dart';

/// ## 新強震モニタのURL生成器
class KyoshinWebApiUrlGenerator {
  /// JsonEewのUrl
  String jsonEewBase(DateTime dt) =>
      'http://www.kmoni.bosai.go.jp/webservice/hypo/eew/${ymdhms.format(dt)}.json';

  /// PsWaveImgのURL
  String psWaveBase(DateTime dt) =>
      'http://www.kmoni.bosai.go.jp/data/map_img/PSWaveImg/eew/${ymd.format(dt)}/${ymdhms.format(dt)}';

  /// RealtimeImgのURL
  String realtimeBase({
    required DateTime dt,
    required RealtimeDataType type,

    /// 地上(`s`)か地下(`b`)
    required String sorb,
  }) =>
      'http://www.kmoni.bosai.go.jp/data/map_img/RealTimeImg/${type.urlString}_$sorb/${ymd.format(dt)}/${ymdhms.format(dt)}.${type.urlString}_$sorb.gif';

  /// 予想震度のURL
  String estShindoBase(DateTime dt) =>
      'http://www.kmoni.bosai.go.jp/data/map_img/EstShindoImg/eew/${ymd.format(dt)}/${ymdhms.format(dt)}.eew.gif';
}
