import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_creation_exception.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_creation_request.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/repository/kyoshin_monitor_repository.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_image_frame_repository.g.dart';

@Riverpod(keepAlive: true)
ReplayImageFrameRepository replayImageFrameRepository(Ref ref) =>
    ReplayImageFrameRepository(
      kyoshinMonitor: ref.watch(kyoshinMonitorRepositoryProvider),
    );

class const ReplayImageFrameRepository({
  required final KyoshinMonitorRepository kyoshinMonitor,
}) {
  static const concurrency = 4;
  static const maxAttempts = 3;

  Future<List<KyoshinMonitorImageReplayData>> fetch({
    required KyoshinMonitorSource source,
    required Set<ReplayCreationImageKind> kinds,
    required List<DateTime> times,
    required void Function(int completed) onProgress,
    required bool Function() isCancelled,
  }) async {
    final frames = List<KyoshinMonitorImageReplayData?>.filled(
      times.length,
      null,
    );
    var next = 0;
    var completed = 0;
    // 1つの取得が失敗したら、残りの取得を続けずに止める。
    var isAborted = false;
    await Future.wait([
      for (var worker = 0; worker < concurrency; worker++)
        Future(() async {
          while (next < times.length && !isAborted) {
            if (isCancelled()) {
              throw const ReplayCreationException(.cancelled);
            }
            final index = next++;
            try {
              frames[index] = await fetchFrame(
                source: source,
                kinds: kinds,
                time: times[index],
              );
            } on ReplayCreationException {
              isAborted = true;
              rethrow;
            }
            onProgress(++completed);
          }
        }),
    ]);
    return frames.nonNulls.toList();
  }

  Future<KyoshinMonitorImageReplayData?> fetchFrame({
    required KyoshinMonitorSource source,
    required Set<ReplayCreationImageKind> kinds,
    required DateTime time,
  }) async {
    final images = <ImageType, List<int>>{};
    for (final kind in kinds) {
      final image = await fetchImage(source: source, kind: kind, time: time);
      if (image != null) {
        images[kind.imageType] = image;
      }
    }
    return images.isEmpty
        ? null
        : KyoshinMonitorImageReplayData(
            type: .kyoshinMonitorImage,
            time: time,
            images: images,
          );
  }

  Future<Uint8List?> fetchImage({
    required KyoshinMonitorSource source,
    required ReplayCreationImageKind kind,
    required DateTime time,
  }) async {
    for (var attempt = 1; ; attempt++) {
      try {
        final bytes = await kyoshinMonitor.fetchRealtimeImage(
          source: source,
          type: kind.dataType,
          layer: RealtimeLayer.surface,
          dateTime: time,
        );
        return Uint8List.fromList(bytes);
      } on DioException catch (error, stackTrace) {
        if (error.response?.statusCode == 404) {
          return null;
        }
        if (attempt >= maxAttempts) {
          talker.error(
            '[ReplayCreation] image fetch failed: ${kind.name} $time',
            error,
            stackTrace,
          );
          throw const ReplayCreationException(.imageFetchFailed);
        }
      }
    }
  }
}
