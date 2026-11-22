import 'package:eqmonitor/feature/earthquake_replay/data/data_source/replay_file_storage_data_source.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_creation_range_resolver.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_file_encoder.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_creation_exception.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_creation_request.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_eew_frame_repository.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_image_frame_repository.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_creation_repository.g.dart';

@Riverpod(keepAlive: true)
Future<ReplayCreationRepository> replayCreationRepository(Ref ref) async =>
    ReplayCreationRepository(
      imageFrames: ref.watch(replayImageFrameRepositoryProvider),
      eewFrames: await ref.watch(replayEewFrameRepositoryProvider.future),
      storage: ref.watch(replayFileStorageDataSourceProvider),
      rangeResolver: ref.watch(replayCreationRangeResolverProvider),
    );

class const ReplayCreationRepository({
  required final ReplayImageFrameRepository imageFrames,
  required final ReplayEewFrameRepository eewFrames,
  required final ReplayFileStorageDataSource storage,
  required final ReplayCreationRangeResolver rangeResolver,
}) {
  static const _jstOffset = Duration(hours: 9);

  Future<List<SavedReplayFile>> list() => storage.list();

  Future<void> delete({required SavedReplayFile file}) =>
      storage.delete(file: file);

  Future<SavedReplayFile> create({
    required ReplayCreationRequest request,
    required KyoshinMonitorSource source,
    required void Function(ReplayCreationProgress progress) onProgress,
    required bool Function() isCancelled,
  }) async {
    if (request.imageKinds.isEmpty) {
      throw const ReplayCreationException(.noImageKind);
    }
    if (!rangeResolver.isSelectable(request: request)) {
      throw const ReplayCreationException(.outOfRange);
    }
    final times = rangeResolver.frameTimes(request: request);
    // EEW の取得は画像より短く済むため先に行い、失敗時に画像の取得を無駄にしない。
    final eew = request.includeEew
        ? await eewFrames.fetch(
            startTime: times.first,
            endTime: request.endTime,
          )
        : const <Never>[];
    onProgress(ReplayCreationProgress(completed: 0, total: times.length));
    final images = await imageFrames.fetch(
      source: source,
      kinds: request.imageKinds,
      times: times,
      onProgress: (completed) => onProgress(
        ReplayCreationProgress(completed: completed, total: times.length),
      ),
      isCancelled: isCancelled,
    );
    if (images.isEmpty) {
      throw const ReplayCreationException(.noFrames);
    }
    if (isCancelled()) {
      throw const ReplayCreationException(.cancelled);
    }
    final bytes = await compute(const ReplayFileEncoder().encode, (
      startTime: request.startTime,
      endTime: request.endTime,
      frames: [...images, ...eew],
    ));
    return storage.save(
      name: fileName(request: request),
      bytes: bytes,
    );
  }

  String fileName({required ReplayCreationRequest request}) {
    final start = DateFormat(
      'yyyyMMdd_HHmmss',
    ).format(request.startTime.toUtc().add(_jstOffset));
    return 'eqmonitor_${start}_${request.duration.inSeconds}s'
        '${ReplayFileStorageDataSource.extension}';
  }
}
