import 'package:intl/intl.dart';
// TODO: Lpgm
/// 長周期地震動モニタのURL生成器
class LpgmWebApiUtlGenerator {
  final DateFormat _ymdhms = DateFormat('yyyyMMddhhmmss');
  final DateFormat _ymd = DateFormat('yyyyMMdd');

  /// JsonEewのベースUrl
  /// `https://www.lmoni.bosai.go.jp/monitor/webservice/hypo/eew/20220316220603.json`
  String JsonEewBase(DateTime dt) =>
      'https://www.lmoni.bosai.go.jp/monitor/webservice/hypo/eew/${_ymdhms.format(dt)}';

  /// PsWaveImgのベースUrl
  /// `https://www.lmoni.bosai.go.jp/monitor/data/data/map_img/PSWaveImg/eew/20220316/20220316220939.eew.gif`
  String PsWaveBase(DateTime dt) =>
      'https://www.lmoni.bosai.go.jp/monitor/data/data/map_img/PSWaveImg/eew/${_ymd.format(dt)}/${_ymdhms.format(dt)}.eew.gif';

  /// 予想震度のベースURL
  /// `https://smi.lmoniexp.bosai.go.jp/data/map_img/EstShindoImg/eew/20220316/20220316220939.eew.gif`
  String RealtimeBase(DateTime dt) =>
      'https://smi.lmoniexp.bosai.go.jp/data/map_img/EstShindoImg/eew/${_ymd.format(dt)}/${_ymdhms.format(dt)}.eew.gif';

}
