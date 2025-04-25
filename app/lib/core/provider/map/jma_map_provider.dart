import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_map/jma_map.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jma_map_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Map<JmaMapType, JmaMap_JmaMapData>> jmaMap(Ref ref) async {
  final bytes = await rootBundle.load(Assets.jmaMap);
  final jmaMap = JmaMap.fromBuffer(bytes.buffer.asUint8List());
  return {for (final element in jmaMap.data) element.mapType.mapType: element};
}

enum JmaMapType {
  areaForecastLocalEew,
  areaForecastLocalE,
  areaInformationCity,
  areaTsunami,
}

extension JmaMapEx on Map<JmaMapType, JmaMap_JmaMapData> {
  JmaMap_JmaMapData get areaForecastLocalEew =>
      this[JmaMapType.areaForecastLocalEew]!;
  JmaMap_JmaMapData get areaForecastLocalE =>
      this[JmaMapType.areaForecastLocalE]!;
  JmaMap_JmaMapData get areaInformationCity =>
      this[JmaMapType.areaInformationCity]!;
  JmaMap_JmaMapData get areaTsunami => this[JmaMapType.areaTsunami]!;
}

extension JmaMapTypeEx on JmaMap_JmaMapData_JmaMapType {
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
