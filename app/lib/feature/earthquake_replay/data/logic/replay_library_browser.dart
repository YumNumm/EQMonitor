import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_library_folder.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_library_browser.g.dart';

@riverpod
ReplayLibraryBrowser replayLibraryBrowser(Ref ref) =>
    const ReplayLibraryBrowser();

class const ReplayLibraryBrowser() {
  ReplayLibraryListing browse({
    required List<SavedReplayFile> files,
    required String directory,
  }) {
    final prefix = directory.isEmpty ? '' : '$directory/';
    final grouped = <String, List<SavedReplayFile>>{};
    for (final file in files) {
      if (file.directory != directory && file.directory.startsWith(prefix)) {
        final name = file.directory.substring(prefix.length).split('/').first;
        grouped.putIfAbsent(name, () => []).add(file);
      }
    }
    return ReplayLibraryListing(
      folders: [
        for (final MapEntry(:key, :value) in grouped.entries)
          ReplayLibraryFolder(path: '$prefix$key', name: key, files: value),
      ]..sort((a, b) => b.name.compareTo(a.name)),
      files: [
        for (final file in files)
          if (file.directory == directory) file,
      ],
    );
  }

  List<SavedReplayFile> filesUnder({
    required List<SavedReplayFile> files,
    required String directory,
  }) => [
    for (final file in files)
      if (directory.isEmpty ||
          file.directory == directory ||
          file.directory.startsWith('$directory/'))
        file,
  ];

  // 表示中のフォルダが削除や移動で空になった場合は、ファイルが残っている上位のフォルダを表示する。
  String existingDirectory({
    required List<SavedReplayFile> files,
    required String directory,
  }) {
    var current = directory;
    while (current.isNotEmpty &&
        filesUnder(files: files, directory: current).isEmpty) {
      current = parent(directory: current);
    }
    return current;
  }

  String parent({required String directory}) {
    final index = directory.lastIndexOf('/');
    return index < 0 ? '' : directory.substring(0, index);
  }
}
