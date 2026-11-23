import 'dart:typed_data';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_kyoshin_archive_window_resolver.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_kyoshin_archive_frame.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_kyoshin_archive_repository.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_kyoshin_archive_frame_loader.g.dart';

@Riverpod(keepAlive: true)
Future<ReplayKyoshinArchiveFrameLoader> replayKyoshinArchiveFrameLoader(
  Ref ref,
) async => ReplayKyoshinArchiveFrameLoader(
  repository: await ref.watch(replayKyoshinArchiveRepositoryProvider.future),
  windowResolver: ref.watch(replayKyoshinArchiveWindowResolverProvider),
);

class const ReplayKyoshinArchiveFrameLoader({
  required final ReplayKyoshinArchiveRepository repository,
  required final ReplayKyoshinArchiveWindowResolver windowResolver,
}) {
  /// [baselineTimes] のうち取得できた画像だけを平常値として返す。
  Future<ReplayKyoshinArchiveFrame> load({
    required KyoshinMonitorSource source,
    required DateTime observedAt,
    required List<DateTime> baselineTimes,
    required DateTime now,
  }) async {
    final result = await repository.fetchShindoImage(
      source: source,
      time: observedAt,
    );
    switch (result) {
      case Failure(:final exception, :final stackTrace):
        talker.warning(
          '[Replay] kmoni archive frame unavailable: $observedAt',
          exception,
          stackTrace,
        );
        return const ReplayKyoshinArchiveFrame.unavailable();
      case Success(value: null):
        return windowResolver.isExpired(frameTime: observedAt, now: now)
            ? const ReplayKyoshinArchiveFrame.purged()
            : const ReplayKyoshinArchiveFrame.unavailable();
      case Success(value: final image?):
        final baselineImages = <DateTime, Uint8List>{};
        for (final time in baselineTimes) {
          final baseline = await repository.fetchShindoImage(
            source: source,
            time: time,
          );
          if (baseline case Success(:final value?)) {
            baselineImages[time] = value;
          }
        }
        return ReplayKyoshinArchiveFrame.available(
          image: image,
          baselineImages: baselineImages,
        );
    }
  }
}
