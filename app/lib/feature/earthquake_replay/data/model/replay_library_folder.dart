import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay_library_folder.freezed.dart';

/// [directories] は保存先のルートからの相対パス（区切りは `/`）。空のフォルダも含む。
@freezed
abstract class ReplayLibraryContents with _$ReplayLibraryContents {
  const factory({
    required List<SavedReplayFile> files,
    required List<String> directories,
  }) = _ReplayLibraryContents;
}

@freezed
abstract class const ReplayLibraryFolder._() with _$ReplayLibraryFolder {
  /// [files] は下位のフォルダにあるファイルも含む。
  const factory({
    required String path,
    required String name,
    required List<SavedReplayFile> files,
  }) = _ReplayLibraryFolder;

  int get sizeBytes => files.fold(0, (total, file) => total + file.sizeBytes);
}

@freezed
abstract class ReplayLibraryListing with _$ReplayLibraryListing {
  const factory({
    required List<ReplayLibraryFolder> folders,
    required List<SavedReplayFile> files,
  }) = _ReplayLibraryListing;
}
