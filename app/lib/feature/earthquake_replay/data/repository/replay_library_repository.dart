import 'package:eqmonitor/feature/earthquake_replay/data/data_source/replay_device_storage_data_source.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/data_source/replay_file_storage_data_source.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_file_path_resolver.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_library_exception.dart';
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
    );

class const ReplayLibraryRepository({
  required final ReplayFileStorageDataSource storage,
  required final ReplayDeviceStorageDataSource deviceStorage,
  required final ReplayFileRepository files,
  required final ReplayFilePathResolver pathResolver,
}) {
  Future<List<SavedReplayFile>> list() => storage.list();

  Future<DeviceStorage?> readDeviceStorage() async {
    final root = await storage.root();
    return deviceStorage.read(path: root.path);
  }

  Future<Uri?> pick() => files.pick();

  Future<SavedReplayFile> add({required Uri source}) async {
    try {
      final document = await files.loadDocument(source: source);
      final startTime = document.file.header.startTime;
      return await storage.save(
        directory: pathResolver.defaultDirectory(startTime: startTime),
        name: importFileName(name: document.name, startTime: startTime),
        bytes: document.bytes,
      );
    } finally {
      await files.clearPickedFiles();
    }
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

  Future<void> delete({required List<SavedReplayFile> files}) =>
      storage.deleteAll(files: files);
}
