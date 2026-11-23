import 'dart:io';
import 'dart:typed_data';

import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_file_path_resolver.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_library_exception.dart';
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

  Future<Directory> root() async {
    final documents = await getApplicationDocumentsDirectory();
    return Directory(p.join(documents.path, directoryName)).create();
  }

  Future<List<SavedReplayFile>> list() async {
    final root = await this.root();
    final files = [
      await for (final entity in root.list(recursive: true, followLinks: false))
        if (entity is File &&
            entity.path.toLowerCase().endsWith(
              ReplayFilePathResolver.extension,
            ))
          await describe(root: root, file: entity),
    ];
    return files..sort((a, b) => b.modifiedAt.compareTo(a.modifiedAt));
  }

  Future<SavedReplayFile> save({
    required String directory,
    required String name,
    required Uint8List bytes,
  }) async {
    final root = await this.root();
    final target = await resolveDirectory(root: root, directory: directory);
    final file = await availableFile(directory: target, name: name);
    await file.writeAsBytes(bytes, flush: true);
    return describe(root: root, file: file);
  }

  Future<SavedReplayFile> move({
    required SavedReplayFile file,
    required String directory,
    required String name,
  }) async {
    final root = await this.root();
    final source = resolveFile(root: root, file: file);
    final target = File(
      p.join(p.joinAll([root.path, ...directory.split('/')]), name),
    );
    if (!p.isWithin(root.path, target.path)) {
      throw const ReplayLibraryException(.invalidDirectory);
    }
    if (p.equals(source.path, target.path)) {
      return describe(root: root, file: source);
    }
    if (FileSystemEntity.typeSync(target.path) != .notFound) {
      throw const ReplayLibraryException(.nameConflict);
    }
    await target.parent.create(recursive: true);
    final moved = await source.rename(target.path);
    await pruneEmptyDirectories(root: root, directory: source.parent);
    return describe(root: root, file: moved);
  }

  Future<void> deleteAll({required List<SavedReplayFile> files}) async {
    final root = await this.root();
    for (final file in files) {
      final target = resolveFile(root: root, file: file);
      if (target.existsSync()) {
        await target.delete();
      }
      await pruneEmptyDirectories(root: root, directory: target.parent);
    }
  }

  Future<Directory> resolveDirectory({
    required Directory root,
    required String directory,
  }) async {
    final target = Directory(p.joinAll([root.path, ...directory.split('/')]));
    if (!p.equals(root.path, target.path) &&
        !p.isWithin(root.path, target.path)) {
      throw const ReplayLibraryException(.invalidDirectory);
    }
    return target.create(recursive: true);
  }

  File resolveFile({required Directory root, required SavedReplayFile file}) {
    if (!p.isWithin(root.path, file.path)) {
      throw ArgumentError.value(file.path, 'file', 'Outside of the directory');
    }
    return File(file.path);
  }

  // 同じ期間を別の設定で作り直しても、保存済みのファイルを上書きしない。
  Future<File> availableFile({
    required Directory directory,
    required String name,
  }) async {
    final base = p.basenameWithoutExtension(name);
    final suffix = p.extension(name);
    for (var index = 1; ; index++) {
      final file = File(
        p.join(directory.path, index == 1 ? name : '${base}_$index$suffix'),
      );
      if (FileSystemEntity.typeSync(file.path) == .notFound) {
        return file;
      }
    }
  }

  Future<void> pruneEmptyDirectories({
    required Directory root,
    required Directory directory,
  }) async {
    var current = directory;
    while (p.isWithin(root.path, current.path) &&
        current.existsSync() &&
        await current.list().isEmpty) {
      await current.delete();
      current = current.parent;
    }
  }

  Future<SavedReplayFile> describe({
    required Directory root,
    required File file,
  }) async {
    final stat = await file.stat();
    final directory = p.relative(p.dirname(file.path), from: root.path);
    return SavedReplayFile(
      path: file.path,
      name: p.basename(file.path),
      directory: directory == '.' ? '' : p.split(directory).join('/'),
      sizeBytes: stat.size,
      modifiedAt: stat.modified,
    );
  }
}
