import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_depth.freezed.dart';
part 'earthquake_depth.g.dart';

@freezed
sealed class EarthquakeDepth with _$EarthquakeDepth {
  /// ごく浅い
  const factory EarthquakeDepth.shallow() = EarthquakeDepthShallow;

  /// 10~700km
  const factory EarthquakeDepth.value({
    required int value,
  }) = EarthquakeDepthValue;

  /// 700km以上
  const factory EarthquakeDepth.over700km() = EarthquakeDepthOver700km;

  /// 不明
  const factory EarthquakeDepth.unknown() = EarthquakeDepthUnknown;

  factory EarthquakeDepth.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeDepthFromJson(json);
}

extension EarthquakeDepthApiExtension on api.Depth {
  EarthquakeDepth get toEarthquakeDepth => switch (type) {
    .shallow => const .shallow(),
    .normal => .value(
      value:
          value?.toInt() ??
          (throw CheckedFromJsonException(
            toJson(),
            'value',
            'EarthquakeDepth',
            'value',
          )),
    ),
    .over700 => const .over700km(),
    .unknown => const .unknown(),
  };
}
