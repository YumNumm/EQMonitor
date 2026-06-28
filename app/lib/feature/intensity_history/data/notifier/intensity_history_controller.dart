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
  void focusPrefecture({required String code, required String name}) {
    state = IntensityHistoryState.city(
      prefectureCode: code,
      prefectureName: name,
    );
  }

  /// 全都道府県表示に戻る（Lv1 に遷移）。
  void backToPrefecture() {
    state = const IntensityHistoryState.prefecture();
  }
}
