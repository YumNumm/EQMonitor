import 'package:eqmonitor/feature/earthquake_replay/data/data_source/replay_file_storage_data_source.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_creation_range_resolver.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_file_encoder.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_file_path_resolver.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_creation_exception.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_creation_request.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_eew_frame_repository.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_image_frame_repository.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_creation_repository.g.dart';

@Riverpod(keepAlive: true)
Future<ReplayCreationRepository> replayCreationRepository(Ref ref) async =>
    ReplayCreationRepository(
      imageFrames: ref.watch(replayImageFrameRepositoryProvider),
      eewFrames: await ref.watch(replayEewFrameRepositoryProvider.future),
      storage: ref.watch(replayFileStorageDataSourceProvider),
      rangeResolver: ref.watch(replayCreationRangeResolverProvider),
      pathResolver: ref.watch(replayFilePathResolverProvider),
    );

class const ReplayCreationRepository({
  required final ReplayImageFrameRepository imageFrames,
  required final ReplayEewFrameRepository eewFrames,
  required final ReplayFileStorageDataSource storage,
  required final ReplayCreationRangeResolver rangeResolver,
  required final ReplayFilePathResolver pathResolver,
}) {
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
    // 名前の誤りは、画像の取得を始める前に知らせる。
    final name = fileName(request: request);
    final directory = this.directory(request: request);
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
    // 前置き区間の画像だけでは、選んだ期間のリプレイにならない。
    if (!images.any((image) => !image.time.isBefore(request.startTime))) {
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
    if (isCancelled()) {
      throw const ReplayCreationException(.cancelled);
    }
    return storage.save(directory: directory, name: name, bytes: bytes);
  }

  String fileName({required ReplayCreationRequest request}) =>
      request.name.trim().isEmpty
      ? pathResolver.defaultFileName(
          startTime: request.startTime,
          duration: request.duration,
        )
      : pathResolver.fileName(input: request.name);

  String directory({required ReplayCreationRequest request}) =>
      request.directory.trim().isEmpty
      ? pathResolver.defaultDirectory(startTime: request.startTime)
      : pathResolver.directory(input: request.directory);
}
