import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_intensity_page.freezed.dart';

/// 市区町村の過去地震一覧ページ。
@freezed
abstract class CityIntensityPage with _$CityIntensityPage {
  const factory({
    required List<IntensityAreaSearchItem> items,
    required String? nextToken,
  }) = _CityIntensityPage;
}
