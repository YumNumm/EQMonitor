import 'package:eqapi_schema/model/telegram_v3.dart';

extension Vxse45BodyExtension on TelegramVxse45Body {
  bool get isLevelEew => accuracy.epicenters[0] == '1' && originTime == null;
  bool get isIpfOnePoint => accuracy.epicenters[0] == '1' && !isLevelEew;
}
