import 'package:eqapi_types/eqapi_types.dart';

extension EewV1Ex on EewV1 {
  bool get isLevelEew =>
      !(isPlum ?? false) && accuracy?.epicenters[0] == 1 && originTime == null;
  bool get isIpfOnePoint =>
      !(isPlum ?? false) && accuracy?.epicenters[0] == 1 && !isLevelEew;
}
