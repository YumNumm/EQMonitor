import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_history_controller.g.dart';

/// 市区町村別最大震度マップの選択状態を管理する Notifier。
///
/// 初期状態は未選択。[selectCity] / [deselectCity] で選択中の市区町村だけを
/// 出し入れする。
@riverpod
class IntensityHistoryController extends _$IntensityHistoryController {
  @override
  IntensityHistoryState build() => const IntensityHistoryState();

  /// 市区町村を選択する。
  void selectCity({
    required String code,
    required String name,
    required String prefectureName,
  }) {
    state = IntensityHistoryState(
      selectedCity: IntensityHistorySelectedCity(
        code: code,
        name: name,
        prefectureName: prefectureName,
      ),
    );
  }

  /// 市区町村の選択を解除する。
  void deselectCity() {
    if (state.selectedCity == null) {
      return;
    }
    state = const IntensityHistoryState();
  }
}
