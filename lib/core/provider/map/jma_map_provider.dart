import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/services.dart';
import 'package:jma_map/jma_map.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jma_map_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Map<JmaMapType, List<JmaMap_JmaMapData_JmaMapDataItem>>> jmaMap(
  JmaMapRef ref,
) async {
  final bytes = await rootBundle.load(Assets.jmaMap);
  final jmaMap = JmaMap.fromBuffer(
    bytes.buffer.asUint8List(),
  );
  return {
    for (final element in jmaMap.data) element.mapType.mapType: element.data,
  };
}

enum JmaMapType {
  areaForecastLocalEew,
  areaForecastLocalE,
  areaInformationCity,
  areaTsunami,
  ;
}

extension JmaMapEx on JmaMap_JmaMapData_JmaMapType {
  JmaMapType get mapType => switch (this) {
        JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_E =>
          JmaMapType.areaForecastLocalE,
        JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_EEW =>
          JmaMapType.areaForecastLocalEew,
        JmaMap_JmaMapData_JmaMapType.AREA_INFORMATION_CITY =>
          JmaMapType.areaInformationCity,
        JmaMap_JmaMapData_JmaMapType.AREA_TSUNAMI => JmaMapType.areaTsunami,
        _ => throw UnimplementedError(),
      };
}
