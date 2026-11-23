import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_library_folder.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_library_browser.g.dart';

@riverpod
ReplayLibraryBrowser replayLibraryBrowser(Ref ref) =>
    const ReplayLibraryBrowser();

class const ReplayLibraryBrowser() {
  ReplayLibraryListing browse({
    required ReplayLibraryContents contents,
    required String directory,
  }) {
    final prefix = directory.isEmpty ? '' : '$directory/';
    final names = {
      for (final path in [
        ...contents.directories,
        for (final file in contents.files) file.directory,
      ])
        if (path != directory && path.startsWith(prefix))
          path.substring(prefix.length).split('/').first,
    }.toList()..sort((a, b) => b.compareTo(a));
    return ReplayLibraryListing(
      folders: [
        for (final name in names)
          ReplayLibraryFolder(
            path: '$prefix$name',
            name: name,
            files: filesUnder(files: contents.files, directory: '$prefix$name'),
          ),
      ],
      files: [
        for (final file in contents.files)
          if (file.directory == directory) file,
      ],
    );
  }

  List<SavedReplayFile> filesUnder({
    required List<SavedReplayFile> files,
    required String directory,
  }) => [
    for (final file in files)
      if (isWithin(path: file.directory, directory: directory)) file,
  ];

  bool isWithin({required String path, required String directory}) =>
      directory.isEmpty || path == directory || path.startsWith('$directory/');

  // 表示中のフォルダが削除や名前の変更で無くなった場合は、残っている上位のフォルダを表示する。
  String existingDirectory({
    required ReplayLibraryContents contents,
    required String directory,
  }) {
    var current = directory;
    while (current.isNotEmpty &&
        !contents.directories.contains(current) &&
        filesUnder(files: contents.files, directory: current).isEmpty) {
      current = parent(directory: current);
    }
    return current;
  }

  String parent({required String directory}) {
    final index = directory.lastIndexOf('/');
    return index < 0 ? '' : directory.substring(0, index);
  }

  String name({required String directory}) =>
      directory.substring(directory.lastIndexOf('/') + 1);

  String join({required String parent, required String child}) =>
      parent.isEmpty ? child : '$parent/$child';
}
