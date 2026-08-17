import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_daily_bin.freezed.dart';

/// 1日ごとの発生件数と積算件数。
@freezed
abstract class SeismicityDailyBin with _$SeismicityDailyBin {
  const factory({
    /// UTC 日付(00:00 に正規化)
    required DateTime date,
    required int count,
    required int cumulativeCount,
  }) = _SeismicityDailyBin;
}
