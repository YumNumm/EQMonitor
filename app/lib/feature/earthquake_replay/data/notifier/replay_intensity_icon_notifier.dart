import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_intensity_icon_notifier.g.dart';

// 波形から求めたリアルタイム震度を、観測点の丸ではなく震度アイコンで描くか。リプレイの間だけ使い、保存しない。
@Riverpod(keepAlive: true)
class ReplayIntensityIcon extends _$ReplayIntensityIcon {
  @override
  bool build() => false;

  void set({required bool enabled}) => state = enabled;
}
