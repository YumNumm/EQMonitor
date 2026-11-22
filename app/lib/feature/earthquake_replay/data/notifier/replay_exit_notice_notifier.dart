import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_exit_notice.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_exit_notice_notifier.g.dart';

@Riverpod(keepAlive: true)
class ReplayExitNoticeNotifier extends _$ReplayExitNoticeNotifier {
  @override
  ReplayExitNotice? build() => null;

  void show(ReplayExitNotice notice) => state = notice;

  void clear() => state = null;

  // 表示されずに残った通知と同じ理由で、もう一度終了した場合にも通知する。
  @override
  bool updateShouldNotify(ReplayExitNotice? previous, ReplayExitNotice? next) =>
      true;
}
