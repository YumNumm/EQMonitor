import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_history_state.freezed.dart';

/// 地域別最大震度マップのフォーカス状態。
///
/// - [IntensityHistoryStatePrefecture]: Lv1 全都道府県表示。
/// - [IntensityHistoryStateCity]: Lv2 特定都道府県にフォーカス中。
@freezed
sealed class IntensityHistoryState with _$IntensityHistoryState {
  /// Lv1: 全都道府県表示状態。
  const factory IntensityHistoryState.prefecture() =
      IntensityHistoryStatePrefecture;

  /// Lv2: 特定都道府県にフォーカス中の状態。
  const factory IntensityHistoryState.city({
    required String prefectureCode,
    required String prefectureName,
    String? selectedCityCode,
    String? selectedCityName,
  }) = IntensityHistoryStateCity;
}
