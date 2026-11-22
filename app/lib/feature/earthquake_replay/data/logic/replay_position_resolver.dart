import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_position_resolver.g.dart';

@riverpod
ReplayPositionResolver replayPositionResolver(Ref ref) =>
    const ReplayPositionResolver();

typedef ReplayAnchor = ({Duration wallTime, DateTime replayTime});

class const ReplayPositionResolver() {
  DateTime projected({
    required ReplayState state,
    required ReplayAnchor? anchor,
    required Duration wallTime,
  }) {
    if (!state.isPlaying || anchor == null) {
      return state.currentTime;
    }
    return anchor.replayTime.add(
      (wallTime - anchor.wallTime) * state.playbackSpeed,
    );
  }

  /// 一時停止・速度変更の基準位置。画像解析が長引いている間も時計は進んでいるため、
  /// 次の進行時刻では止めず、経過済みのフレームは呼び出し側でまとめて適用する。
  DateTime current({
    required ReplayState state,
    required ReplayAnchor? anchor,
    required Duration wallTime,
  }) {
    final position = state.clampTime(
      projected(state: state, anchor: anchor, wallTime: wallTime),
    );
    return position.isBefore(state.currentTime) ? state.currentTime : position;
  }

  /// 処理が遅れて予定時刻を過ぎた場合は、途中のフレームを飛ばして時計の位置へ追いつく。
  DateTime tickTarget({
    required ReplayState state,
    required ReplayAnchor? anchor,
    required Duration wallTime,
    required DateTime scheduled,
  }) {
    final position = projected(
      state: state,
      anchor: anchor,
      wallTime: wallTime,
    );
    return state.clampTime(position.isAfter(scheduled) ? position : scheduled);
  }
}
