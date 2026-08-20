import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_history_state.freezed.dart';

/// 市区町村別最大震度マップの選択状態。
///
/// 全国どのズームでも市区町村単位で塗り分けるため、都道府県フォーカス
/// (旧 Lv1/Lv2 のドリルダウン) は持たない。画面が覚えておく必要があるのは
/// 「いま輪郭線を引いている市区町村」だけ。
@freezed
abstract class IntensityHistoryState with _$IntensityHistoryState {
  const factory({
    /// 選択中の市区町村。未選択なら `null`。
    IntensityHistorySelectedCity? selectedCity,
  }) = _IntensityHistoryState;
}

/// 選択中の市区町村。
@freezed
abstract class IntensityHistorySelectedCity
    with _$IntensityHistorySelectedCity {
  const factory({
    /// 気象庁防災情報XMLフォーマットの市区町村コード(7桁)。
    required String code,
    required String name,

    /// 所属都道府県名。パネル・モーダルの親ラベルに使う。
    required String prefectureName,
  }) = _IntensityHistorySelectedCity;
}
