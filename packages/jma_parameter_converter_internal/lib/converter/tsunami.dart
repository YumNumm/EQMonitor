import 'package:jma_parameter_converter_internal/dmdata/tsunami.dart' as dmdata;
import 'package:jma_parameter_types/tsunami_param.pb.dart';

TsunamiParameter fromDmdataTsunamiParameter(dmdata.TsunamiParameter parameter) {
  return TsunamiParameter(
    header: TsunamiParameterHeader(
      version: parameter.version,
      changeTime: parameter.changeTime.toIso8601String(),
    ),
    items: parameter.items.map(
      (e) => TsunamiParameterItem(
        area: e.area ?? '',
        prefecture: e.prefecture,
        code: e.code,
        name: e.name,
        nameKana: e.kana,
        owner: e.owner,
        latitude: e.latitude,
        longitude: e.longitude,
      ),
    ),
  );
}
