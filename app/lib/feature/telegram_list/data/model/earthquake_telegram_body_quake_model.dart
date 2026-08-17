import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_telegram_body_quake_model.freezed.dart';

/// 地震情報電文の震源要素ドメインモデル
@freezed
abstract class EarthquakeTelegramBodyQuakeModel
    with _$EarthquakeTelegramBodyQuakeModel {
  const factory({
    String? magnitude,
    num? depth,
    String? epicenterName,
    String? originTime,
    JmaIntensity? maxIntensity,
  }) = _EarthquakeTelegramBodyQuakeModel;
}

extension EarthquakeTelegramBodyQuakeApiExtension
    on api.EarthquakeTelegramBodyQuake {
  EarthquakeTelegramBodyQuakeModel toEarthquakeTelegramBodyQuakeModel() =>
      EarthquakeTelegramBodyQuakeModel(
        magnitude: magnitude,
        depth: depth,
        epicenterName: epicenterName,
        originTime: originTime,
        maxIntensity: maxIntensity?.toJmaIntensity,
      );
}
