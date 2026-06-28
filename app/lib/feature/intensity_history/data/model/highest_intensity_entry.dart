import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'highest_intensity_entry.freezed.dart';

/// [HighestIntensityItem] の app 用ラッパ。
///
/// Lv1(都道府県)・Lv2(市区町村)共通で使用する。
@freezed
abstract class HighestIntensityEntry with _$HighestIntensityEntry {
  const factory HighestIntensityEntry({
    /// 気象庁防災情報XMLフォーマットの地域コード。
    required String code,

    /// 地域名。
    required String name,

    /// 過去最高震度。
    required JmaIntensity intensity,

    /// 同震度を観測した地震の件数。
    required int count,

    /// 最高震度を観測した直近の地震イベント。
    required EarthquakePartial earthquake,
  }) = _HighestIntensityEntry;

  const HighestIntensityEntry._();

  /// [HighestIntensityItem] から変換する。
  factory HighestIntensityEntry.fromApi(HighestIntensityItem item) =>
      HighestIntensityEntry(
        code: item.code,
        name: item.name,
        intensity: item.intensity,
        count: item.count,
        earthquake: item.earthquake,
      );
}
