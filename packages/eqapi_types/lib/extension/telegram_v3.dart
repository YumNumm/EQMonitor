import 'package:eqapi_types/eqapi_types.dart';

extension Vxse45BodyExtension on TelegramVxse45Body {
  bool get isLevelEew =>
      !isPlum && accuracy.epicenters[0] == '1' && originTime == null;
  bool get isIpfOnePoint =>
      !isPlum && accuracy.epicenters[0] == '1' && !isLevelEew;
}
