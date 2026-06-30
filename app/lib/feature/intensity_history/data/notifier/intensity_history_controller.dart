import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_history_controller.g.dart';

/// 地域別最大震度マップのフォーカス状態を管理する Notifier。
///
/// - 初期状態は [IntensityHistoryStatePrefecture]（Lv1 全都道府県表示）。
/// - [focusPrefecture] で [IntensityHistoryStateCity]（Lv2）に遷移。
/// - [backToPrefecture] で Lv1 に戻る。
@riverpod
class IntensityHistoryController extends _$IntensityHistoryController {
  @override
  IntensityHistoryState build() => const IntensityHistoryState.prefecture();

  /// 指定都道府県にフォーカスする（Lv2 に遷移）。
  void focusPrefecture({
    required String code,
    required String name,
    String? selectedCityCode,
    String? selectedCityName,
  }) {
    state = IntensityHistoryState.city(
      prefectureCode: code,
      prefectureName: name,
      selectedCityCode: selectedCityCode,
      selectedCityName: selectedCityName,
    );
  }

  /// フォーカス中の都道府県内で市区町村を選択する。
  void selectCity({required String code, required String name}) {
    final current = state;
    if (current is! IntensityHistoryStateCity) {
      return;
    }
    state = current.copyWith(
      selectedCityCode: code,
      selectedCityName: name,
    );
  }

  /// 市区町村の選択だけを解除する。
  void deselectCity() {
    final current = state;
    if (current is! IntensityHistoryStateCity) {
      return;
    }
    state = current.copyWith(
      selectedCityCode: null,
      selectedCityName: null,
    );
  }

  /// 全都道府県表示に戻る（Lv1 に遷移）。
  void backToPrefecture() {
    state = const IntensityHistoryState.prefecture();
  }
}
