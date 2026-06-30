import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'prefecture_intensity_page.freezed.dart';

/// 都道府県の過去地震一覧ページ。
@freezed
abstract class PrefectureIntensityPage with _$PrefectureIntensityPage {
  const factory PrefectureIntensityPage({
    required List<IntensityAreaSearchItem> items,
    required String? nextToken,
  }) = _PrefectureIntensityPage;
}
