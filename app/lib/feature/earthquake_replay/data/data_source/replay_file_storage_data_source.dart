import 'dart:io';
import 'dart:typed_data';

import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_file_storage_data_source.g.dart';

@Riverpod(keepAlive: true)
ReplayFileStorageDataSource replayFileStorageDataSource(Ref ref) =>
    const ReplayFileStorageDataSource();

class const ReplayFileStorageDataSource() {
  // iOS の Documents/Inbox は読み込み後に削除する対象のため、別の名前にする。
  static const directoryName = 'replay';
  static const extension = '.eqrp';

  Future<Directory> directory() async {
    final documents = await getApplicationDocumentsDirectory();
    return Directory(p.join(documents.path, directoryName)).create();
  }

  Future<List<SavedReplayFile>> list() async {
    final dir = await directory();
    final files = [
      await for (final entity in dir.list())
        if (entity is File && entity.path.endsWith(extension))
          await describe(entity),
    ];
    return files..sort((a, b) => b.modifiedAt.compareTo(a.modifiedAt));
  }

  Future<SavedReplayFile> save({
    required String name,
    required Uint8List bytes,
  }) async {
    final dir = await directory();
    final file = File(p.join(dir.path, name));
    await file.writeAsBytes(bytes, flush: true);
    return describe(file);
  }

  Future<void> delete({required SavedReplayFile file}) async {
    final dir = await directory();
    if (!p.isWithin(dir.path, file.path)) {
      throw ArgumentError.value(file.path, 'file', 'Outside of the directory');
    }
    await File(file.path).delete();
  }

  Future<SavedReplayFile> describe(File file) async {
    final stat = await file.stat();
    return SavedReplayFile(
      path: file.path,
      name: p.basename(file.path),
      sizeBytes: stat.size,
      modifiedAt: stat.modified,
    );
  }
}
