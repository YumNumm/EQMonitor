import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_telegram_body_intensity_region_model.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_telegram_body_quake_model.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_telegram_body_model.freezed.dart';

/// EARTHQUAKE 型電文（VXSE51〜53, VXSE61, VXSE62）本文のドメインモデル
@freezed
abstract class EarthquakeTelegramBodyModel with _$EarthquakeTelegramBodyModel {
  const factory EarthquakeTelegramBodyModel({
    EarthquakeTelegramBodyQuakeModel? quake,
    List<EarthquakeTelegramBodyIntensityRegionModel>? intensityRegions,
    List<EarthquakeTelegramBodyIntensityRegionModel>? intensityPrefectures,
    List<EarthquakeTelegramBodyIntensityRegionModel>? intensityCities,
  }) = _EarthquakeTelegramBodyModel;
}

extension TelegramBodyUnionEarthquakeTelegramBodyApiExtension
    on api.TelegramBodyUnionEarthquakeTelegramBody {
  EarthquakeTelegramBodyModel toEarthquakeTelegramBodyModel() =>
      EarthquakeTelegramBodyModel(
        quake: earthquake?.toEarthquakeTelegramBodyQuakeModel(),
        intensityRegions: intensityRegions
            ?.map((e) => e.toEarthquakeTelegramBodyIntensityRegionModel())
            .toList(),
        intensityPrefectures: intensityPrefectures
            ?.map((e) => e.toEarthquakeTelegramBodyIntensityRegionModel())
            .toList(),
        intensityCities: intensityCities
            ?.map((e) => e.toEarthquakeTelegramBodyIntensityRegionModel())
            .toList(),
      );
}
