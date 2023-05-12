import 'package:eqapi_schema/model/telegram_v3.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_intensity.freezed.dart';
part 'eew_intensity.g.dart';

@freezed
class ForecastMaxInt with _$ForecastMaxInt {
  const factory ForecastMaxInt({
    required JmaForecastIntensity from,
    required JmaForecastIntensityOver to,
  }) = _ForecastMaxInt;

  factory ForecastMaxInt.fromJson(Map<String, dynamic> json) =>
      _$ForecastMaxIntFromJson(json);
}

@freezed
class ForecastMaxLgInt with _$ForecastMaxLgInt {
  const factory ForecastMaxLgInt({
    required JmaForecastLgIntensity from,
    required JmaForecastLgIntensityOver to,
  }) = _ForecastMaxLgInt;

  factory ForecastMaxLgInt.fromJson(Map<String, dynamic> json) =>
      _$ForecastMaxLgIntFromJson(json);
}

extension ForecastMaxIntDisplay on ForecastMaxInt {
  // 表示する最大震度
  (JmaForecastIntensity maxInt, bool isOver) toDisplayMaxInt() {
    if (to == JmaForecastIntensityOver.over) {
      return (from, true);
    } else {
      return (to.toJmaForecastIntensity, false);
    }
  }
}

extension ForecastMaxLgIntDisplay on ForecastMaxLgInt {
  /// 表示する最大震度
  /// 推定最大長周期地震動階級0の場合、nullを返す
  /// 0以上の場合、推定最大長周期地震動階級を返す
  (JmaForecastLgIntensity? maxInt, bool isOver) toDisplayMaxLgInt() {
    if (to == JmaForecastLgIntensityOver.over) {
      return (from, true);
    }
    if (to == JmaForecastLgIntensityOver.zero) {
      return (null, false);
    }
    return (to.toJmaForecastLgIntensity, false);
  }
}
