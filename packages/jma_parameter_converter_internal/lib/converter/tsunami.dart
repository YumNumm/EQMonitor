import 'package:jma_parameter_types/tsunami_param.pb.dart';

import '../dmdata/tsunami.dart' as dmdata;

TsunamiParameter fromDmdataTsunamiParameter(dmdata.TsunamiParameter parameter) {
  return TsunamiParameter(
    items: parameter.items.map(
      (e) => TsunamiParameterItem(
        prefecture: e.prefecture,
        code: e.code,
        latitude: e.latitude,
        longitude: e.longitude,
      ),
    ),
  );
}
