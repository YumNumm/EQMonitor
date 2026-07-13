import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:flutter/services.dart';
import 'package:jma_map/jma_map.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jma_map_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Map<JmaMapType, JmaMap_JmaMapData>> jmaMap(Ref ref) async {
  final bytes = await rootBundle.load(Assets.jmaMap);
  final jmaMap = JmaMap.fromBuffer(bytes.buffer.asUint8List());
  final result = <JmaMapType, JmaMap_JmaMapData>{};
  for (final element in jmaMap.data) {
    try {
      result[element.mapType.mapType] = element;
    } on UnimplementedError {
      // 未知の JmaMapType はスキップし、既知typeのデータのみで縮退させる。
      talker.warning(
        'jmaMapProvider: 未知の JmaMapType (${element.mapType}) をスキップしました',
      );
    }
  }
  return result;
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
