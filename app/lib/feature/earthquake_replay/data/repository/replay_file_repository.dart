import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/data_source/replay_file_data_source.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_file_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_file_repository.g.dart';

@Riverpod(keepAlive: true)
ReplayFileRepository replayFileRepository(Ref ref) =>
    ReplayFileRepository(dataSource: ref.watch(replayFileDataSourceProvider));

typedef LoadedReplayFile = ({ReplayFile file, String name});
typedef LoadedReplayDocument = ({
  ReplayFile file,
  String name,
  Uint8List bytes,
});

class const ReplayFileRepository({
  required final ReplayFileDataSource dataSource,
}) {
  Future<Uri?> pick() => dataSource.pick();

  Future<void> clearPickedFiles() => dataSource.clearPickedFiles();

  Future<LoadedReplayFile> load({required Uri source}) async {
    final document = await loadDocument(source: source);
    return (file: document.file, name: document.name);
  }

  Future<LoadedReplayDocument> loadDocument({required Uri source}) async {
    final document = await dataSource.read(source: source);
    final file = await parse(bytes: document.bytes, name: document.name);
    return (file: file, name: document.name, bytes: document.bytes);
  }

  Future<ReplayFile> parse({
    required Uint8List bytes,
    required String name,
  }) async {
    final parser = ReplayDataParser();
    try {
      return await compute(parser.parse, bytes);
    } on Object catch (error, stackTrace) {
      talker.error('[Replay] failed to parse $name', error, stackTrace);
      throw const ReplayFileException(.invalidFormat);
    }
  }
}
