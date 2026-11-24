import 'dart:typed_data';

import 'package:eqmonitor/feature/earthquake_replay/data/data_source/replay_device_storage_data_source.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/data_source/replay_file_storage_data_source.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_file_path_resolver.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_library_browser.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_library_exception.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_library_folder.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_file_repository.dart';
import 'package:native_plugin/native_plugin.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_library_repository.g.dart';

@Riverpod(keepAlive: true)
ReplayLibraryRepository replayLibraryRepository(Ref ref) =>
    ReplayLibraryRepository(
      storage: ref.watch(replayFileStorageDataSourceProvider),
      deviceStorage: ref.watch(replayDeviceStorageDataSourceProvider),
      files: ref.watch(replayFileRepositoryProvider),
      pathResolver: ref.watch(replayFilePathResolverProvider),
      browser: ref.watch(replayLibraryBrowserProvider),
    );

class const ReplayLibraryRepository({
  required final ReplayFileStorageDataSource storage,
  required final ReplayDeviceStorageDataSource deviceStorage,
  required final ReplayFileRepository files,
  required final ReplayFilePathResolver pathResolver,
  required final ReplayLibraryBrowser browser,
}) {
  Future<ReplayLibraryContents> list() => storage.list();

  Future<DeviceStorage?> readDeviceStorage() async {
    final root = await storage.root();
    return deviceStorage.read(path: root.path);
  }

  Future<Uri?> pick() => files.pick();

  /// [directory] が空の場合は、ヘッダの開始時刻の年/月へ保存する。
  Future<SavedReplayFile> add({
    required Uri source,
    required String directory,
  }) async {
    try {
      final document = await files.loadDocument(source: source);
      final startTime = document.file.header.startTime;
      return await storage.save(
        directory: directory.isEmpty
            ? pathResolver.defaultDirectory(startTime: startTime)
            : directory,
        name: importFileName(name: document.name, startTime: startTime),
        bytes: document.bytes,
      );
    } finally {
      await files.clearPickedFiles();
    }
  }

  Future<SavedReplayFile> saveDownloaded({
    required Uint8List bytes,
    required String name,
  }) async {
    final file = await files.parse(bytes: bytes, name: name);
    final startTime = file.header.startTime;
    return storage.save(
      directory: pathResolver.defaultDirectory(startTime: startTime),
      name: importFileName(name: name, startTime: startTime),
      bytes: bytes,
    );
  }

  String importFileName({required String name, required DateTime startTime}) {
    try {
      return pathResolver.fileName(input: name);
    } on ReplayLibraryException {
      return pathResolver.defaultFileName(startTime: startTime);
    }
  }

  Future<SavedReplayFile> move({
    required SavedReplayFile file,
    required String name,
    required String directory,
  }) => storage.move(
    file: file,
    directory: pathResolver.directory(input: directory),
    name: pathResolver.fileName(input: name),
  );

  Future<void> createDirectory({required String directory}) =>
      storage.createDirectory(directory: nonEmptyDirectory(input: directory));

  Future<void> moveDirectory({required String from, required String to}) =>
      storage.moveDirectory(
        from: from,
        to: nonEmptyDirectory(input: to),
      );

  Future<void> moveEntries({
    required List<SavedReplayFile> files,
    required List<String> directories,
    required String destination,
  }) async {
    final target = pathResolver.directory(input: destination);
    for (final directory in directories) {
      await storage.moveDirectory(
        from: directory,
        to: browser.join(
          parent: target,
          child: browser.name(directory: directory),
        ),
      );
    }
    for (final file in files) {
      await storage.move(file: file, directory: target, name: file.name);
    }
  }

  Future<void> delete({
    required List<SavedReplayFile> files,
    required List<String> directories,
  }) async {
    await storage.deleteAll(files: files);
    await storage.deleteDirectories(directories: directories);
  }

  String nonEmptyDirectory({required String input}) {
    final directory = pathResolver.directory(input: input);
    if (directory.isEmpty) {
      throw const ReplayLibraryException(.invalidDirectory);
    }
    return directory;
  }
}
