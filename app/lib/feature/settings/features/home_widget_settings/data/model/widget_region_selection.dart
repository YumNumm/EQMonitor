import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'widget_region_selection.freezed.dart';
part 'widget_region_selection.g.dart';

/// ホーム画面ウィジェットの「任意地域」表示に使う地域選択。
///
/// `searchType` が [RegionSearchType.prefecture] なら [code] は都道府県コード、
/// [RegionSearchType.city] なら市区町村コード。
@freezed
abstract class WidgetRegionSelection with _$WidgetRegionSelection {
  const factory WidgetRegionSelection({
    required RegionSearchType searchType,
    required String code,
    required String name,
  }) = _WidgetRegionSelection;

  factory WidgetRegionSelection.fromJson(Map<String, dynamic> json) =>
      _$WidgetRegionSelectionFromJson(json);
}
